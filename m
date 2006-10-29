X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: fetching packs and storing them as packs
Date: Sun, 29 Oct 2006 04:48:36 +0100
Organization: At home
Message-ID: <ei18ak$nv4$1@sea.gmane.org>
References: <Pine.LNX.4.64.0610252333540.12418@xanadu.home> <4540CA0C.6030300@tromer.org> <Pine.LNX.4.64.0610271310450.3849@g5.osdl.org> <7v3b99e87c.fsf@assigned-by-dhcp.cox.net> <20061028034206.GA14044@spearce.org> <Pine.LNX.4.64.0610272109500.3849@g5.osdl.org> <7vwt6l9etn.fsf@assigned-by-dhcp.cox.net> <20061028072146.GB14607@spearce.org> <4543DA2E.9030300@tromer.org> <20061029033829.GA3435@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Sun, 29 Oct 2006 03:49:12 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 24
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-18-116.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30409>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ge1fZ-0007YC-0P for gcvg-git@gmane.org; Sun, 29 Oct
 2006 04:49:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964977AbWJ2DtF (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 28 Oct 2006
 23:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964980AbWJ2DtF
 (ORCPT <rfc822;git-outgoing>); Sat, 28 Oct 2006 23:49:05 -0400
Received: from main.gmane.org ([80.91.229.2]:7641 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S964977AbWJ2DtC (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 28 Oct 2006 23:49:02 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Ge1fJ-0007Vl-1X for git@vger.kernel.org; Sun, 29 Oct 2006 04:48:53 +0100
Received: from host-81-190-18-116.torun.mm.pl ([81.190.18.116]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sun, 29 Oct 2006 04:48:53 +0100
Received: from jnareb by host-81-190-18-116.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sun, 29 Oct 2006
 04:48:53 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Shawn Pearce wrote:

> Eran Tromer <git2eran@tromer.org> wrote:
>>
>> It would be nice to have whoever creates a pack-*.keep file put
>> something useful as the content of the file, so we'll know what to clean
>> up after abnormal termination:
>> 
>> $ grep -l ^git-receive-pack $GIT_DIR/objects/pack/pack-*.keep
> 
> Yes, that's a very good idea.  When I do the git-receive-pack
> implementation tonight I'll try to dump useful information to the
> .keep file such that you can easily grep for the stale .keeps
> and decide which ones should go.

Perhaps git-count-packs (or enhanced git-count-objects, or git-count-stuff;
whatever it would be named) could also list (with some option) the reasons
for packs to be kept...

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

