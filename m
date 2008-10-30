From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] Use find instead of perl in t5000 to get file
	modification time
Date: Wed, 29 Oct 2008 22:29:14 -0700
Message-ID: <1225344554.10803.17.camel@maia.lan>
References: <81b0412b0810290338j1beaa25bx9fb373a69f5dfe7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?ISO-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 30 17:46:28 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kvaf2-0000i8-AN
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 17:46:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754496AbYJ3Qo4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 12:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754321AbYJ3Qo4
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 12:44:56 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:53403 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754316AbYJ3Qoy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 12:44:54 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 9B53421CF8E; Fri, 31 Oct 2008 05:44:53 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00,
	DATE_IN_PAST_06_12 autolearn=no version=3.2.5
Received: from [127.0.0.1] (longdrop.musashi.utsl.gen.nz [192.168.253.12])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 0E81621C83C;
	Fri, 31 Oct 2008 05:44:43 +1300 (NZDT)
In-Reply-To: <81b0412b0810290338j1beaa25bx9fb373a69f5dfe7@mail.gmail.com>
X-Mailer: Evolution 2.22.3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99499>

On Wed, 2008-10-29 at 11:38 +0100, Alex Riesen wrote:
> I could not find what exactly does the ActiveState's Perl use for its stat
> implementation (and honestly, have no motivation to look harder).
> It seems to honor TZ, but the produced time does not seem to be either
> local or GMT.

See, the difference is that the perl is portable and your patch isn't.

Can you at least reveal how far out the value printed by the perl
fragment was from the expected value, and what your TZ offset is in
seconds.  It might be pointing to a deeper problem that could affect
more than just this test case.

Sam.
