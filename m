Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 960F61F406
	for <e@80x24.org>; Fri,  5 Jan 2018 11:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751583AbeAELPo (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 06:15:44 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36276 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750837AbeAELPn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 06:15:43 -0500
Received: by mail-wm0-f66.google.com with SMTP id b76so1850433wmg.1
        for <git@vger.kernel.org>; Fri, 05 Jan 2018 03:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=c14U9u79t2p2uMZMFAb4CGv2TPXBSrGYk1SF1ZBDs5w=;
        b=cNQ3mYQwTSjtsMEgmDe3lazuYtc2rwNSAALMPMjN2dc7YJEEAlbUwp0pWnCr1PU3RX
         f7f1xz583Q5d2w/l03NJ3raEPfpLZpH/ybCWs6On0feyaHub2Ol3fNy/vkkFDQCULtoQ
         cmBOoi2tgbTfeesAfIEgsSXKjdCWzPsM5101o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=c14U9u79t2p2uMZMFAb4CGv2TPXBSrGYk1SF1ZBDs5w=;
        b=YAdotcTlTbcDo14dxy7KyOWNQ06++pXnYtJd6rgxNgYYw+rQPNtlI7B+EoYVSEpiPN
         vmczCuNj0aX8jOyXYuR8yWKAFILivrraqSgxfjLozVAA2dLb7R1n6R4C1Jn46a1Y51GW
         knhwWVahAuoOwYfLM8Ws/x00VLdIGocTqZiykRsp1++0jEHj3paQNL1XOdmku5Bm69p5
         GEfvQQtmJHW+sD8HUkNrESAm2cE0QsgJN6iF55UA+bua3RTElH0FCb9xvEBtUQRMvrk/
         emBrzSUgjHZuzfH6uO0yARY2M6BfX0YGIXbNrk3tO1sArRIpXai6+pEKS1qwK03/s/ci
         g3LQ==
X-Gm-Message-State: AKGB3mJLDWX2rYyonLLsC0Nhjdwap8wBh44cvAJIMCf7c24lUF+2Lkq0
        gQxiQKoFcQwwOMJ0kSLFo3I46fhOCj8=
X-Google-Smtp-Source: ACJfBouUtpXUEtsK2Hq3q+6LBN08NcVQKCnImKEBfHlO2rZvxNbFdssm0IYkaodvJ9kctrcmoTODkw==
X-Received: by 10.28.238.135 with SMTP id j7mr2090026wmi.69.1515150942452;
        Fri, 05 Jan 2018 03:15:42 -0800 (PST)
Received: from zen.linaro.local ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id b127sm7246278wma.26.2018.01.05.03.15.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jan 2018 03:15:41 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
        by zen.linaro.local (Postfix) with ESMTPS id 1F2F63E00CE;
        Fri,  5 Jan 2018 11:15:41 +0000 (GMT)
References: <q7h9wp0wod8y.fsf@orange.lip.ens-lyon.fr> <1515147109-8077-1-git-send-email-git@matthieu-moy.fr>
User-agent: mu4e 1.0-alpha3; emacs 26.0.90
From:   Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To:     Matthieu Moy <git@matthieu-moy.fr>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] send-email: add test for Linux's get_maintainer.pl
In-reply-to: <1515147109-8077-1-git-send-email-git@matthieu-moy.fr>
Date:   Fri, 05 Jan 2018 11:15:41 +0000
Message-ID: <87o9m8d09u.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Matthieu Moy <git@matthieu-moy.fr> writes:

> From: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> We had a regression that broke Linux's get_maintainer.pl. Using
> Mail::Address to parse email addresses fixed it, but let's protect
> against future regressions.
>
> Patch-edited-by: Matthieu Moy <git@matthieu-moy.fr>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Matthieu Moy <git@matthieu-moy.fr>
> ---
>  t/t9001-send-email.sh | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> index 4d261c2..f126177 100755
> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -172,6 +172,28 @@ test_expect_success $PREREQ 'cc trailer with various=
 syntax' '
>  	test_cmp expected-cc commandline1
>  '
>
> +test_expect_success $PREREQ 'setup fake get_maintainer.pl script for cc =
trailer' "
> +	cat >expected-cc-script.sh <<-EOF &&
> +	#!/bin/sh
> +	echo 'One Person <one@example.com> (supporter:THIS (FOO/bar))'
> +	echo 'Two Person <two@example.com> (maintainer:THIS THING)'
> +	echo 'Third List <three@example.com> (moderated list:THIS THING (FOO/ba=
r))'
> +	echo '<four@example.com> (moderated list:FOR THING)'
> +	echo 'five@example.com (open list:FOR THING (FOO/bar))'
> +	echo 'six@example.com (open list)'
> +	EOF
> +	chmod +x expected-cc-script.sh
> +"
> +
> +test_expect_success $PREREQ 'cc trailer with get_maintainer.pl output' '
> +	test_commit cc-trailer-getmaint &&
> +	clean_fake_sendmail &&
> +	git send-email -1 --to=3Drecipient@example.com \
> +		--cc-cmd=3D"./expected-cc-script.sh" \
> +		--smtp-server=3D"$(pwd)/fake.sendmail" &&
> +	test_cmp expected-cc commandline1
> +'
> +
>  test_expect_success $PREREQ 'setup expect' "
>  cat >expected-show-all-headers <<\EOF
>  0001-Second.patch

I think you need to apply Eric's suggestions from:

  From: Eric Sunshine <sunshine@sunshineco.com>
  Date: Sat, 18 Nov 2017 21:54:46 -0500
  Message-ID: <CAPig+cSh0tVVkh0xF9FwCfM4gngAWMSN_FXd2zhzHcy2trYXfw@mail.gma=
il.com>

--
Alex Benn=C3=A9e
