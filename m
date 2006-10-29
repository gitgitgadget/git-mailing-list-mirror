X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: fetching packs and storing them as packs
Date: Sat, 28 Oct 2006 23:52:54 -0400
Message-ID: <20061029035254.GD3435@spearce.org>
References: <4540CA0C.6030300@tromer.org> <Pine.LNX.4.64.0610271310450.3849@g5.osdl.org> <7v3b99e87c.fsf@assigned-by-dhcp.cox.net> <20061028034206.GA14044@spearce.org> <Pine.LNX.4.64.0610272109500.3849@g5.osdl.org> <7vwt6l9etn.fsf@assigned-by-dhcp.cox.net> <20061028072146.GB14607@spearce.org> <4543DA2E.9030300@tromer.org> <20061029033829.GA3435@spearce.org> <ei18ak$nv4$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 29 Oct 2006 03:53:03 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <ei18ak$nv4$1@sea.gmane.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30411>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ge1jJ-0008IE-2E for gcvg-git@gmane.org; Sun, 29 Oct
 2006 04:53:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964975AbWJ2Dw6 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 28 Oct 2006
 23:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964980AbWJ2Dw6
 (ORCPT <rfc822;git-outgoing>); Sat, 28 Oct 2006 23:52:58 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:3539 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S964975AbWJ2Dw5
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 28 Oct 2006 23:52:57 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Ge1j1-0006YS-MI; Sat, 28 Oct 2006 23:52:43 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 DA6C820E45B; Sat, 28 Oct 2006 23:52:54 -0400 (EDT)
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> wrote:
> Shawn Pearce wrote:
> 
> > Eran Tromer <git2eran@tromer.org> wrote:
> >>
> >> It would be nice to have whoever creates a pack-*.keep file put
> >> something useful as the content of the file, so we'll know what to clean
> >> up after abnormal termination:
> >> 
> >> $ grep -l ^git-receive-pack $GIT_DIR/objects/pack/pack-*.keep
> > 
> > Yes, that's a very good idea.  When I do the git-receive-pack
> > implementation tonight I'll try to dump useful information to the
> > .keep file such that you can easily grep for the stale .keeps
> > and decide which ones should go.
> 
> Perhaps git-count-packs (or enhanced git-count-objects, or git-count-stuff;
> whatever it would be named) could also list (with some option) the reasons
> for packs to be kept...

That would be more like 'git ls-packs' to me, but as Junio pointed
out why add a command just to count packs, and as others have said
recently "Git has too many commands!".

<funny-and-not-to-be-taken-seriously>
I like git-count-stuff.  So generic.  Maybe we can shove
git-pickaxe in as the --count-lines-and-authors-andthings option of
git-count-stuff, seeing as how some people didn't like its name.  :-)
</funny-and-not-to-be-taken-seriously>

-- 
