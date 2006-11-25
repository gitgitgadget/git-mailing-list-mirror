X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: Do not use esc_html in esc_path
Date: Sat, 25 Nov 2006 01:45:06 -0800
Message-ID: <7v3b876esd.fsf@assigned-by-dhcp.cox.net>
References: <11644442392444-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 25 Nov 2006 09:45:48 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <11644442392444-git-send-email-jnareb@gmail.com> (Jakub
	Narebski's message of "Sat, 25 Nov 2006 09:43:59 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32272>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gnu6Q-0006dJ-UP for gcvg-git@gmane.org; Sat, 25 Nov
 2006 10:45:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966330AbWKYJpJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 04:45:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966355AbWKYJpI
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 04:45:08 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:63691 "EHLO
 fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP id S966330AbWKYJpH
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 04:45:07 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao09.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061125094506.FFAZ18767.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>; Sat, 25
 Nov 2006 04:45:06 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id qxlE1V00n1kojtg0000000; Sat, 25 Nov 2006
 04:45:15 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> Do not use esc_html in esc_path subroutine to avoid double quoting;
> expand esc_html body (except quoting) in esc_path.
>
> Move esc_path before quot_cec and quot_upr. Add some comments.
>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---
> This patch was send to git mailing list; I don't know if it
> was missed, or rejected.

I do not remember looking at it deeply, so probably it was just
lost in the noise.

Unless there was a list discussion that was unfavorable, that
is; but I do not recall one and the patch looks sane.

