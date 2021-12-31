Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCDAC433F5
	for <git@archiver.kernel.org>; Fri, 31 Dec 2021 17:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbhLaRF4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Dec 2021 12:05:56 -0500
Received: from smtp4-g21.free.fr ([212.27.42.4]:30060 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229699AbhLaRF4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Dec 2021 12:05:56 -0500
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:9225:6fd8:b89b:1501])
        (Authenticated sender: jn.avila@free.fr)
        by smtp4-g21.free.fr (Postfix) with ESMTPSA id F10F019F59C;
        Fri, 31 Dec 2021 18:05:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1640970354;
        bh=aVe/9hFHR/P12VJC84JziTNAu8PAtOKaMYDHhkcy4I4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CEiGayx3m8U1ZHAn3mssFtJzUqDX5FuHR2ySFkpf3E7WbvoIfiuasA5tHp4mlekHh
         n/C9auXD+OzULeD0MX/65AdDVIzF0NBusbsCcdCBrY2uPjSuyVkM+CLeXGR2ckRM6/
         Eydfelycb2x33/InXsHgWnKx9FqxHwtnnH4+Iqk/S2g3u3OwPI6VHRQnqWOQjMfBFc
         SBdMWkVSa/6p96Ol2WiZeQ31S8LTh2LMfy8i5rtAXzYunNSPHJZisLidLeRvc5NKs6
         U0HmsFzharjGpwN4mi3zTl21Wvv5XUc2E1Q91V3sifhp6xBlT3QJS9u7xBzSI73NxZ
         OYuoCooA7qTEw==
From:   =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To:     =?ISO-8859-1?Q?Jean=2DNo=EBl?= Avila via GitGitGadget 
        <gitgitgadget@gmail.com>, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3 02/11] i18n: refactor "%s, %s and %s are mutually exclusive"
Date:   Fri, 31 Dec 2021 18:05:42 +0100
Message-ID: <3844495.otZVHuhvFT@cayenne>
In-Reply-To: <xmqqfsq9pw4d.fsf@gitster.g>
References: <pull.1088.v2.git.1640647437.gitgitgadget@gmail.com> <4accf1629e55ae621053f27994ebc4eb59d6f0ff.1640804107.git.gitgitgadget@gmail.com> <xmqqfsq9pw4d.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thursday, 30 December 2021 23:26:42 CET Junio C Hamano wrote:
> "Jean-No=EBl Avila via GitGitGadget"  <gitgitgadget@gmail.com> writes:
>=20
> >  	if (use_stdout + rev.diffopt.close_file + !!output_directory > 1)
> > -		die(_("--stdout, --output, and --output-directory are mutually exclu=
sive"));
> > +		die(_("options '%s', '%s' and '%s' cannot be used together"), "--std=
out", "--output", "--output-directory");
>=20
> We probably want to preserve the Oxford comma here, and unify the
> ones that didn't use Oxford comma to use it.
>=20

Oh. I wasn't even aware of this holy war (https://en.wikipedia.org/wiki/Ser=
ial_comma). It would be good to add this style specification
for writing our messages and documents.

Will make another pass.

Thanks


