X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: Move git_get_last_activity subroutine earlier
Date: Sat, 28 Oct 2006 12:01:56 -0700
Message-ID: <7vvem48dsr.fsf@assigned-by-dhcp.cox.net>
References: <200610281943.40456.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 28 Oct 2006 19:02:30 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200610281943.40456.jnareb@gmail.com> (Jakub Narebski's message
	of "Sat, 28 Oct 2006 19:43:40 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30387>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdtRR-0003gw-Mx for gcvg-git@gmane.org; Sat, 28 Oct
 2006 21:02:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751353AbWJ1TB6 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 28 Oct 2006
 15:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbWJ1TB6
 (ORCPT <rfc822;git-outgoing>); Sat, 28 Oct 2006 15:01:58 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:62960 "EHLO
 fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP id S1751353AbWJ1TB5
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 28 Oct 2006 15:01:57 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao03.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061028190157.HZYR2704.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>; Sat, 28
 Oct 2006 15:01:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id fv201V00W1kojtg0000000 Sat, 28 Oct 2006
 15:02:01 -0400
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Why is this needed?
