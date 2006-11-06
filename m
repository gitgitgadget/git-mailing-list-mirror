X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Documentation: Transplanting branch with git-rebase --onto
Date: Mon, 06 Nov 2006 14:53:29 -0800
Message-ID: <7v4ptcchli.fsf@assigned-by-dhcp.cox.net>
References: <200611042205.58212.jnareb@gmail.com>
	<7vbqnmwvib.fsf@assigned-by-dhcp.cox.net>
	<200611051122.17623.jnareb@gmail.com>
	<200611061912.46436.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 6 Nov 2006 22:53:42 +0000 (UTC)
Cc: git@vger.kernel.org, Carl Worth <cworth@cworth.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200611061912.46436.jnareb@gmail.com> (Jakub Narebski's message
	of "Mon, 6 Nov 2006 19:12:45 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31029>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhDLT-0004tL-7G for gcvg-git@gmane.org; Mon, 06 Nov
 2006 23:53:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753898AbWKFWxb (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 6 Nov 2006
 17:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753904AbWKFWxb
 (ORCPT <rfc822;git-outgoing>); Mon, 6 Nov 2006 17:53:31 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:15031 "EHLO
 fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP id S1753898AbWKFWxb
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 6 Nov 2006 17:53:31 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061106225330.MYD18180.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>; Mon, 6
 Nov 2006 17:53:30 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id jatb1V0091kojtg0000000; Mon, 06 Nov 2006
 17:53:35 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> Added example of transplantig feature branch from one development
> branch (for example "next") into the other development branch (for
> example "master").
>
> [jn: with a little help from Junio]
>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---
> What about this?

I agree with Carl that the original example of --onto was not
clear why it is a good thing, so I am inclined to follow his
suggestion and drop the original example and keep your second
one yanked from your try#1 patch when committing, if it is Ok
with you.


