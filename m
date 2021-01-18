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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC70BC433E6
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 14:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A087822BEA
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 14:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392929AbhARO2y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jan 2021 09:28:54 -0500
Received: from mout.gmx.net ([212.227.17.20]:58403 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392899AbhARO2e (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jan 2021 09:28:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1610979997;
        bh=W4+9SdcVbyUOkxYK7TWt1Vgnh0cY71uF2eWIZVAyoXg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=jq/sHN/ZKRT/YpMU/4/Dq9cgyQ3CErcaV3MMdm30YJOuUH1p8MCSWXNZ/mVG71aR9
         Tcf54m72qJ5xDJrB7z9X2Q8RMK/hi9Hs0Lb6ZsO78f1xke10VLnbxLsJWzASykOx8z
         rlS7CBpMxUHPXh6FHlsO2nyvMsFtw4Lg/0kxZAdE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.115.203] ([89.1.215.22]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N3siG-1m14Iv2Ii0-00zohI; Mon, 18
 Jan 2021 15:26:37 +0100
Date:   Mon, 18 Jan 2021 15:26:42 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 04/11] sha1dc: mark forgotten message for translation
In-Reply-To: <YAHC9faa4ykNOWj6@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2101181525370.52@tvgsbejvaqbjf.bet>
References: <pull.836.git.1610441262.gitgitgadget@gmail.com> <8f2c08474a75793c24af7d4ae44d73d2b23920bc.1610441263.git.gitgitgadget@gmail.com> <X/2J8KL/Jig/xttF@coredump.intra.peff.net> <nycvar.QRO.7.76.6.2101151639030.52@tvgsbejvaqbjf.bet>
 <YAHC9faa4ykNOWj6@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:QN5CoDcDiW0xiFIhVuXVbzUk4DjS2i/z0zlU75onKSxee/3z3V4
 /N5yFl0s69H9RhVQ4Xq02ORGZRg0kVQxrX/IoZJbrxWKVkIdQkT/xLsgMfOEgXL2tYzRLGY
 JmhZNaixtId2F33QGyQONwYNPIhBjtc/lOYHkTpkhInvyB8NUYG1WKwVsQybxG3GdNg8ggU
 089REySA83+1Agl0/10Sw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tUFv0PiYse8=:1AIzcCUk/ItUUdxSsjQm5d
 EVT4hql3QVIzvdtBhA2BWyxlhlAJ5zheFIag+bT8pqFWu7uRAuKK9yLz+LPJegYdhR+NYJJg3
 /o6GlKqw4BG5AGVhzcci7QPh057VrTltrrmhGsNIs+8iJu8pYId5gQQnUd2UQQWaexR4B+wZo
 v3gIPI032kJevaEt9Znpc9kP0ARD0Qw+4EvUGBbzl6P6fFM+cRQdYErExKuhawRx9cEYgxTS0
 EFxxCuqGqyD0uZ+o9r42pd3PCOMni5yJLmQOgH1DcbphHDedBbOUy2C7S6iOzn6JQY6UiPlFj
 xHbBalgcc8E6xmnXfVdXPHWUSN02BZ+JT72A2sUTBJwfGcgmtlEmZ1WqFtPDn9pIha7HgzX0G
 ZgtFhyMJl29VDVa0FL8ubhkBQRFp/OEQrJuHCLw1FYmLZZOF+PdnPVJQz8MjRSiKAx+0ISbqb
 1bH2x0XYq4K1qUKQFT+S48Y0nojmtGOulQZ6Eph0Lq2PDe23ZGH4RVm9YH8+Cf9hjezoV9Wq0
 SE+9HEn8slijwqLl9l/LPrF1VQEBsFdzRUQ458Kbz/972DLL4w7qYO6qGHrH2d6LGxVtr7+PF
 d0b9VKUdbQiSnIxUZWcE+2zcTXmlnGPT29OANFzYCqkWlxsyWXK6iDX8N2qKPXF8VVzX7C9XS
 05rT+W3TiWLonxHwNsSi2Nokvy43ii36YhHQsGGPaoDsGTz84tSTuAcZh3wsCnDsJupl1OmG6
 sVbRvW4G5SXN3ibuYoBwataTdZGCfFwpGE26M4vis5tAXBmN/XqFUGyJikqG1Cz01E13EVlz9
 nZiNPXlFJLFRpPXLtpL8Sy20Oj4C4DPoE3DNc2kVjthcEA4oOD2884gC6HpCBWw2khx3OKNXI
 saVRKVb3tyZXRQCPS3zitbiW1prRigIlPHCIbAwj0=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, 15 Jan 2021, Jeff King wrote:

> On Fri, Jan 15, 2021 at 04:43:05PM +0100, Johannes Schindelin wrote:
>
> > > > -	die("SHA-1 appears to be part of a collision attack: %s",
> > > > +	die(_("SHA-1 appears to be part of a collision attack: %s"),
> > > >  	    hash_to_hex_algop(hash, &hash_algos[GIT_HASH_SHA1]));
> > >
> > > I didn't find any list discussion, but I think I may have actually l=
eft
> > > this untranslated intentionally. Like a BUG(), we'd expect it to com=
e up
> > > basically never. And when it does, being able to search for the exac=
t
> > > wording online may be more important than providing a translated
> > > version.
> >
> > I disagree with that reasoning. By that rationale, any message we deem=
 to
> > be somewhat rare should be _untranslated_.
> >
> > A much better rule, at least from my perspective is: is the target
> > audience the Git users? If so, the message is to be translated. If not=
,
> > then not.
>
> That's what I was getting at. The audience is really Git developers,
> just like it would be for a BUG(). We don't expect either of those
> things to happen.

While a SHA-1 collision might not be anything we expect to happen, I am
fairly certain it won't be a bug in Git causing it. Nor will it be
anything that core Git developers have to react on. For those reasons, I
disagree that core Git developers are the target audience of this message.

Ciao,
Dscho
