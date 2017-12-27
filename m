Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 612171F404
	for <e@80x24.org>; Wed, 27 Dec 2017 18:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751881AbdL0SlH (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 13:41:07 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:44119 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751145AbdL0SlG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 13:41:06 -0500
Received: by mail-wr0-f196.google.com with SMTP id l41so25227584wre.11
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 10:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Q1I998Qb487brFailTiHHxpNvgFbEm+yDHDDVnOoHrw=;
        b=BsTpV5Pq+E/T7+EsbL47bq9b+e2LNPZA4RSm3bDFUDGBb17qp0b6SK8gv/FyTt4mw8
         qMF6oQ/mriJqv1xunXAXYTieB/YGXbB5cLn9+k/G5F9q9SWdR2ThC5fQbukjLY5BoKpd
         rPEhMev7PW/9FPcDhYAgjcnvUaE2/FLB8iW05cFa7njTS7vlpH9rPmNUL8p0uf315v0g
         GvQj/za2zrCfYIs1nY1wQ0MSz/90L4mde7+V9sBfwXKtCAnSrkzSA7PcVaUGwzewfATL
         25jQGFoytu606Gh9bHhFIY4H9eW4b1lyZwFAQExbmuAXsCFs4UgaTvbHNTqXQPmwv+a5
         2qQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Q1I998Qb487brFailTiHHxpNvgFbEm+yDHDDVnOoHrw=;
        b=rcF22ZZLtVNdWj3vcYGlXlOCqYWaV+0QzFBnihNVrZYIV9NPlrxUL5+Hak2QqSIBkz
         f9H82JOrzjXmLqShkppSwLKCfAWKc6MUgOnRlIJfCVqfslozknUnEacwuJmyD7cVwQlI
         rbRxsKxAYOuwiPd7SZYFlJj4D7vwWWrTmgbKsD41j6IHaOwYRtppCF0GtELJcWqh4ych
         uNqnfa4HLNMV2zkKrQ8/B4wFsdrjWUtg736kkeqk4ElSy9/72tVT1f46dF4gP9Z4RZBd
         nKAf41vaswZ6yElq7tCoGvUHsHbPhPTe1rWpSW3sEHFnRIIFA7x0ZB2emV7FZjzaM62o
         y70w==
X-Gm-Message-State: AKGB3mLNxX6p9sos4sX9Ogl4Eou/tTpCFtqCeus0mpT/Trsu3vNX1bJA
        JuDl/NIHfeelLA4gZ+DJRag=
X-Google-Smtp-Source: ACJfBosdNIl3gctPOjjVdDeJW0Os3RncpOmGGYAjWUJWN9DYChnd5mh+gJZFDVls62CZbU7UlDk2Sg==
X-Received: by 10.223.187.76 with SMTP id x12mr29152652wrg.110.1514400065311;
        Wed, 27 Dec 2017 10:41:05 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB5682.dip0.t-ipconnect.de. [93.219.86.130])
        by smtp.gmail.com with ESMTPSA id k61sm21064632wrc.84.2017.12.27.10.41.04
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Dec 2017 10:41:04 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v3 2/4] travis-ci: don't install default addon packages for the 32 bit Linux build
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20171227163603.13313-3-szeder.dev@gmail.com>
Date:   Wed, 27 Dec 2017 19:41:05 +0100
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <DF7D99CD-EBF2-40A1-B6F6-28694E213F42@gmail.com>
References: <20171216125418.10743-1-szeder.dev@gmail.com> <20171227163603.13313-1-szeder.dev@gmail.com> <20171227163603.13313-3-szeder.dev@gmail.com>
To:     =?utf-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 27 Dec 2017, at 17:36, SZEDER G=C3=A1bor <szeder.dev@gmail.com> =
wrote:
>=20
> The 32 bit Linux build job compiles Git and runs the test suite in a
> Docker container, while the additional packages (apache2, git-svn,
> language-pack-is) are installed on the host, therefore don't have
> any effect and are unnecessary.

Nice optimization - ACK!

Thanks,
Lars



>=20
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
> .travis.yml | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/.travis.yml b/.travis.yml
> index 7c9aa0557..4684b3f4f 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -42,6 +42,7 @@ matrix:
>     - env: jobname=3DLinux32
>       os: linux
>       compiler:
> +      addons:
>       services:
>         - docker
>       before_install:
> --=20
> 2.15.1.500.g54ea76cc4
>=20

