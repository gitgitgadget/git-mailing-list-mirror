X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git
Date: Sun, 05 Nov 2006 10:47:42 -0800
Message-ID: <7vlkmpu3w1.fsf@assigned-by-dhcp.cox.net>
References: <7vk62ewtxd.fsf@assigned-by-dhcp.cox.net>
	<454E1E69.2040209@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 5 Nov 2006 18:47:55 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <454E1E69.2040209@lsrfire.ath.cx> (Rene Scharfe's message of
	"Sun, 05 Nov 2006 18:24:57 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30978>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ggn23-00043n-6Q for gcvg-git@gmane.org; Sun, 05 Nov
 2006 19:47:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161495AbWKESro (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 5 Nov 2006
 13:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161499AbWKESrn
 (ORCPT <rfc822;git-outgoing>); Sun, 5 Nov 2006 13:47:43 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:31209 "EHLO
 fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP id S1161495AbWKESrn
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 5 Nov 2006 13:47:43 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao02.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061105184743.OSZD12581.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>; Sun, 5
 Nov 2006 13:47:43 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id j6nn1V00r1kojtg0000000 Sun, 05 Nov 2006
 13:47:48 -0500
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org

Rene Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Junio C Hamano schrieb:
>>   git-branch and git-cherry are now built-in.
>
> Yes, but git-cherry.sh still exists in master (but not in next).
> Intentionally?

Thanks for catching this; it was a mismerge in commit 56532fa1.

