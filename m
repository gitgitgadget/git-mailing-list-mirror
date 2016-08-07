Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB7312018E
	for <e@80x24.org>; Sun,  7 Aug 2016 08:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751527AbcHGIti (ORCPT <rfc822;e@80x24.org>);
	Sun, 7 Aug 2016 04:49:38 -0400
Received: from mout.gmx.net ([212.227.15.15]:49328 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751399AbcHGIti (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Aug 2016 04:49:38 -0400
Received: from virtualbox ([37.24.141.218]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0Ln7wj-1b2kJO35VV-00hJku; Sun, 07 Aug 2016 10:49:27
 +0200
Date:	Sun, 7 Aug 2016 10:49:27 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
cc:	Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] use strbuf_addstr() instead of strbuf_addf() with "%s"
In-Reply-To: <57A4F8F7.5020109@web.de>
Message-ID: <alpine.DEB.2.20.1608071048550.5786@virtualbox>
References: <57A4F8F7.5020109@web.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1787086575-1470559767=:5786"
X-Provags-ID: V03:K0:xlbmwsGhacWUxrPt/3muMntxrYBNvFLuTXMNjmEKHTgcM5EbTqC
 ESUMY3g85s6ahw5lVJL66qRHkjZ0ZuyWu8i7NXFmHVh6VYzRc+4xmh5TadAUdz8ks0C9GgE
 QlxPeuUMh5hYpueo5vyYghCTmPRsCfgzfEU8/toacDTsG3+LPSTjuXWancW0dgt07i+EaKn
 8LZVI8CUuclm7BCY+I6dw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:QBnqxj/Ozo0=:1nFhSGdM+FRpma7N5Pc+gO
 vtWP0KWxfz0rfxPgXZDsUO4IrTihi3OScdx7k5doyT+ZwRMPwFJ5BE4WlyzGJixN8sVTo8MPh
 6Edw80Rjtwb3lhLODdnAs/RVYVXVj1tEJ1qPdGHVuR7q88PwFcbrswMMxp9H38/8tWVoch8vJ
 WCjt/uvfhIRPYBrPLTMwr5JLcmGmA+nRWWqoGYG2jSt8WLmghFpOXfAyDgu1lyRplkcW1mjn2
 eiaKt/uQrB2szZE8xLPckOPLYL8Z9MttP5CbFAjWZtlkozfVxO9WfM2wdR4hKLXNrX7X+HDBC
 i7BiH/KYvrHJrGPvAlJtgx8PAfvwf9AgVTmmuFtMj4nfzwnKwLBxr9ZDtSG1eQNBEuddYUZpv
 rbhlfBnTGZzS2HeJbjTiL9nMNk8jMD0VT30UsZqzoBQ7uiQCnakD2nUJAF90HpARoWPPK/pP9
 1+/V++ndxQK5O7xf1Eh+EH1LuG5ldEs1YnAapcK90R1MKUi8yjVyCXxZiSqilS8FO8TJLY+js
 aKDO0od8jIIs5yZrGNKxT+92TywGLq/H+r6QfulF41lCvzAZpDw9P2rTKsQ6HnJuBLVPpZpDN
 bdKT2Zbz+ZskOl4UDTqEjL5m3608e0PVYiBN3IplH3KYTTORa/vbD61rzYA0Q2xf4XgCoQXOK
 RcBrIigj8j7kgk2uaaSq50QOACj3kVKJWNnAd95zYzSqUV07mTsJ2h1x6wtELlV547rDjbvDp
 PXw5SenLHC7W1NyXgMF9zaMtZyjN2z6YLjFYDCnRJID4gdE9eHPhFpLjMLhhz9bcyMAiBoPGT
 8/ziMGn
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1787086575-1470559767=:5786
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Ren=C3=A9,

On Fri, 5 Aug 2016, Ren=C3=A9 Scharfe wrote:

> Call strbuf_addstr() for adding a simple string to a strbuf instead of
> using the heavier strbuf_addf().  This is shorter and documents the
> intent more clearly.

Looks obviously good, thanks!

Ciao,
Dscho
--8323329-1787086575-1470559767=:5786--
