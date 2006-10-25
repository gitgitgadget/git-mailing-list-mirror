X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: (unknown)
Date: Wed, 25 Oct 2006 11:41:02 -0700
Message-ID: <7vk62ob5mp.fsf@assigned-by-dhcp.cox.net>
References: <E1Gck4m-0003J1-00@dvr.360vision.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 25 Oct 2006 18:41:28 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <E1Gck4m-0003J1-00@dvr.360vision.com> (andyparkins@gmail.com's
	message of "Wed, 25 Oct 2006 15:49:52 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30088>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gcngc-00077A-E3 for gcvg-git@gmane.org; Wed, 25 Oct
 2006 20:41:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964798AbWJYSlH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 14:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932295AbWJYSlH
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 14:41:07 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:1496 "EHLO
 fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP id S932280AbWJYSlE
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 14:41:04 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao05.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061025184103.XCLH12909.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>; Wed, 25
 Oct 2006 14:41:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id eigm1V00E1kojtg0000000 Wed, 25 Oct 2006
 14:40:46 -0400
To: andyparkins@gmail.com
Sender: git-owner@vger.kernel.org

andyparkins@gmail.com writes:

> From b149c0fca7399030225750958bf5c962c3796b44 Mon Sep 17 00:00:00 2001
> From: Andy Parkins <andyparkins@gmail.com>
> Date: Wed, 25 Oct 2006 15:49:50 +0100
> Subject: [PATCH] Make new builtin cherry match documentation for "+" and "-"
> To: git@vger.kernel.org
> X-TUID: 218b478df3f8d847
> X-UID: 128
> X-Length: 1090
> MIME-Version: 1.0
> Content-Transfer-Encoding: 7bit
> Content-Disposition: inline
> Message-Id: <200610251549.51121.andyparkins@gmail.com>

I'd be commenting on your patch but won't be able to take any of
them until these "Subject: (unknown)" are corrected.

> "+" and "-" don't match the documentation, where "+" means the patch /is/ in
> upstream, "-" means it isn't

The documentation was utterly wrong.  The comment at the
beginning of git-cherry.sh was better but slightly wrong.

I have a few fixes queued but I was busy for the last couple of
nights and haven't pushed them out.
