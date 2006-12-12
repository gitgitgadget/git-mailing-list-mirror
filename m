X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Colourise git-branch output
Date: Tue, 12 Dec 2006 10:43:42 -0800
Message-ID: <7vk60xuf8h.fsf@assigned-by-dhcp.cox.net>
References: <200612120641.52556.andyparkins@gmail.com>
	<457E6C65.4B6D131@eudaptics.com>
	<7vpsapwhl2.fsf@assigned-by-dhcp.cox.net>
	<200612121103.31110.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 12 Dec 2006 18:43:53 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34123>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuCbT-00037s-Kp for gcvg-git@gmane.org; Tue, 12 Dec
 2006 19:43:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932328AbWLLSno (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 13:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbWLLSno
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 13:43:44 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:60466 "EHLO
 fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932328AbWLLSnn (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006
 13:43:43 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061212184343.KLZJ4226.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>; Tue, 12
 Dec 2006 13:43:43 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id xuj41V00h1kojtg0000000; Tue, 12 Dec 2006
 13:43:05 -0500
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> writes:

>> +	"",		/* LOCAL (normal) */
>> +	"\033[32m",	/* CURRENT (green) */
>
> In keeping with the "don't use green" idea - can I suggest just bold normal 
> for the CURRENT?  That way there is the most minimal use of colour for the 
> default git-branch output, but still retaining a visual indicator.

I do not have strong preference either way.

The CURRENT is highlighted with '*' so I think we certainly can
lose green and even go vanilla.  I only tried to avoid bold
because no built-in default coloring currently use it, and in
the past I've worked with terminals that do not have enough
contrast between normal and bold and for some people that might
become an issue.
