Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD1762018E
	for <e@80x24.org>; Sun,  7 Aug 2016 08:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751646AbcHGIxv (ORCPT <rfc822;e@80x24.org>);
	Sun, 7 Aug 2016 04:53:51 -0400
Received: from mout.gmx.net ([212.227.17.22]:60915 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751629AbcHGIxu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Aug 2016 04:53:50 -0400
Received: from virtualbox ([37.24.141.218]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0M2L60-1bDPVT0Aq4-00s9uZ; Sun, 07 Aug 2016 10:53:35
 +0200
Date:	Sun, 7 Aug 2016 10:53:34 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
cc:	Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] use strbuf_add_unique_abbrev() for adding short hashes
In-Reply-To: <57A6050D.50200@web.de>
Message-ID: <alpine.DEB.2.20.1608071051540.5786@virtualbox>
References: <57A6050D.50200@web.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-716803516-1470560015=:5786"
X-Provags-ID: V03:K0:TTUZw89y+CQwU5qB0YZpWz863N8fxKiHtTWAxLjSLF4cZF3UrAa
 fh2J9rQ9RkGLRj5xuNlokpRo+eAMtGAEF6e0aOVCq76/v4hK7k7+cb99h13abMlvrLX0usP
 l8G89Onp7qSXHzx8AQzkSJEjruaNgOvrGBf49/xGk+yhZceWOlrtCXpXq9kKLAAl1qEx1QS
 1Z3AF/OiEbdnnezeYe8pA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:HahDhu32TPE=:SqJ5v4zcoZT2Prf7vjfe7B
 R17Syw+5VzKGDi4WdSIxH5nMbVKpMN5FAAvxNAf+c9ezwPDSaR/vhan6JTlEj2cmG53mW7G79
 h4NqV2xaLqTtshEq3wze4a4CADcWHS5+xUypZwNHYB7727H1TXUT0x7Bra7XAcTmT/DBzg/qH
 up6W2iPUuho8+a+ol0GkD8uFZ/x9YPqhQweEIOXdQh8w7/66fIhSweI4UNcQxgtZkbTxHl6y0
 REgk/eqR9yAPRI5ds4focBH3Dul5gLZjqIQEZGtDHRkZ4B4od5oBlr64CT1QiAWozAvViSWY3
 xpryveL7oKvXutdK0lIv1PX74c9g8jrjxi7Gqi57Ch2GzWiQz0sLqhd7EYqY4SPaJvHTKT8nM
 NzgsXNqDxZVecdcw5o0Y+8KcOsSy45ap0SblI0oPbQ9Wf8d0lQ4bRAdBPD8wZH9vbztaVBrBg
 kmWKTdtYtQTrqkUL99dC7rMfSaReVbVQKtMrClIVrTxZC2DCasI+8PLVjzEAK9QHGp65XyFpJ
 YH2TAaBGHDqVpF1N7U/O9vRXfv+iT6j2mMqdaVAMz4qBpmGFlcwhCqljioFMsJiJsD4D8+TtM
 Mvta+IHsFJ0d2cThrHCeCz85rybaFCsGD7H2NaOf4gocSdMR9IndYVBztVpTBHdZj4IxE4X2b
 ZJWrbEMcqR72hyFeyBxWgHEe/0vuRiYvBHwUK0FKi25HPf2YpIKAV5wUqvrFOZW+YwKMux9ox
 cjJP7RewO4Q8mv2z7GX/XTUFhq8yzQY1iorIRdn7qRSYEXETTKGleutn3hydmvUNE0JgA4cFw
 ghfAOmW
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-716803516-1470560015=:5786
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Ren=C3=A9,

On Sat, 6 Aug 2016, Ren=C3=A9 Scharfe wrote:

> Call strbuf_add_unique_abbrev() to add abbreviated hashes to strbufs
> instead of taking detours through find_unique_abbrev() and its static
> buffer.  This is shorter and a bit more efficient.

And less error-prone.

It is also a thing I need to change in my upcoming rebase--helper patches:
I had not known about this function.

Thank you,
Dscho
--8323329-716803516-1470560015=:5786--
