Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 477B81F424
	for <e@80x24.org>; Mon, 18 Dec 2017 21:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935438AbdLRVqF (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Dec 2017 16:46:05 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:42997 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933574AbdLRVqE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Dec 2017 16:46:04 -0500
Received: by mail-wm0-f47.google.com with SMTP id b199so472531wme.1
        for <git@vger.kernel.org>; Mon, 18 Dec 2017 13:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=RX6H8NmJEIls7txdl55kUNpf/bWbLukVYYnHyjykdXU=;
        b=gqRLX6rFvsO48dwKIkFt2JGq5Ww8CvleO/Gk+oW97FdRXmXz8k0zE5lDcSMtP2dS2M
         4F40QpIc347vsyLORXo8HWtFwX1o8if/v2sFi6Hv7OSaDgWDFgE2KV+6H6qqeVcTocPE
         rfqz8NjhBvtgElMx1s5ch3YxebtALR3wgvAAHZtISsydk07ivAson/UZofH1/GJksDVb
         R96Cn9Sm9tSheHoaqnmuifgifNtLo32Wc0w+i9KIG80Idfdvfvi/GwdaPmoi47Krqf7E
         AtraUpFwi78COFOHp5W7kENK+dx+z/owIfYmCx9I0BSBVq8FoOsxOHpumh0DSXrsDLAf
         pvmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=RX6H8NmJEIls7txdl55kUNpf/bWbLukVYYnHyjykdXU=;
        b=pueXm+bg/9DU8Lnr67KHD+VjsvewhMeC7+0y9b9/hGpOLz5eNQq0uA2LCqA5O2Ocp7
         NZTKA3qdtpuiAnNSKTxlFwfhCpC98fwltEY2iGYcOWaL2h1aUXWlpjXVnb69xOf7gTwy
         B/WSwJtJjCmgpja+hjmchN4jX/N9AI8IeOiQcPcqW8UxMFzE9qdnoYV4X8aJUntXB23v
         u+J6I/gxu+XKjjS8DDLFn/LDdXC9f207t3qmejMO7Yx9QjsaF85CjFdG2CK5hKED8mW+
         yvnYDBtzVIgsHoR9b4GJOQEz9x68l5dSG/42VUj781R+9NNuIiMZn16gtNI0hYb1RP/S
         eCWw==
X-Gm-Message-State: AKGB3mKTHx2tqnIxxaPX44c3k6Xlv6+UjWBpLvT9XL3MRz5Fe+G8TyRh
        Lkw+PamHOFOsrCAbdeEKfTw=
X-Google-Smtp-Source: ACJfBovOqUcKaC8mDw8ZHSfyUBdRo6BnRxKQvv53YW7E8teJmDuJEYlt0eQ9mc3rp5XWfCGbT6D2Pg==
X-Received: by 10.28.35.4 with SMTP id j4mr655493wmj.55.1513633563185;
        Mon, 18 Dec 2017 13:46:03 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB5261.dip0.t-ipconnect.de. [93.219.82.97])
        by smtp.gmail.com with ESMTPSA id m25sm4392958wrf.56.2017.12.18.13.46.02
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Dec 2017 13:46:02 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2 0/8] Travis CI cleanups
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20171216125418.10743-1-szeder.dev@gmail.com>
Date:   Mon, 18 Dec 2017 22:46:02 +0100
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E20A2A7B-232D-4873-A026-E8CB104A84BF@gmail.com>
References: <20171211233446.10596-1-szeder.dev@gmail.com> <20171216125418.10743-1-szeder.dev@gmail.com>
To:     =?utf-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 16 Dec 2017, at 13:54, SZEDER G=C3=A1bor <szeder.dev@gmail.com> =
wrote:
>=20
> This is a reroll of 'sg/travis-fixes'.
>=20
> Changes since the previous round:
>=20
> - Patch 1 got updated following the discussion:
>=20
>   - I went with enabling tracing executed commands everywhere,
>     including the Windows build job, except where we know it causes =
way
>     too much clutter, which is currently only
>     'ci/print-test-failures.sh'.
>=20
>   - Also enable this tracing in 'ci/run-linux32-build.sh', which
>     doesn't source 'ci/lib-travisci.sh' as it's run inside a Docker
>     container.
>=20
>   - The commit message got updated accordingly, including a note about
>     the Windows build job's secret token.
>     I would like to get an Acked-by: from Dscho on this patch before =
it
>     gets merged.
>=20
> - Patches 5-8 are new.  They are various fixes/cleanups unrelated to
>   the Travis CI scriptification, but I don't think it's worth to have
>   them in separate patch series.

This cleanup series looks very good. ACK. Thank you, Gabor!

The is the only potential nit I see:
=
https://public-inbox.org/git/8F53EF33-6FDA-484C-91A4-49CF24C0B417@gmail.co=
m/

- Lars

>=20
> SZEDER G=C3=A1bor (8):
>  travis-ci: use 'set -x' in select 'ci/*' scripts for extra tracing
>  travis-ci: introduce a $jobname variable for 'ci/*' scripts
>  travis-ci: move setting environment variables to 'ci/lib-travisci.sh'
>  travis-ci: set GIT_TEST_HTTPD in 'ci/lib-travisci.sh'
>  travis-ci: don't install default addon packages for the 32 bit Linux
>    build
>  travis-ci: don't install 'language-pack-is' package
>  travis-ci: save prove state for the 32 bit Linux build
>  travis-ci: only print test failures if there are test results
>    available
>=20
> .travis.yml                | 28 ++++++----------------------
> ci/install-dependencies.sh |  8 +++-----
> ci/lib-travisci.sh         | 38 ++++++++++++++++++++++++++++++++++----
> ci/print-test-failures.sh  |  9 +++++++++
> ci/run-linux32-build.sh    |  3 +++
> ci/run-linux32-docker.sh   |  1 +
> 6 files changed, 56 insertions(+), 31 deletions(-)
>=20
> --=20
> 2.15.1.429.ga000dd9c7
>=20

