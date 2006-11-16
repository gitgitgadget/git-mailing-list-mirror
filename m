X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: Cleaning up git user-interface warts
Date: Thu, 16 Nov 2006 17:42:34 +0100
Message-ID: <455C94FA.3050903@xs4all.nl>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org> <87hcx1u934.wl%cworth@cworth.org> <Pine.LNX.4.64.0611141518590.2591@xanadu.home> <87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org> <Pine.LNX.4.64.0611141633430.2591@xanadu.home> <7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611142007010.2591@xanadu.home> <7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611142306090.2591@xanadu.home> <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org> <455BBCE9.4050503@xs4all.nl> <Pine.LNX.4.64.0611151908130.3349@woody.osdl.org> <455C412D.1030408@xs4all.nl> <Pine.LNX.4.64.0611160814560.3349@woody.osdl.org>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 16 Nov 2006 16:44:06 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
Original-Newsgroups: gmane.comp.version-control.git
In-Reply-To: <Pine.LNX.4.64.0611160814560.3349@woody.osdl.org>
X-Virus-Scanned: by XS4ALL Virus Scanner
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31598>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkkK5-0008Hb-Kf for gcvg-git@gmane.org; Thu, 16 Nov
 2006 17:42:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031109AbWKPQmm (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 11:42:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031188AbWKPQmm
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 11:42:42 -0500
Received: from smtp-vbr1.xs4all.nl ([194.109.24.21]:6665 "EHLO
 smtp-vbr1.xs4all.nl") by vger.kernel.org with ESMTP id S1031109AbWKPQml
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 11:42:41 -0500
Received: from [192.168.123.187] (muurbloem.xs4all.nl [213.84.26.127])
 (authenticated bits=0) by smtp-vbr1.xs4all.nl (8.13.8/8.13.8) with ESMTP id
 kAGGgVJx024130; Thu, 16 Nov 2006 17:42:32 +0100 (CET) (envelope-from
 hanwen@xs4all.nl)
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds escreveu:

> So current rule (and this is not new, it's always been true): the ONLY 
> time you use "git init-db" is when you are going to start a totally new 
> project. Never _ever_ otherwise. If you want to track another project, use 
> "git clone".

Actually, only a 2 weeks ago, you suggested that I share the website
and main source code for my project in a single repository for reasons
of organization.

In this setup I find it logical to do

  git init-db
  git pull ..url.. website/master

to wind up with just the 5mb website, instead of the complete 70mb
of packed source code with all of its branches and tags.

> It's not that it isn't typical, it's that you are using the wrong model. 
> Maybe it's not well documented, I can easily give you that, but ALL your 
> problems come from that fundamental starting point: you shouldn't have 
> used "git init-db" in the first place.
> 
> Somebody want to document it?
> 
> Alternatively, we certainly _could_ make "git pull" just accept an empty 
> git repo, and make it basically create the current branch.

Yes, I would like that.  


-- 
