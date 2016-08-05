Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EBD62018E
	for <e@80x24.org>; Fri,  5 Aug 2016 15:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759927AbcHEPOr (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 11:14:47 -0400
Received: from mout.gmx.net ([212.227.15.19]:61565 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759909AbcHEPOp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 11:14:45 -0400
Received: from virtualbox ([37.24.141.218]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0Mda8q-1bsrTJ2dzA-00PNNl; Fri, 05 Aug 2016 17:13:53
 +0200
Date:	Fri, 5 Aug 2016 17:13:50 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Duy Nguyen <pclouds@gmail.com>
cc:	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: patch submission process, was Re: [PATCH v6 06/16] merge_recursive:
 abort properly upon errors
In-Reply-To: <CACsJy8Bzcwfvhc9dQ2EehmAJ+kGwC5VHL4d+4Z-GfmM6e2+3wg@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1608051713090.5786@virtualbox>
References: <cover.1469547160.git.johannes.schindelin@gmx.de> <cover.1470051326.git.johannes.schindelin@gmx.de> <8ff71aba37be979f05abf88f467ec932aa522bdd.1470051326.git.johannes.schindelin@gmx.de> <xmqqlh0gjpr6.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1608021004080.79248@virtualbox> <xmqqy44ec15p.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608031021050.79248@virtualbox> <CAPc5daXJzMsJf5K84XBFuQ5=q_OwtYUW2FikZ2QsZWk8fa9jgg@mail.gmail.com> <alpine.DEB.2.20.1608031753431.107993@virtualbox>
 <CACsJy8Bzcwfvhc9dQ2EehmAJ+kGwC5VHL4d+4Z-GfmM6e2+3wg@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:mYR23jjN7+CtFcUhgOtiQHumYCT317x653BFjwdH5hk6I1hw6bY
 qv7fAcEjFjsEDq/Ff33yT+pZf25Jm5VQrjVJMfaSqRrdpQC+a9TkKQfvKk4zsqYCaWqVtpZ
 qPULjLmUvZsaREycfIoDY14c0mM+UjI+NTEzuw91Z6BzO8uChU9ukOkFNuCS/CYmc9qfG8c
 fsEE0IueZyhPFsgWlANpA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:A0cqn863Y8k=:qqM9F1kvEHl2nlxlgFLtga
 OFATRWblhK+O4QCemdPjsInN9cI4UcFjpCIpQSYcLrfG2/FKut8PGDB62bcYHGseeBSlRoj0I
 FFSsdb8gHK6E09R0khyALIYR77m2d4wiryyMRSYBxQZCOnSK7herZbjW34e8BPfxlp68cD5m0
 uxBTzLN4VkynOcyfhJa5P7ceT+NQUmX8pBvSd95Na4LPJybNqXBrMGhi2csHsFgGSQI25+NRE
 tNG5z7tVfzpck+iXGFo/u8RSKRAVW3OpkNMZ+suvOIHk04OgBeLtU/YtdjtckV02N+ugLT+7W
 0BJsyHUgH2UIpBGflRQVayX8WiNJB2qcbprfZdMY3UGKawQDTY4D23Ltth12uB2lwWIxkyatk
 /J1GYXC5gSCpl4UD2DLc9b1+gh5hnA59hg58zBDAgUGaGME4zVpiJS7xbKFFgMUHGKxjU9+c+
 QdRFWVAVFZ4QsCK339lr19FxEMql70ZXJ9hzepjNb38nws/dJkXu7CVCqM+hu0iJyFp/3bjgv
 B5meoAPX4kZ5NiNT1wSVbFmR35DuZzh34tAWbfLXgwELsg1hzhC8hegocdps87GtL99IQums9
 8olX7+bz2UVriBV7HR901kUpn4cEBtSC28Oc/XDgakFFC9cMcRZTRtOc5ewkht0wRSxvgOj/E
 q6xa5ZB8rMPzQEWLazLF7dzGgN9em1ghT14o8d4hYb+qsnl85074L0OaVCpcXQeUtImrOCe0J
 vG5XkklFRFTbzLUlD+dLHvWp5Z4V4wJQg/EEYS5tXLjrKYuUlhHmxU+1G47s1S1SoKYfpDFVa
 5O+yL8b
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Duy,

On Fri, 5 Aug 2016, Duy Nguyen wrote:

> On the topic of fixup and squash and everything. Is anyone else
> annoyed that the commit title is taken for fixup!, squash!
> instructions?

I do not know about others, but I am not annoyed by those commit titles. I
think they make tons of sense.

Ciao,
Dscho
