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
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DC2620248
	for <e@80x24.org>; Fri,  5 Apr 2019 14:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbfDEON3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 10:13:29 -0400
Received: from mout.gmx.net ([212.227.17.22]:56505 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbfDEON2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Apr 2019 10:13:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1554473604;
        bh=b80Wxs9VdEmgKM/Wk458wj+6mZ8Q4clo/HSClF/ldkI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=R85pkaJGd/lIS2KxnFGRHu5MxXButaMHidP+9xHOXaOAAvWa9GDkXjuhBb0aYAuzT
         ay/vmIT+o6kGwb3HUBMmbPOyRZKk7BEV7TlxPfE0Hs9dpfJKgWoo2C4nN18yLEx8Nh
         vgCd4LGVTuIQ/qFas4LzWUSXuaZd0t1aEVeYegNg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MQ2Tn-1hG0ES3l1n-005KdU; Fri, 05
 Apr 2019 16:13:24 +0200
Date:   Fri, 5 Apr 2019 16:13:24 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jonathan Tan <jonathantanmy@google.com>
cc:     git@vger.kernel.org, peff@peff.net, szeder.dev@gmail.com
Subject: Re: [PATCH v2 1/2] sha1-file: support OBJECT_INFO_FOR_PREFETCH
In-Reply-To: <068861632b85179d2a5a5ceb966e951a78b27141.1553895166.git.jonathantanmy@google.com>
Message-ID: <nycvar.QRO.7.76.6.1904051611010.41@tvgsbejvaqbjf.bet>
References: <20190326220906.111879-1-jonathantanmy@google.com> <cover.1553895166.git.jonathantanmy@google.com> <068861632b85179d2a5a5ceb966e951a78b27141.1553895166.git.jonathantanmy@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:NaYozR1umsuj+1ktrtsaTLepyTc07/Wh2fKWPIx2eca9uMGmoLx
 pPYiXzFOm+Ae9HE/tmwKJ2O0Je7sLGscSMtp3oYuseeuQyKtvT9ce4zd+LT1n+zkKnNDcDM
 n4xqrVrHObMUgeQYbOOnOPFLJ6LbCyPOEwbMHvyMgy0aexdJcTXO/iqizeWKmcE7ojo28Fy
 VR60uexntA3aT/iGREgBQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0xVE8/yHXCA=:h7USTFwjSBpu+B8vDE4+lk
 hmtTvx4ut21PEaOlhWSGYTmmY63MCekeG7nY8SoLPo98OYDpV7yqTn5V/POWVPyqeX0mF2mqu
 NXswfL1322Qm2bvmubU6BC87Tt/22DmRwpqmRMSBXcujzufRCwggNzuzD6AqaqSvv2RJDBMp4
 zmW481oLvHcrGXwOy1kAqzvJgOt0eV9ELo7Fl8ouz1MN18Lgxjyhm8hJYLQA3um9EaDuJI9Pg
 1mFrS6KNqTz83OWMFOTqRIDxooaZgInMI3LCaoHTcKEgzzFA06DYkvdsc6IHGMA3tUNghlOde
 sC7IvkAjvTwrKQBAJG/qgoLb9HcNiOF5Bi0t9VJty4XRSpqapk4iEavW1Z0LfRJax9iNZk3g2
 iUj+/VFPCiGEHdAq5CCeQDCiXckdXXewwY9otVGOfdzMSKEiguMbpM1xqtFpo4liApCHbFNpH
 LLbjVyzfYF+iDo/gS3fnGbyNBlO0fDY8Cz3Q22e3gmGG9AOQRyHX346Sg4s1AmMgGHm7gT5eg
 ZPdgmFFgmUMranYnvT3T1G3weWQWAo5XWRtIfE/e/wdnf1BsPOW2+AtaigaMIVfJpegPit6kJ
 9G3YPidfOJTwhTI7sh5jS06zDPDZn56Hr88TjEcdZr0cdvrgk8h23wBeeeYGOW4qQWECvqD96
 pGgcm2/IoisutoSRUIWeD5SHUJhUfiG7jANa6T4DjWNHiZjkLcba6gYwdtXQ94/X1x8Phz7pa
 DNc9C8PVHLegvcwbZhepcqN+IX9MO/6IWfDnm+IuZRVbfnONyRe34RfrjJzrJrnkO16yiVJED
 stoUoNdgt07wYnMV60Cs9RgCA/d1c/V9TmMdnp2VTLBJfaqgQHpwkJI08xx/W49nGnAycZn4R
 9Qe67vKqRH0bDCAY5+9yuvlLWUccKlO5mi/uJ7mtk8wfEW/PB+NwAc6gxxTomPuIGhT+ZEPsp
 8nBPqUwQDAw==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Fri, 29 Mar 2019, Jonathan Tan wrote:

> Teach oid_object_info_extended() to support a new flag that inhibits
> fetching of missing objects. This is equivalent to setting
> fetch_is_missing to 0, calling oid_object_info_extended(), then setting
> fetch_if_missing to whatever it was before. Update unpack-trees.c to use
> this new flag instead of repeatedly setting fetch_if_missing.
>
> This new flag complicates things slightly in that there are now 2 ways
> to do the same thing.

Just a note that I disagree with the latter part of the sentence: those
are not 2 ways of doing the same thing, but they are two switches that
essentially both have to be flipped to "on". They're just multiple gates.

I do not ask you to rephrase it, merely registering a different opinion.

The patch looks good, I especially like the post-image of
`check_updates()`, which looks much nicer (from my perspective, of
course).

Thanks,
Dscho
