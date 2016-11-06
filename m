Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE51F2021E
	for <e@80x24.org>; Sun,  6 Nov 2016 19:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752002AbcKFTuS (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Nov 2016 14:50:18 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36071 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751985AbcKFTuQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Nov 2016 14:50:16 -0500
Received: by mail-wm0-f67.google.com with SMTP id c17so13046232wmc.3
        for <git@vger.kernel.org>; Sun, 06 Nov 2016 11:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jKXMa0bGn+RgpQzkuquef4Q+DAHrlRubba6UjgKBAi8=;
        b=zSJIX4gTHtZpxzLR7JfuLR/DNci2RenFRINpD1QNvitpkAMvdZt/6Y7eBCyF4YO5y5
         NpTIltDd5xEs/2M6eJTHozECleyzmajfHI5MQnoQ9jP/fIe3yOobmFigLUk+mzhn0Dls
         r+szmBWHAfnkKjny4e2AsH5ZbT7Tui/i+9NtW6h/kuiyR5IziC+Vz06WmC+YtHfOdRe3
         OQbBzFgqYFhk7bYngj1/xP6LAwwrTjaizXCj/OWTOHFSuQqqKrmnssGV+5qs6Ai9g8MT
         hkjDB8jQ4kGuAIX63bcyBwNfmniGLA3KhMSdjg6xwmkVOWsyxdC6xkNseecv3QJU56iC
         gIJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jKXMa0bGn+RgpQzkuquef4Q+DAHrlRubba6UjgKBAi8=;
        b=BtUsMtAeoVHPnSE9aLM/EuP9JkYBDK5XIhvsICEGnAiap3ps99gu6SJzN9pAx7dYDw
         1iRZSkS25FY96zVrPO2u2/RzJ72XhOJ5Upn4QSITSLD4z6s8pL9lp+FngbTf08Vd+osx
         d3gNPr0O+ZJ4GoAZxW79HB3vAhBTLmt6PA7lIaIpsvN+umak43SpDU01nIr4d/0lfkA7
         7P3ryO9ZwyrKlDP83LqA1wpNKE+M0SKPYZnwKMyWXQn8dw//Yyg00M6z1cYvM0jNV63C
         AtGumYAT3ivpwQwm7Cvmt0GQRJQ3f+GrJKY2jf6z9g/yjynAHfSce72ip4Svgq73slfI
         FsWg==
X-Gm-Message-State: ABUngvdHQe6KNIC07eBAc8HcHCacbSpjnzP2wOsUT7jdb98r8wxH8FFCg4vkmPkDqGtqEw==
X-Received: by 10.28.20.70 with SMTP id 67mr4073046wmu.102.1478460906333;
        Sun, 06 Nov 2016 11:35:06 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB5D74.dip0.t-ipconnect.de. [93.219.93.116])
        by smtp.gmail.com with ESMTPSA id e5sm9220681wma.10.2016.11.06.11.35.05
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 06 Nov 2016 11:35:05 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v1 1/2] config.mak.in: set NO_OPENSSL and APPLE_COMMON_CRYPTO for macOS >10.11
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20161017095002.bbqyp2hkbuyau66t@sigill.intra.peff.net>
Date:   Sun, 6 Nov 2016 20:35:04 +0100
Cc:     git@vger.kernel.org, tboegi@web.de, gitster@pobox.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <8C67FF53-C26F-4993-908F-A5183C5E48D9@gmail.com>
References: <20161017002550.88782-1-larsxschneider@gmail.com> <20161017002550.88782-2-larsxschneider@gmail.com> <20161017095002.bbqyp2hkbuyau66t@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 17 Oct 2016, at 11:50, Jeff King <peff@peff.net> wrote:
>=20
> On Sun, Oct 16, 2016 at 05:25:49PM -0700, larsxschneider@gmail.com =
wrote:
>=20
>> From: Lars Schneider <larsxschneider@gmail.com>
>>=20
>> Apple removed the OpenSSL header files in macOS 10.11 and above. =
OpenSSL
>> was deprecated since macOS 10.7.
>>=20
>> Set `NO_OPENSSL` and `APPLE_COMMON_CRYPTO` to `YesPlease` as default =
for
>> macOS. Make it possible to override this and use OpenSSL by defining
>> `DARWIN_OPENSSL`.
>=20
> I like that you gave an override, but I don't think it works in all
> cases:
>=20
>> diff --git a/config.mak.uname b/config.mak.uname
>> index b232908..f0c94a9 100644
>> --- a/config.mak.uname
>> +++ b/config.mak.uname
>> @@ -108,6 +108,12 @@ ifeq ($(uname_S),Darwin)
>> 	ifeq ($(shell test "`expr "$(uname_R)" : '\([0-9][0-9]*\)\.'`" =
-ge 11 && echo 1),1)
>> 		HAVE_GETDELIM =3D YesPlease
>> 	endif
>> +	ifeq ($(shell test "`expr "$(uname_R)" : '\([0-9][0-9]*\)\.'`" =
-ge 15 && echo 1),1)
>> +		ifndef DARWIN_OPENSSL
>> +			NO_OPENSSL =3D YesPlease
>> +			APPLE_COMMON_CRYPTO=3DYesPlease
>> +		endif
>> +	endif
>=20
> This is in config.mak.uname, which gets sourced before config.mak (and
> ifndef is evaluated at the time of parsing). So it would work to do:
>=20
>  make DARWIN_OPENSSL=3DYep
>=20
> but not:
>=20
>  echo DARWIN_OPENSSL=3DYep >>config.mak
>  make
>=20
> I think you'd have to set a flag in config.mak.uname, and then resolve
> it in the Makefile proper like:
>=20
>  ifdef DARWIN_OPENSSL
> 	# Overrides AUTO_AVOID_OPENSSL, do nothing.
>  else ifdef AUTO_AVOID_OPENSSL
> 	NO_OPENSSL =3D YesPlease
> 	APPLE_COMMON_CRYPTO =3D YesPlease
>  endif
>=20
> but that's totally untested.

Good point. I think I found an even easier way to achieve the same.
What do you think about the patch below?

Thanks,
Lars

-- >8 --
Subject: Makefile: set NO_OPENSSL on macOS by default

Apple removed the OpenSSL header files in macOS 10.11 and above. OpenSSL
was deprecated since macOS 10.7.

Set `NO_OPENSSL` and `APPLE_COMMON_CRYPTO` to `YesPlease` as default for
macOS. It is possible to override this and use OpenSSL by defining
`NO_APPLE_COMMON_CRYPTO`.

Original-patch-by: Torsten B=C3=B6gershausen <tboegi@web.de>
Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 9d6c245..f53fcc9 100644
--- a/Makefile
+++ b/Makefile
@@ -1047,6 +1047,7 @@ ifeq ($(uname_S),Darwin)
 		endif
 	endif
 	ifndef NO_APPLE_COMMON_CRYPTO
+		NO_OPENSSL =3D YesPlease
 		APPLE_COMMON_CRYPTO =3D YesPlease
 		COMPAT_CFLAGS +=3D -DAPPLE_COMMON_CRYPTO
 	endif
--=20=
