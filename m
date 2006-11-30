X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: git blame
Date: Thu, 30 Nov 2006 14:38:04 -0800
Message-ID: <7v64cwh86r.fsf@assigned-by-dhcp.cox.net>
References: <45357CC3.4040507@utoronto.ca> <453F2FF8.2080903@op5.se>
	<200610251146.06116.jnareb@gmail.com>
	<a7e835d40610250308v5d577482m139742e7fe1db185@mail.gmail.com>
	<87slhcz8zh.wl%cworth@cworth.org>
	<a7e835d40610260152k658aeaf0hb900cb63870c04e4@mail.gmail.com>
	<7vu01ro20b.fsf@assigned-by-dhcp.cox.net>
	<a7e835d40610260257r5f05ea4gc934f1c1cc267977@mail.gmail.com>
	<20061026101038.GA13310@coredump.intra.peff.net>
	<877iyne4dm.fsf@alplog.fr>
	<Pine.LNX.4.64.0610260753090.3962@g5.osdl.org>
	<456B7C6A.80104@webdrake.net>
	<Pine.LNX.4.64.0611271834090.30076@woody.osdl.org>
	<456CEF31.8080600@webdrake.net>
	<Pine.LNX.4.64.0611281906520.3395@woody.osdl.org>
	<456D7A76.3080605@webdrake.net>
	<Pine.LNX.4.64.0611290830010.3395@woody.osdl.org>
	<456F21D6.1060200@webdrake.net>
	<Pine.LNX.4.64.0611301034420.3513@woody.osdl.org>
	<87d574u2tl.wl%cworth@cworth.org>
	<Pine.LNX.4.63.0611302314320.30004@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 30 Nov 2006 22:38:25 +0000 (UTC)
Cc: git@vger.kernel.org,
	Joseph Wakeling <joseph.wakeling@webdrake.net>,
	Carl Worth <cworth@cworth.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0611302314320.30004@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 30 Nov 2006 23:17:12 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32821>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpuXi-0007jg-GA for gcvg-git@gmane.org; Thu, 30 Nov
 2006 23:38:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031592AbWK3WiH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 17:38:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031593AbWK3WiH
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 17:38:07 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:64197 "EHLO
 fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP id S1031592AbWK3WiG
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 17:38:06 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao06.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061130223805.LPAP5465.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>; Thu, 30
 Nov 2006 17:38:05 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id tAeE1V0021kojtg0000000; Thu, 30 Nov 2006
 17:38:14 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Thu, 30 Nov 2006, Carl Worth wrote:
>
>> Here's a crazy idea. How about a "git tutorial" builtin or "git example" 
>> or something that would create a repository into some useful state for 
>> demonstrating something.
>
> That sounds fine! Actually, it should be very simple to turn the tutorial 
> into such a script, displaying the command with an explanation, and 
> executing the command. It could even call gitk from time to time, so the 
> user can form a mental model of the ancestor graph.

Doesn't one of our existing t/ scripts do that?
