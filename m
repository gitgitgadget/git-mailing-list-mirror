Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70002C433DB
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 15:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45F0B208E4
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 15:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391437AbhASPyo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 10:54:44 -0500
Received: from mout.gmx.net ([212.227.15.19]:56727 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389924AbhASPyL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 10:54:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611071549;
        bh=A9XEnbb37iHyB3KVH2pt41sIfse6E0jo/iGVmAn59nI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=NEVzUVi0a/Ppd7SjJdXWAXnhQdc9ufNy8gb5q2UBdD1qiNK7Rk6JDv958cUG4AC5x
         140apCfP6aHPyNI6t176sAWfc8Xr/I1rgTdRFzFzebTyStCqIwZUa347raMJJ1eTsQ
         WRztf5+mdCVw2TONo5RsPK0llqrx7q0hyPQb/D64=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.115.203] ([89.1.213.153]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNswE-1lQBTo49Q8-00OJAO; Tue, 19
 Jan 2021 16:52:29 +0100
Date:   Tue, 19 Jan 2021 16:52:26 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 04/11] sha1dc: mark forgotten message for translation
In-Reply-To: <xmqqim7uj6p5.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2101191648400.52@tvgsbejvaqbjf.bet>
References: <pull.836.git.1610441262.gitgitgadget@gmail.com> <8f2c08474a75793c24af7d4ae44d73d2b23920bc.1610441263.git.gitgitgadget@gmail.com> <X/2J8KL/Jig/xttF@coredump.intra.peff.net> <nycvar.QRO.7.76.6.2101151639030.52@tvgsbejvaqbjf.bet>
 <YAHC9faa4ykNOWj6@coredump.intra.peff.net> <nycvar.QRO.7.76.6.2101181525370.52@tvgsbejvaqbjf.bet> <xmqqim7uj6p5.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:xrKU8XZwrsnHxHeEY/puYhf5tPW/QbowqhPPPUEBc9Z8ATs4b4A
 uxqNqKojMohuFVhfda+yiYzIBMGX4AZalaG//uNXphR8O6X+8ZqCxRy1t2qaw/8FOTLxsmv
 dENYUkSNW+z6EsK2MlI9DiVMDklZAu+/FLqD490NbwCm7BUbXqSz0UeprW1mwJZU33tEK+X
 vxIaLQ5Ihi3aVWXAMeJQg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VM1JSbyBmxs=:pHT0D3gv5ipe0e0Kd7U65L
 NpqEzo0XuHuQ27GBrFzpsHqLmZawu1jmG2FlI8y69YMKHrUKp5UFi4bMiZl7G3OGwhId8sh5B
 YvTIrw3+OkTm24eAouEWt8Kz8Nc1AqSgSz6cti41MXZgomHMEALiNfZ7YZgqvRBWuhAXP0MtP
 62MKJp0rFOd6DLngst6mlJuCZkF2LrpnDh1t87XUrgr2nDkEPkdav/UEfBz4Jkmb+TxWSjkEx
 BgdvY/4CLdh5Fm6ZOFFYlHn+vS1Wujx1YUPeVbZdrQ5VVmFcQGwJ9AVarA2PCkxjas5OwUNQg
 nwWFmGsJNlu6V8ZbdP3G1es2TXEaEXZk7YJs7gQgvSbCLgpwdfE0wc2fCCGqjGSE79IMUv+/u
 bfOruvr0cxE5JPGAFjIkGM62CJ/UXhznawosSvnJ+Fquj2xZeyGzdEa7ZkjS5t+t8W4lFpv94
 2hI2PeorLJG9ffAEYcfQR6J9+ULIWB8lrc/n8Ivh7YINyRqmehLmFO+XPpwgfImzGcLBnk8Pf
 sHyWBJ3T6yvJZRDah19WtYkk22tm62I+tmOCkHH9vJCvqPzUJ5pMbIUl1Q5QPcW9LpS76SCOO
 dOeILGexWbSdp9GLKJWCBEogtDFpYiNnfeEn1My4fH0bMhrJU4Z6cEwsljDX944+vkXvrfDtQ
 ZGcJyHyUvwicSnQ0NrxJN20ap0ys4/29AuMfv1BzzmT0cKfzMx07jyvR2UmBlBlId+CywvuTe
 rSD1Rx9RToyKU3pjc3nLlgWvFCHoVOaHEfxEXzqsIdmWz914XI8soTJ+/qjxfu/VlaqO3YSc+
 cbDRpm1RPKgS3NJ4xz79oyW+vOblEToc1ktpl0NtPB9OwtqmL8WkfJhvZvK/A6PyV/6gnU6np
 VxosUBlAp0GeRaFjGrl9BeF26s88GS0keEQ4M9yjFHg7yYQR+wEk33nOaiYmEJ
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 18 Jan 2021, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> >> That's what I was getting at. The audience is really Git developers,
> >> just like it would be for a BUG(). We don't expect either of those
> >> things to happen.
> >
> > While a SHA-1 collision might not be anything we expect to happen, I a=
m
> > fairly certain it won't be a bug in Git causing it. Nor will it be
> > anything that core Git developers have to react on. For those reasons,=
 I
> > disagree that core Git developers are the target audience of this mess=
age.
>
> I do not know if this is what Peff meant by "the audience is really
> Git developers", but when any end-user encounters this message, we
> want to learn about it a lot more urgently than all the ordinary
> "there is no such command line option", so in that sense, even it
> is not "a bug in git", it is more special than ordinary errors.

I suggest that we modify the message to state exactly that: "Please
contact the Git mailing list at git@vger.kernel.org about this". And then
mark the message for translation, so that even Git users with low/no
knowledge of the English language are in a position to help us.

Ciao,
Dscho

P.S.: Yes, I realize that this means we could receive a message reporting
a SHA-1 collision written in, say, Chinese. Is this a problem? I don't
think so. In any case, this would still be much better than keeping the
message untranslated and _not_ receiving a mail about it.
