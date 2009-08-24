Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-0.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,LIST_MIRROR_RECEIVED,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: (qmail 6904 invoked by uid 107); 24 Aug 2009 08:29:17 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.40) with ESMTP; Mon, 24 Aug 2009 04:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751732AbZHXI27 (ORCPT <rfc822;peff@peff.net>);
	Mon, 24 Aug 2009 04:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbZHXI27
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 04:28:59 -0400
Received: from mx2.imag.fr ([129.88.30.17]:55155 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751177AbZHXI26 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 04:28:58 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id n7O8QlOZ002411
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 24 Aug 2009 10:26:47 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MfUuh-0005I6-Q5; Mon, 24 Aug 2009 10:28:27 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MfUuh-00080q-Ol; Mon, 24 Aug 2009 10:28:27 +0200
To:	Sanjiv Gupta <sanjiv.gupta@microchip.com>
Cc:	Kai Blin <kai@samba.org>, Nanako Shiraishi <nanako3@lavabit.com>,
	git@vger.kernel.org
Subject: Re: Pulling one commit at a time.
References: <F536B7C316F9474E9F7091239725AC9A02FA7F44@CHN-CL-MAIL01.mchp-main.com>
	<20090824060710.6117@nanako3.lavabit.com>
	<4A92318F.6050105@microchip.com> <200908240946.52813.kai@samba.org>
	<4A92476A.4060205@microchip.com>
From:	Matthieu Moy <Matthieu.Moy@imag.fr>
Date:	Mon, 24 Aug 2009 10:28:27 +0200
In-Reply-To: <4A92476A.4060205@microchip.com> (Sanjiv Gupta's message of "Mon\, 24 Aug 2009 13\:25\:22 +0530")
Message-ID: <vpqtyzxhaz8.fsf@bauges.imag.fr>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 24 Aug 2009 10:26:47 +0200 (CEST)
X-IMAG-MailScanner-Information:	Please contact MI2S MIM  for more information
X-MailScanner-ID: n7O8QlOZ002411
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check:	1251707208.45102@6rEKwI59/JJrNQaq9sx34w
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Sanjiv Gupta <sanjiv.gupta@microchip.com> writes:

> What I would like is to "test *every* commit" available in the
> public master.

Then, you don't want to _merge_ each of them, you want to _fetch_ and
test each of them (Erik Faye-Lund's reply gives a solution for that).

Fetching is about getting existing commits from another repository,
while merging is about creating new commits.

-- 
Matthieu
