Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B77F1F454
	for <e@80x24.org>; Fri, 18 Jan 2019 08:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfARIlQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 03:41:16 -0500
Received: from mout.gmx.net ([212.227.15.15]:37279 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbfARIlQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 03:41:16 -0500
Received: from [10.49.182.9] ([95.208.59.217]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Llm9w-1hJTTp27Yu-00ZOSq; Fri, 18
 Jan 2019 09:41:09 +0100
Date:   Fri, 18 Jan 2019 09:40:53 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 5/5] travis-ci: build with the right compiler
In-Reply-To: <20190117145612.GL840@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.1901180940280.41@tvgsbejvaqbjf.bet>
References: <20181220162452.17732-1-szeder.dev@gmail.com> <20190117012913.30562-1-szeder.dev@gmail.com> <20190117012913.30562-6-szeder.dev@gmail.com> <nycvar.QRO.7.76.6.1901171439280.41@tvgsbejvaqbjf.bet> <20190117145612.GL840@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-637146529-1547800869=:41"
X-Provags-ID: V03:K1:2aLb3gqKTjZAbiLGJyAz1+Fqn9sz9/xnz+rq6dVX88Py3N3alD9
 BxlP8AsS7Hb/phSsC9PPPyK6NwdZgMMzOnZOYWZmND6/SkLtCW0lWKe8sSQWYtKq2rge0rQ
 2rdWUhXDMUYLpm10tyO+jLmzXxCZtQh/IG6O02032IFzfClXILZU4pVyr3URwkN9eJBSYEX
 8SB10gGUiiN5JFPfXHYeg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yRGvUdq9jKA=:1++Xa8g/0+eTrGbOYuBdeF
 9Tgw3o41rnAP/MHJhmMAgCQnIhwLIeJkXNV0WbGQ4Fx4BJAaLPru4MXuQo8vRsVz3WxybI14n
 7c9bxeXUEMPj+3+VabRbvL6i0WlKbUr2EtBYURKIM57+hWrJtHRNug42+ra+2a3W2P/Z0/ikh
 F1o0+1E9HlHpHDkODV5iGfH4mt9jfAeNiEqam0Cm4j40Sel6ZNsiTjJy82CZSGfds6TWED10y
 Pl/RR9TYZDmRvn+5D0P6f/XXOmp+JxMk9WzLYN59mQKLz4mAwnNwgyOVwI3H7Bye2w0FCNqX9
 ffb7ZpwGtchJbBz06RQkGxqMMl3qWb+w8+9RzdmfitkALmG8DCXiCARrw6W7aEoZ8fXuovyff
 3XZjP3sVhSpe+VdeXGXo/y/dHenWhFx/xrmkhT3ALMg3eXL/1/5aqAZ4+H5GTDnbNfSDXc8Od
 9kBynpeb84ZbZLIq2YNhR1s0CUIEhtm47BJt2acedIqnjokr5TVpqUYiTLS2nH61Yi50OBBQn
 NTHDQy2qtmHHhpyTy8g5oN3YX09reMJ+WjcmYQH2nEb0oE/8FsQeXdSnSssgL8lZPIFcEYvG+
 uuQQGSGw3XRiqOrGIq37LYB0hvlBiN1tirr5DsUBy+1Ag4y/07dssMWuVh2VxCVxz2kGH8uZG
 UGR0wK/vZqy7F5PkN+4nyR7KgDHE31V0YpA3Q3gXVpprFtxQKtJPQ2X92Kc/QCjtrBQFJyNNY
 l8ZQtxELUe5XhZB5J1bKdmmdNfliUgyMz4m5B57OLxdrIYw3+84Hu08Q0W6MO3HsMSz5D7c9z
 ub40vQIDAYxuhPVcPMSjHSsw/abVhJ4QfLMXkp8crxfYWnpq6E/oZedjlq8k8GO2imMY5GCum
 Bo/l0budeqsvr6CyzDK/HRumZ5XmiRarlT7kdUdLA3jOYUPUVxJL0qiVFnLGM8tyRt5UmA+6l
 eDk5pR+WoBw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-637146529-1547800869=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Gábor,

On Thu, 17 Jan 2019, SZEDER Gábor wrote:

> Here are the most interesting bits of the problematic build jobs, i.e.
> the compiler versions from that debug patch:
> 
>   linux-clang:  https://travis-ci.org/szeder/git/jobs/480654257#L824
>   osx-gcc:      https://travis-ci.org/szeder/git/jobs/480654264#L824

Thanks!
Dscho
--8323328-637146529-1547800869=:41--
