Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AB0B1F424
	for <e@80x24.org>; Mon, 18 Dec 2017 21:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934695AbdLRVeA (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Dec 2017 16:34:00 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:42247 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934193AbdLRVd7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Dec 2017 16:33:59 -0500
Received: by mail-wm0-f67.google.com with SMTP id b199so434762wme.1
        for <git@vger.kernel.org>; Mon, 18 Dec 2017 13:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VwFvQjFOYc2FFFXDuhztewNOKeLgmJxi2JN7dNtdZEM=;
        b=K9WBtplF0cibFp0lOnw3MWef91HKEnIrqz5ftW/3OQ8xs0GSuD4oICv1UumK/B9BWT
         KarLZDVgBEPxYdvQ+oqGr7k0SgfwcqiDAy+e0u51TZO2WfOxrOl8KjEcQCsljmN2VY+g
         uCNkUl806NQ2SQm8dm6GCBF9ikuL/Fjbxrm9icwBm8BC140q/uoGexbSj1ffArAeioVk
         c73WjIXinHk2iOqzuY3FJ3a67lrvZMdKVOaxNWK1GWIEgQRE+B0rokFGfIUu6AFQsLCn
         VgXwS7qOynq0snVmUdqD0qceGkqTq/90dm12W6x7q1uwFoBGixeU/yr5SycepJNQ3W/3
         jZ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VwFvQjFOYc2FFFXDuhztewNOKeLgmJxi2JN7dNtdZEM=;
        b=GsIUWscqkwkeDzL39g05VEmye+eIKhIX4UUoDG9iYvgEy8h03b9wbl3kyusx1+SBij
         Vq91s5OmHjDEHw8f/D5RqWrEbTxUDtXMqfVaKJNZxz/q17zp2Tbxw5pzyOYmx/ROsAEW
         ZvwB81IoH0PfIXuP87WjpdCayEayL4KElM1Nyb1nRHsC2Pi6GXYdXNE0s1Cn87tKbTgT
         pQLbTO5dt3ioVZfQLIgDz9fWsVRzFDXmq6yqy76+qoox0lb2ssvpNUq+qIJq17YfSvie
         SKRPdoyjjgEC309sHihkAuXZ1HnpsNvhm7SAneWNf7vztHuK0w1IN98wGGeLNt9RIEID
         zo6A==
X-Gm-Message-State: AKGB3mL7jRhaL5IB7rWembXq8IxVTFxYtv+eyDUrn2OZtRqGZRZATGmR
        dVDbCJIyAykudxyhN9ucEqE=
X-Google-Smtp-Source: ACJfBovZp4/ChRRORUqFznWEwZ6hiAkrSgH7p5Sh6vt5bGXdCA2DAbwlATLxJjaMGd/V8m57/Ik/ew==
X-Received: by 10.28.238.135 with SMTP id j7mr695514wmi.140.1513632837957;
        Mon, 18 Dec 2017 13:33:57 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB5261.dip0.t-ipconnect.de. [93.219.82.97])
        by smtp.gmail.com with ESMTPSA id n65sm11754953wrb.17.2017.12.18.13.33.56
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Dec 2017 13:33:57 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2 6/8] travis-ci: don't install 'language-pack-is' package
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20171216125758.11120-1-szeder.dev@gmail.com>
Date:   Mon, 18 Dec 2017 22:33:56 +0100
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <8F53EF33-6FDA-484C-91A4-49CF24C0B417@gmail.com>
References: <20171216125418.10743-2-szeder.dev@gmail.com> <20171216125758.11120-1-szeder.dev@gmail.com>
To:     =?utf-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 16 Dec 2017, at 13:57, SZEDER G=C3=A1bor <szeder.dev@gmail.com> =
wrote:
>=20
> Ever since we have started to use Travis CI in 522354d70 (Add Travis
> CI support, 2015-11-27), our 64 bit Linux build jobs install the
> 'languate-pack-is' package.  That commit doesn't discuss why it was
> deemed necessary back then, but Travis CI can build and test Git
> without that package just fine, even that commit introducing Travis CI
> support.

If I remember correctly then we had to install the Icelandic
language pack for the i18n tests (e.g. t0204):

https://github.com/git/git/blob/master/t/lib-gettext.sh
https://packages.ubuntu.com/trusty/language-pack-is

However, I checked your Travis-CI and I cannot spot any errors:
https://travis-ci.org/szeder/git/jobs/317494789

I am a bit puzzled. Maybe the Icelandic language pack was not part
of the Ubuntu image that was used when we introduced Travis CI?

The Ubuntu default image was 12.04 back then:
https://travis-ci.org/git/git/jobs/100241871

Nowadays it is 14.04.

@Avar:=20
Do you know what kind of errors we should expect if the language=20
pack is not installed?

Thanks,
Lars

>=20
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
> .travis.yml | 1 -
> 1 file changed, 1 deletion(-)
>=20
> diff --git a/.travis.yml b/.travis.yml
> index 4684b3f4f..ea11b5af6 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -17,7 +17,6 @@ compiler:
> addons:
>   apt:
>     packages:
> -    - language-pack-is
>     - git-svn
>     - apache2
>=20
> --=20
> 2.15.1.429.ga000dd9c7
>=20

