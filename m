X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: egit/jgit wishlist
Date: Mon, 4 Dec 2006 13:05:53 -0500
Message-ID: <20061204180553.GF6011@spearce.org>
References: <20061204172836.GB6011@spearce.org> <457461BF.6080706@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 4 Dec 2006 18:06:11 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <457461BF.6080706@midwinter.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33211>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrICZ-00014T-1x for gcvg-git@gmane.org; Mon, 04 Dec
 2006 19:06:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936629AbWLDSGA (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 13:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936651AbWLDSGA
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 13:06:00 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:39347 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S936629AbWLDSF7 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006
 13:05:59 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GrIDC-00026p-7b; Mon, 04 Dec 2006 13:06:42 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 D1A3A20FB7F; Mon,  4 Dec 2006 13:05:53 -0500 (EST)
To: Steven Grimm <koreth@midwinter.com>
Sender: git-owner@vger.kernel.org

Steven Grimm <koreth@midwinter.com> wrote:
> My usual git working style is to not switch branches with a dirty 
> working directory; I always commit to the current branch before 
> switching to a new one. I mention that because I assume it'll be easier 
> to implement that workflow first; once you have commit capability, you 
> can do that style of branch switching (either preventing the switch or 
> doing an implicit commit when the working directory is dirty) without 
> having to worry about merging.

It is easier to code.  :-)

But users have come to expect the three-way merge during branch
switches.  I actually get ticked when it fails, because that is
usually when I need it most.  Anyway, I also know a number of
Eclipse users who also use Git that would prefer it if the switch
fails on a dirty working tree, as that usually just means they
forgot to commit their changes first.
 
> And finally, it would be swell -- but put it at the bottom of your 
> priority list -- to have git-svn interoperability; sadly most of my git 
> usage at the moment is in cloned svn repositories and it would be great 
> if egit could do the right thing when the current git repo is cloned 
> from svn. What "the right thing" is, exactly, is debatable, but I 
> suppose some kind of integration with the Subclipse plugin is one 
> possibility (and if nothing else, that plugin probably has code that can 
> be reused.) I'd like to be able to update from and commit to the parent 
> svn repository.

SVN integration is probably out of scope for the plugin (at least
right now) but I won't reject any reasonable patches!  (hint hint)
:-)

-- 
