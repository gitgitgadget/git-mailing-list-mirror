X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: If merging that is really fast forwarding creates new commit [Was: Re: how to show log for only one branch]
Date: Tue, 07 Nov 2006 17:39:31 +0100
Organization: At home
Message-ID: <eiqcqn$c0$1@sea.gmane.org>
References: <454EAEDB.8020909@gmail.com> <7vk629f6is.fsf@assigned-by-dhcp.cox.net> <454F31D7.1030202@gmail.com> <Pine.LNX.4.64.0611060734490.25218@g5.osdl.org> <45503553.3020605@gmail.com> <Pine.LNX.4.64.0611070729370.3667@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Tue, 7 Nov 2006 16:40:08 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 19
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31076>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhTyx-0008Q1-J8 for gcvg-git@gmane.org; Tue, 07 Nov
 2006 17:39:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964769AbWKGQjY (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 7 Nov 2006
 11:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964990AbWKGQjY
 (ORCPT <rfc822;git-outgoing>); Tue, 7 Nov 2006 11:39:24 -0500
Received: from main.gmane.org ([80.91.229.2]:15800 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S964769AbWKGQjX (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2006 11:39:23 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GhTyZ-0008KP-VX for git@vger.kernel.org; Tue, 07 Nov 2006 17:39:05 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Tue, 07 Nov 2006 17:39:03 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Tue, 07 Nov 2006
 17:39:03 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Linus Torvalds wrote:

> So doing a merge doesn't really "centralize" anything. It just joins the 
> two development threads together in that particular line. If "master" 
> merges the work in "maint", master doesn't really get any more 
> centralized, it just gets the work that "maint" did since last time. And 
> if there was no other work done at all, then the two branches end up 100% 
> identical - there was no "merge" of the work.

By the way, merges happen in _two_ directions. 'Master' merges from 'next'
when 'next' is in sufficiently stable state; 'next' merges from 'master' to
get changes which were considered stable enough to be put into
'master' (and 'master' merges in from 'maint', too).

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

