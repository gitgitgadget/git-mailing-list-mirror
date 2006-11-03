X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] for-each-ref: "creator" and "creatordate" fields
Date: Thu, 02 Nov 2006 18:40:33 -0800
Message-ID: <7vmz79l0bi.fsf@assigned-by-dhcp.cox.net>
References: <200610281930.05889.jnareb@gmail.com>
	<7vslh86uz9.fsf@assigned-by-dhcp.cox.net>
	<200611022017.31351.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 3 Nov 2006 02:48:30 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30770>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gfp2D-0003wO-0I for gcvg-git@gmane.org; Fri, 03 Nov
 2006 03:44:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752972AbWKCCkh (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 21:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752978AbWKCCkg
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 21:40:36 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:9348 "EHLO
 fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP id S1752969AbWKCCke
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 21:40:34 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao11.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061103024034.MCAC13992.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>; Thu, 2
 Nov 2006 21:40:34 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id i2gC1V00f1kojtg0000000 Thu, 02 Nov 2006
 21:40:13 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> From fa1a32c9a7c8a31b122df7d07f4a8885cbe120d0 Mon Sep 17 00:00:00 2001
> From: Junio C Hamano <junkio@cox.net>
> Date: Sat, 28 Oct 2006 13:33:46 -0700
> Subject: [PATCH 1/2] for-each-ref: "creator" and "creatordate" fields
>
> This adds "creator" (which is parallel to "tagger" or "committer")
> and "creatordate" (corresponds to "taggerdate" and
> "committerdate").

The first line should not be in the message.  I agree that it is
sensible not to call this "epoch", and "creator" is fine by me.

Thanks.  Will apply.
