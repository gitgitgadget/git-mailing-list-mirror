Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6DEB202A0
	for <e@80x24.org>; Wed,  1 Nov 2017 15:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754676AbdKAPeR (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 11:34:17 -0400
Received: from mout.gmx.net ([212.227.15.15]:59096 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753815AbdKAPeQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 11:34:16 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LeuUB-1dMXVc21z5-00qfBS; Wed, 01
 Nov 2017 16:34:11 +0100
Date:   Wed, 1 Nov 2017 16:34:10 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH 2/2] sequencer: use O_TRUNC to truncate files
In-Reply-To: <6b8e2a79-302e-7e69-00bd-f4643d5195af@web.de>
Message-ID: <alpine.DEB.2.21.1.1711011633520.6482@virtualbox>
References: <6150c80b-cb0e-06d4-63a7-a4f4a9107ab2@web.de> <6b8e2a79-302e-7e69-00bd-f4643d5195af@web.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1614614047-1509550451=:6482"
X-Provags-ID: V03:K0:UOKeOjS8F8Ainuxea3Vyd9/M+m96MALP3VswkNK7XjV952Rnb9R
 KNIn3qL4XBdXNtUwPkJTCjqIL3v2/fUZ8Rzi9qb1kQwcTWRVPBWn9t6Dm+LEaDm7yav5y7k
 e3zGl2Y5yV1HR12FJJTcyeGB/9nssCJ4RBXQEGmUsxlxqfX305GulsJdGe7SXb4QXf17qGw
 MzH6femY7/JT1frgNAP7w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:n0k/RHp5CJU=:5B2iGG5Bz4hR6a+qzBteAh
 UUfLxYzPYj7amlxBGO6VhM3NSLnA8+80yhuQQs9QtglPtZ65JynbMsbQv7O949MQo6jrvMva4
 qj3kQ5pURDvEWeEVL5HorLl/a+1D5XYIulpU6OGPm+TL34hWHdoxd/G0lwUUwsWrKO8FQT1hn
 BZMKgFhyOWDOMfiuPTf8xeONb30Nbbkj61hw2jQ2jxHEVt8inBWV3apDPgXEFqrk7CoLWPHzD
 xuBiDVj2B4xwbnjVVm18jHm6b9Z2FsF+tozq6j9VmZ582l6VWhBoF81IYr2xORFXaghIytj7L
 UFXpY0qwadrxI9M/BOGKPOuLspHLrdu4TKSP2gqsupLuadp8Z303rojKJo08nDFH9Oh0wT0oJ
 Ji0Pbngll64iZlYAcC+DtX/2skfJ/w0D137UrjJqRY5J3Ps3xwUKovApBb/gXcr130T8vkn9a
 Tv3riFPwoOyGE2W37CEmKbgPfonK1EWeq/o/WNSwPte7QAIHec7KFF1UBIzhzJ8Zc2kuJDOXo
 4M/KBzrT8BY2ACxtpahvsPmtmKolSYrqpA26w+5I7E3E0cCEwbPBZ2Glm9yfeOSJ6Fa7S/lm3
 Q5ITlLe8qiN78a1WMiDPeQyg2m6mb6I/sgMhyjGjHziHq3pEgOQ7UazjefCvFJAMGqis1+bfx
 qomjAfSYLIoYWdTFsz8FTAga+zxJ3EyaOdkxmQh7nS0JaJmJuQ+dRWGnwDFB4PBkRC05H8yVO
 1LLYXv3PuaI21PEcAi8XSQlkuD5YkwOGIUgRmeA+z1auBhcqAzFducz/Ov6DFigXRqzHp8/BS
 BXLmTgk3ITZs+cL0cRn6Icy2JS25lJjAZmszzUSS40CXDCy+D6WRqyDjijYG4b6ly79a6rt
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1614614047-1509550451=:6482
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Ren=C3=A9,

On Tue, 31 Oct 2017, Ren=C3=A9 Scharfe wrote:

> Cut off any previous content of the file to be rewritten by passing the
> flag O_TRUNC to open(2) instead of calling ftruncate(2) at the end.
> That's easier and shorter.

Sure.

Thanks,
Dscho
--8323329-1614614047-1509550451=:6482--
