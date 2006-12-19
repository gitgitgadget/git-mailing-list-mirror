X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix documentation copy&paste typo
Date: Tue, 19 Dec 2006 09:27:57 -0800
Message-ID: <7vac1jre1u.fsf@assigned-by-dhcp.cox.net>
References: <11655782712452-git-send-email-zeisberg@informatik.uni-freiburg.de>
	<20061219141618.GA2539@cepheus>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Tue, 19 Dec 2006 17:28:27 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061219141618.GA2539@cepheus> (Uwe =?iso-8859-1?Q?Kleine-K?=
 =?iso-8859-1?Q?=F6nig's?= message of
	"Tue, 19 Dec 2006 15:16:18 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34836>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwilK-0003Lp-Ku for gcvg-git@gmane.org; Tue, 19 Dec
 2006 18:28:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932850AbWLSR2D convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006 12:28:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932852AbWLSR2C
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 12:28:02 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:60377 "EHLO
 fed1rmmtao06.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932850AbWLSR2A convert rfc822-to-8bit (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006 12:28:00 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao06.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061219172759.DLJL2628.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>; Tue, 19
 Dec 2006 12:27:59 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id 0hUB1W00k1kojtg0000000; Tue, 19 Dec 2006
 12:28:12 -0500
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
 <zeisberg@informatik.uni-freiburg.de>
Sender: git-owner@vger.kernel.org

Uwe Kleine-K=F6nig <zeisberg@informatik.uni-freiburg.de> writes:

> I get:
>
> 	0000160: 6569 6e65 2d4b 1b2c 4143 361b 2842 6e69 eine-K.,AC6.(Bni
>
> That is, the '=F6' became 8 byte long.  Can you tell me what went wro=
ng
> there?

Me, keyboard and Emacs screwed up and stored it in ISO-2022
instead of UTF-8.  Sorry.

