Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B3C92021E
	for <e@80x24.org>; Sun,  6 Nov 2016 21:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750918AbcKFVnW (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Nov 2016 16:43:22 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36098 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750727AbcKFVnV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Nov 2016 16:43:21 -0500
Received: by mail-wm0-f67.google.com with SMTP id c17so13390678wmc.3
        for <git@vger.kernel.org>; Sun, 06 Nov 2016 13:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0aq7IEDfJOA0Yed36MKbQdCb8M+Pfny/n498zlhBO0U=;
        b=HatgAXGfPGMl4ez7eXXYKrThorp5pMxU9QGy4jNxhcf1w3s6kBO6TbhOttbJOQCMRe
         KzSdErPpZcb3Nx0RMBUpQhxIwWsuRLyCfaFr6b2gCkvbPthhxfTHXTTqyU0fRrHfuNUS
         XKGMTdTKPo7x7Qp7co7GKt9sNrKX1RJGMIb8GLv0hVqcVYeWhB2MFukgUzK0dXjec/aw
         orMNMMsF2+fMMH2QEMrKOPo2XPRoIGTw0pX41UymSnqFroNZ07yGim3nIjbJXroHDhqE
         wMzNUtqoKusYmv9D8BHjkQJLmKA6NRxMVf1mGIwuCY4k3kcN2aEvRAIAexxaepHjTK7D
         l0Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0aq7IEDfJOA0Yed36MKbQdCb8M+Pfny/n498zlhBO0U=;
        b=kvlrZT29+j0KhNmjtWUE6Mw7KuYmy+qCsfsUHrW/68rD0/lH2ZR8ybJ/ldPyuv1crU
         FdHSeZFs/u9opURdtCjrP747wVgUnegeHjd/czFx5pC2OwW4iAYAUFKNAPlaQU2cYd3B
         z57m1hENCpHtydw1xAh1E2E8ZakRcFO4VYS6WJWUcw7DGKnbXdJdKfwsEhIxnRB8gZUp
         b6eVO80dBjacU5oV7tZx9zi17qYoCd8sFPkKVLTaKGNnmMHVPZ6Z15LmZiPkmAWOzSIv
         Xk3X3ts83iTAG0sR3bX5V/0eopFcy2bVaplTIh4QAWGHtIQ5MaqPEKITkoo/MOSEMoND
         yylQ==
X-Gm-Message-State: ABUngveSh95vphXQoJsHx3xHWiQvzMY8B/rJmkcCN6FMpgKwgVFVa7sbOcF1Mp0TpUvwgg==
X-Received: by 10.28.4.200 with SMTP id 191mr3745710wme.23.1478468558264;
        Sun, 06 Nov 2016 13:42:38 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB5D74.dip0.t-ipconnect.de. [93.219.93.116])
        by smtp.gmail.com with ESMTPSA id ym3sm27203300wjc.6.2016.11.06.13.42.37
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 06 Nov 2016 13:42:37 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v1 2/2] travis-ci: disable GIT_TEST_HTTPD for macOS
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20161017002550.88782-3-larsxschneider@gmail.com>
Date:   Sun, 6 Nov 2016 22:42:36 +0100
Cc:     =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        git <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <203BDCB2-1975-4590-B4B8-3C5E9D210430@gmail.com>
References: <20161017002550.88782-1-larsxschneider@gmail.com> <20161017002550.88782-3-larsxschneider@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 17 Oct 2016, at 02:25, larsxschneider@gmail.com wrote:
>=20
> From: Lars Schneider <larsxschneider@gmail.com>
>=20
> TravisCI changed their default macOS image from 10.10 to 10.11 [1].
> Unfortunately the HTTPD tests do not run out of the box using the
> pre-installed Apache web server anymore. Therefore we enable these
> tests only for Linux and disable them for macOS.
>=20
> [1] https://blog.travis-ci.com/2016-10-04-osx-73-default-image-live/
>=20
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
> .travis.yml | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/.travis.yml b/.travis.yml
> index 37a1e1f..d752447 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -32,7 +32,6 @@ env:
>     - DEFAULT_TEST_TARGET=3Dprove
>     - GIT_PROVE_OPTS=3D"--timer --jobs 3 --state=3Dfailed,slow,save"
>     - GIT_TEST_OPTS=3D"--verbose --tee"
> -    - GIT_TEST_HTTPD=3Dtrue
>     - GIT_TEST_CLONE_2GB=3DYesPlease
>     # t9810 occasionally fails on Travis CI OS X
>     # t9816 occasionally fails with "TAP out of sequence errors" on =
Travis CI OS X
> @@ -57,6 +56,8 @@ before_install:
>   - >
>     case "${TRAVIS_OS_NAME:-linux}" in
>     linux)
> +      export GIT_TEST_HTTPD=3DYesPlease
> +
>       mkdir --parents custom/p4
>       pushd custom/p4
>         wget --quiet =
http://filehost.perforce.com/perforce/r$LINUX_P4_VERSION/bin.linux26x86_64=
/p4d
> --=20
> 2.10.0
>=20

Hi Junio,

the patch above is one of two patches to make TravisCI pass, again.
Could you queue it?

The other patch is [1] which is still under discussion.

Thank you,
Lars

[1] =
http://public-inbox.org/git/8C67FF53-C26F-4993-908F-A5183C5E48D9@gmail.com=
/=
