X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] make 'git add' a first class user friendly interface to the index
Date: Sat, 02 Dec 2006 18:12:55 +0100
Organization: At home
Message-ID: <eksc35$fji$1@sea.gmane.org>
References: <Pine.LNX.4.64.0612011444310.9647@xanadu.home> <7vpsb36yem.fsf@assigned-by-dhcp.cox.net> <87veku3i0j.wl%cworth@cworth.org> <200612020828.57989.alan@chandlerfamily.org.uk> <87psb22qgu.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Sat, 2 Dec 2006 17:11:58 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 30
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33029>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqYOv-00085U-Ub for gcvg-git@gmane.org; Sat, 02 Dec
 2006 18:11:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424231AbWLBRLn (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 12:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424237AbWLBRLn
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 12:11:43 -0500
Received: from main.gmane.org ([80.91.229.2]:7315 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1424231AbWLBRLm (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 12:11:42 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GqYOZ-00080B-Tf for git@vger.kernel.org; Sat, 02 Dec 2006 18:11:24 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sat, 02 Dec 2006 18:11:23 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sat, 02 Dec 2006
 18:11:23 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Carl Worth wrote:

> If git's model imposes the requirement, "we should first teach one
> thing, then move on to teach a subsequent thing", it would be just
> that much nicer if the commands themselves could help us do that,
> (because the default would do the thing they would need first, and
> then the user has to explicitly do _something_ else to get the
> subsequent thing).
> 
> See? I'm just trying to make the command set more naturally provide
> the same flow of learning that we've been proposing for the tutorial.

Not exactly. For example more user-friendly is "mv -i" than "mv",
but noone proposes to make "mv -i" default (well, you can alias
"mv" to "mv -i" in shell, while you cannot alias "commit" to "commit -a"
in git).

So i think having the default geared towards advanced users and not
newbie users is O.K.

By the way, I find it a bit annoying that "git commit" outputs
git-status output (possibly multi-line if you have many untracked
but unignored files in working area) before "nothing to commit".

P.S. Is there a difference between "git commit ." and "git commit -a"?
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

