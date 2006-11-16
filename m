X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: Cleaning up git user-interface warts
Date: Thu, 16 Nov 2006 02:20:41 +0100
Message-ID: <455BBCE9.4050503@xs4all.nl>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org> <87hcx1u934.wl%cworth@cworth.org> <Pine.LNX.4.64.0611141518590.2591@xanadu.home> <87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org> <Pine.LNX.4.64.0611141633430.2591@xanadu.home> <7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611142007010.2591@xanadu.home> <7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611142306090.2591@xanadu.home> <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 16 Nov 2006 01:21:07 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
Original-Newsgroups: gmane.comp.version-control.git
In-Reply-To: <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
X-Virus-Scanned: by XS4ALL Virus Scanner
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31537>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkVw4-00021A-UL for gcvg-git@gmane.org; Thu, 16 Nov
 2006 02:21:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162149AbWKPBU6 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 20:20:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162150AbWKPBU5
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 20:20:57 -0500
Received: from smtp-vbr9.xs4all.nl ([194.109.24.29]:22021 "EHLO
 smtp-vbr9.xs4all.nl") by vger.kernel.org with ESMTP id S1162149AbWKPBU5
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 20:20:57 -0500
Received: from [192.168.123.187] (muurbloem.xs4all.nl [213.84.26.127])
 (authenticated bits=0) by smtp-vbr9.xs4all.nl (8.13.8/8.13.8) with ESMTP id
 kAG1KiDd066910; Thu, 16 Nov 2006 02:20:46 +0100 (CET) (envelope-from
 hanwen@xs4all.nl)
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds escreveu:
>  - git itself has now done it that way for the last 18 months, and the 
>    fact is, the people _complaining_ are a small subset of the people who 
>    actually use git on a daily basis and don't complain.


that's not a good argument; the set of git users is a small subset of 
those that looked at git, and dismissed it because they couldn't wrap 
their heads around it.   It's worth trying to get those on board by 
fixing the annoying little issues that have popped up in this thread. 
The technical base for GIT is excellent, and the only reason for not 
using it is its arcane interface.

A version control system is often only tangentially related to the real 
work that needs to be done, so the incentive to learn it well is small, 
   and a steep learning curve only makes it worse.

FWIW, I regularly mess up with the differences between fetching, pulling 
and merging.  In particular, having to do a two step process to get 
remote changes in,

   git pull url-to-server master:master
      ..error message about not being a fast-forward..

   git pull --update-head-ok url-to-server master:master
      ..still an error message about update not being a fast-forward..

       (sigh)

   git pull url-to-server master:scrap-branch

   git pull . scrap-branch:my-current-branch

       (make mental note of deleting scrap-branch)


-- 
