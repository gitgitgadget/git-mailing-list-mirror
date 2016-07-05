Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E0A92023C
	for <e@80x24.org>; Tue,  5 Jul 2016 11:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932882AbcGELcZ (ORCPT <rfc822;e@80x24.org>);
	Tue, 5 Jul 2016 07:32:25 -0400
Received: from mout.gmx.net ([212.227.17.22]:61874 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932699AbcGELcZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2016 07:32:25 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0M0smx-1bZzlG2nwF-00v9Y6; Tue, 05 Jul 2016 13:32:01
 +0200
Date:	Tue, 5 Jul 2016 13:32:00 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Duy Nguyen <pclouds@gmail.com>
cc:	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/9] Report bugs consistently
In-Reply-To: <CACsJy8CobWYjpjkkaG=wFK+zUyF3Z9CtFku7eprnX=_08y6KpA@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1607051330220.8378@virtualbox>
References: <cover.1467199553.git.johannes.schindelin@gmx.de> <8615dc276828a3f99a27ff2eda9909548a7d435e.1467199553.git.johannes.schindelin@gmx.de> <CACsJy8A1ZU8VgBYmQAVC6LmXMVgt5CgvC_w0Y7Y6oX88RFO3dw@mail.gmail.com> <alpine.DEB.2.20.1607020924410.12947@virtualbox>
 <CACsJy8CobWYjpjkkaG=wFK+zUyF3Z9CtFku7eprnX=_08y6KpA@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:WjHHoJUo5UYUzAKpOOngkuIGAHVUvvKEBBtRB1aDo/iYCTQL2fy
 Qd/B0iF94wJL2tXfQ6VUMX+d83+B8lXa+QkfMeL2L5LcpIfBEuwF7sK6h6ZqwIMxi2ii1KJ
 9qbUsa15J12P/x9Dvo0gCX9RG8EfmY6uQys8ZZiTgaE0azZzoAt00XGQShLx4kG8oHfA2JX
 3HoS1vm1rxCXUjmT+OCUw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:YO76ocIFsSE=:qcSonw7N1tE47KW7rqpGQ7
 a2RgqUDEWBQpDU0d2UEP9FyN6rMGn9MWyDMWVcGs9g9yAz02qNQywtxCsHVGzRdT8lQqErMm9
 g5CZSjbvNvCtU05BQk3kHXasOna3g2in/W2qFQnXBQ4O1V5UQzJstIjlRWGXn1H4102BNZ5sB
 prh5j8e9yhCtScKuuicfTBLTKeUAkzvW/RVQGZavPe+D4c1yx0nwR4RMXG57YS7D0g3Q16Kjq
 7Z4Y/fuM89nezZ6LUsoq6QsTdbIt9XVyNEwNoCKFEWTaDffjKApv4VeN4dM3pSpsYeopvsKKq
 BJMinDtYrsItaZeSNmJ+Le3F8FrYduyYSHHHBIdXA99ORU/Q5yfzxh1kj8/608XfCVYUpXOWr
 1AYXUCXFPajEMMhsLen8csF9HZllIhn4ZnFjvKwmfdZ8SbNRujvRTY80mV/WjQOuOGqiT+VV3
 eUH6pozd0+0lUjSdNtY5qbj2fGs74z3uxs6PDkster5j7R3S/88PbZ8trdBXAgF9cQI+ghwkv
 YOj7vRPCtxvj5TIDPg5T9R6xiMstjXoqDAacLhASOhS1v6uq7HAK1c2/d9ECC2Zw3i7hAtad9
 Rxj7HQ4OSXEgJefiHB1XdaBlffv+NqzK6Eqi+2s1ch0qB4vmWwykb7udP15g6EU5p7px1Jh/m
 eCXV3zO9YIkIuSPhy23i65eSRboJBFw74+q+hfzOOSn7w4P1NbTFTbWohNzx+y4vY9+bLSe9B
 DtsfNcX85FZNYsti5zbnFCFva9xwIMOXu23BPGbl2DzPCt4YTI6rFiGWb8pQDSMQthCsOwWEc
 ae6Tipa
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Duy,

On Sat, 2 Jul 2016, Duy Nguyen wrote:

> You're changing the string and adding more work to translators. So
> either leave the string untouched, or drop _().

Thanks. I addressed that concern in v2. Could you please now have a look at
the parts of the patch series which could possibly regress Git's
functionality? I am quite a bit more interested in having extra pairs of
eyes look over those.

Thanks,
Dscho
