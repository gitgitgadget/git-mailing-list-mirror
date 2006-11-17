X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: Cleaning up git user-interface warts
Date: Fri, 17 Nov 2006 01:52:17 +0100
Message-ID: <455D07C1.1090207@xs4all.nl>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org> <87hcx1u934.wl%cworth@cworth.org> <Pine.LNX.4.64.0611141518590.2591@xanadu.home> <87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org> <Pine.LNX.4.64.0611141633430.2591@xanadu.home> <7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611142007010.2591@xanadu.home> <7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611142306090.2591@xanadu.home> <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org> <455BBCE9.4050503@xs4all.nl> <Pine.LNX.4.64.0611151908130.3349@woody.osdl.org> <Pine.LNX.4.63.0611162353250.13772@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0611161508530.3349@woody.osdl.org> <455CFCBD.8040901@xs4all.nl> <Pine.LNX.4.64.0611161623170.3349@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 17 Nov 2006 00:52:49 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
In-Reply-To: <Pine.LNX.4.64.0611161623170.3349@woody.osdl.org>
X-Virus-Scanned: by XS4ALL Virus Scanner
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31650>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gkry5-0003Gg-6q for gcvg-git@gmane.org; Fri, 17 Nov
 2006 01:52:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424823AbWKQAwZ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 19:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424834AbWKQAwZ
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 19:52:25 -0500
Received: from smtp-vbr10.xs4all.nl ([194.109.24.30]:42765 "EHLO
 smtp-vbr10.xs4all.nl") by vger.kernel.org with ESMTP id S1424823AbWKQAwY
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 19:52:24 -0500
Received: from [192.168.123.187] (muurbloem.xs4all.nl [213.84.26.127])
 (authenticated bits=0) by smtp-vbr10.xs4all.nl (8.13.8/8.13.8) with ESMTP id
 kAH0qDPH057142; Fri, 17 Nov 2006 01:52:14 +0100 (CET) (envelope-from
 hanwen@xs4all.nl)
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds escreveu:
> The fact that we can do "git clone" on the _receiving_ side is an 
> assymmetry, but it's not gratutous: when receiving we don't need any extra 
> permissions or setup to create a new archive. In contrast, when sending, 
> you do have to have that "get permission to create new archive" phase.
> 
>>  - pull = merge + fetch, but no command for merge + throw
> 
> Again, this is not gratuitous, and the reason is very similar: when you 
> pull, you're pulling into something that _you_ control and _you_ have 

>But "push" and "pull" _fundamentally_ aren't symmetric operations, and you 
>simply cannot possibly make them symmetric. 

Point taken;  thank you. 

In that case, we're full circle with the command naming issues. Push
and pull are fundamentally asymmetric operations, but then a
consistent UI would dictate that they wouldn't be named symmetrically,
as they are now.


-- 
