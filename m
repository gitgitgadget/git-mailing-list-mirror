Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0AA41FAE2
	for <e@80x24.org>; Mon, 12 Mar 2018 10:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752065AbeCLKPL (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Mar 2018 06:15:11 -0400
Received: from mail-pl0-f53.google.com ([209.85.160.53]:37594 "EHLO
        mail-pl0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751229AbeCLKPK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Mar 2018 06:15:10 -0400
Received: by mail-pl0-f53.google.com with SMTP id w12-v6so9058043plp.4
        for <git@vger.kernel.org>; Mon, 12 Mar 2018 03:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=F1DqsG+QDfaJUpaaPrHUFpjkK+LnlLj+IS8c5LzgCys=;
        b=EAiMu5BAtoJ+GnklXUrochNgor/DH8NLvM736lQNTJvqHzhK+1tGmX/4aSs1zSTnNd
         xhhDjolxwlqhDU6Q8GTJgyn+Amf2SUZTCUdyVA/ZpqNleIp2nITiTqvZtXZmul2qFdCf
         j4H50OAjn2eVmD8Y+UPjl5FnlJeXJcraIVSsBHSqLfSRfoITkR9zP5k6oGp+zixsIsb1
         UJK32MnvpUxwMD2nhtMw2VtQ54PNTUiaTUT4mo23N6w+czVCkFqd623EcICgwGuFOZF0
         eEStOS1PGEbpb0JNRKQ1qWbXSMzDcOt30WGwAa34CdGS8JmzLd3+1koyQ7zX5z0bBmI0
         nUmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=F1DqsG+QDfaJUpaaPrHUFpjkK+LnlLj+IS8c5LzgCys=;
        b=iiON4q94FtcUprtAY3IPZTkyGFsTV96jwAlqHlCcG9+tdiPbWnMolyyl5PSZuCtX3Y
         IqiVHv1c/LnsDW2fbJcAqCN8P+gtZj3795/qBzGXav2ZeViNUgHsDGhQGPhxDbeTMHfX
         iVxpjL03Vz2odVpNHQfXspHPXSXEhAq1+ApNYeZWrAvYpaUM3NSnYN6Ufu/O7KO5tENh
         8vl+7cGZagRMO+ybeF+JE8CoCf3lLF/peNfW/syL6Gg9Iwxjjj+o49xeIkYl8SdOAsHZ
         HpFP+e5CpgTAJ16oa97delQMJG5y986vjvxyHPwyqj8tkmP4bB0/3YuNktaHJ/MbWCNT
         FVhw==
X-Gm-Message-State: AElRT7ECsyP/mHLtoRGHQObp3Rx3Ow2Fisp/i+VCW9cJBQagGwD6PNUh
        zW8noinN3EFT/3Bmy+fjb7JhsnaF
X-Google-Smtp-Source: AG47ELufzXQfR/6sBBkehFBtMpwhfeTi4IjdBzwh8XGIHAeIYhdHKDgNx17f2DaPHdrYz15yH/z6HQ==
X-Received: by 2002:a17:902:8c91:: with SMTP id t17-v6mr7685093plo.233.1520849709613;
        Mon, 12 Mar 2018 03:15:09 -0700 (PDT)
Received: from remr90p0m5f.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id e83sm17642423pfk.148.2018.03.12.03.15.07
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Mar 2018 03:15:08 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [GSoC][PATCH] git-ci: use pylint to analyze the git-p4 code
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20180312022003.8844-1-viethtran1620@gmail.com>
Date:   Mon, 12 Mar 2018 11:15:05 +0100
Cc:     Git List <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CC42B5EC-6594-45CB-9821-E1C0ECED354E@gmail.com>
References: <20180312020812.7883-1-viethtran1620@gmail.com> <20180312022003.8844-1-viethtran1620@gmail.com>
To:     Viet Hung Tran <viethtran1620@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Viet,

> On 12 Mar 2018, at 03:20, Viet Hung Tran <viethtran1620@gmail.com> =
wrote:
>=20
> This is my submission as a microproject for the Google Summer of code.
> I apologize for not setting the [GSoC] in my previous email
> at <20180312020855.7950-1-viethtran1620@gmail.com>.
> Please ignore it.

No worries :-)

> Add a new job named Pylint to .travis.yml in order to analyze git-p4 =
Python code.
> Although Travis CI have yet to implement continuous integration for =
multiple
> languages. Python package can be installed using apt packages. =46rom =
there, pylint can be
> installed using pip and used to analyze git-p4.py file.

That looks interesting!
I assume you did run this on TravisCI already? Can you share a link?
I assume you did find errors? Can we fix them or are there too many?
If there are existing errors, how do we define a "successful" build?

Thanks for working on this,
Lars

>=20
> Signed-off-by: Viet Hung Tran <viethtran1620@gmail.com>
> ---
> .travis.yml | 10 ++++++++++
> 1 file changed, 10 insertions(+)
>=20
> diff --git a/.travis.yml b/.travis.yml
> index 5f5ee4f3b..581d75319 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -46,6 +46,16 @@ matrix:
>         - docker
>       before_install:
>       script: ci/run-linux32-docker.sh
> +    - env: jobname=3DPylint
> +      compiler:
> +      addons:
> +        apt:
> +          packages:
> +          - python
> +      before_install:
> +      install: pip install --user pylint
> +      script: pylint git-p4.py
> +      after_failure:
>     - env: jobname=3DStaticAnalysis
>       os: linux
>       compiler:
> --=20
> 2.16.2.440.gc6284da
>=20

