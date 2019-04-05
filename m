Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98A3F20248
	for <e@80x24.org>; Fri,  5 Apr 2019 20:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfDEUHz (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 16:07:55 -0400
Received: from mout.gmx.net ([212.227.15.19]:47273 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbfDEUHz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Apr 2019 16:07:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1554494843;
        bh=9jpmsBAadJ/hdv6V5PHuULF+XeAauqlXOXhAR2FG84Y=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=NJTVXe5WsOHUTFihm7p6MiawVhCIpSonbgpOQKuyXD8jA6Goh1VWYoJyUw2fwoQ6Q
         PGksxPfnhLYvpGs1BV5dcEi+WQ5cp6HCx4UMOCxT9wBB/hUUZODEFkLxT+yzjVJGdq
         m4a6ALtU/rdokycjmCVrJ4eqM0LUFBH4J+4sDQaY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MF5FT-1h9Qy80yYF-00GMIY; Fri, 05
 Apr 2019 22:07:23 +0200
Date:   Fri, 5 Apr 2019 22:07:22 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Christian Couder <christian.couder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH v4 00/11] Many promisor remotes
In-Reply-To: <xmqq36mygrn7.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1904052206400.41@tvgsbejvaqbjf.bet>
References: <20190401164045.17328-1-chriscool@tuxfamily.org> <xmqq36mygrn7.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:/Jr/7EjNi+vqYGL0LwS5i7HsmKNV1ro0ZffyRU17kgZABtyn4iX
 msXdMeSTt1qnaWb2DOK5/ij5hhQZkDk2kEoGrRjyx3lB3d8Muujxym44AIyjshrB6bdQrqX
 PPWPJdluMYzHmVVArSAh1NX+rJEYFA1H13QZ0WrXrWTnnwz4vHFesKZK9HzH20a8AhFgA5L
 FOCHZJdX2gFr9IjJ2tlRg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:D/7p6l6x9JU=:OXHN4dJ6c4axh9axaHGw0o
 0XmEvsjXxM1+ax9z/UtJUldS9ff71rsdWCLDcXBBBfjZx10NWHn5Yj1ZJXIwFUn6yqMeYkGtn
 EPvWIlWw8LdSz26O5n4TRLvHhGivYrl6PZOck92MefDkNGeTTYyJDjxWMUzCk5lxj9XOVw1+t
 bxrKVsHKYjhg0WnH1oHO9h973BX8PmVgOJf4tSpHY2jFlJx768zF5BxZotA+CBZsix+r00RKZ
 JrlpdIxu1djKcSYYtVZ7qUj53WWdHNcjZC2Ow5KuYFUPJHkK5X4tahw/R79GnbEKbH+f+BkQw
 BUWlNU/As1e5ZjBTREwP5FCCa+hR+TKRZiJDSSQOcnyFsIFY9IV7ZXgD8kQ95ml/mXj9ncxgf
 091Ax40RNtXimFasAKFlV+5G9L7Y6LWRV7SAbQgu4qTdvXACJg8xnd3zNXniL6sHFOTURmqEE
 N1O/FYFVR7FVjepyVzUOgRPCbeSu++sNEKQcxiKXp6AnN3y/l2YaYhHZVbxS37fkv+KukgslM
 YezXyZubVQwYZ2xjmTSNkB3blj9lYxfOD/ZJv1Gc6UiZUTptiztsljh6JMu3m3ScYnDK0/o8S
 OAhOXjuAWH74idRU6DkOgLuaQqJgjnGIgCiIJZF/NSY6xA0hNuUM+yQgNcCT5rgcDR4u1EohD
 FtrvhIYNv1TbEIOd74peKinerQKTvmmWrbBva+bkD5p82IY8+r0gR60F1JxpQH6sLYO8ZNHe5
 UlcvkyymFFsL1itEUlq3IPljeTNS4pShF88MmqA5VHuHOkkviQWYhEf+Q4qbyIR8aX9jUc52F
 nXRhHuifnWoY/h7XRRTF8h1S7z3Bq6/IzKADE6rs8iA8FfJvHMvLdLA06EJNdrCVwtGhVDmog
 21K8wG9mMcSYrCRVTdLTs0DsaK5PegpVigiG9n1FkRNC5IqYV++8otPdCajL37UB8fgJNZP7X
 /XI6gGhCOZQ==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 4 Apr 2019, Junio C Hamano wrote:

> Christian Couder <christian.couder@gmail.com> writes:
>
> > This path series is a follow up from the "remote odb" patch series
> > that I sent last year, which were a follow up from previous
> > series. See the links section for more information.
>
> When this topic gets merged with the "diff: batch fetching of missing
> blobs" topic, the result seems to break t4067.

See nycvar.QRO.7.76.6.1904051528130.41@tvgsbejvaqbjf.bet for my proposed
fix to the merge commit.

Ciao,
Dscho
