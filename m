Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 907B91F576
	for <e@80x24.org>; Tue,  6 Feb 2018 07:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752183AbeBFHcp (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 02:32:45 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:33468 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751835AbeBFHco (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 02:32:44 -0500
Received: by mail-qk0-f194.google.com with SMTP id c82so1141724qka.0
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 23:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=42bgXOSkTM29qVL8y/IkYX6GZZXgdN0DnIgOWMBf1cA=;
        b=Lt+8MD+9Lslvk/kw970e/X2MAn6eira3cJrvsscRA1FHkLB146pD2uPDms5U2QtQJM
         atRjvHXqG61a5qpBjSFM9+Mvrp1tu0MgEznyi8bJaky6KdkBiAc38Pr39IWdskywOtQH
         lSzid0WCaCo8n30MB0kOp+vByWVCUl01nnYbue1kzPF3WZgYY5bIhTv1d8bzHGdHYg85
         ywRptl1qjKQYrwrk+l4SLyRIOnx+hpWKQ4eIEFiAIMaD5cO+UJzhccSiMsQ/FcTUARC9
         kevUGTEU7bm7H7KcxpqEE28d5csj+rec9L56RZwNGnaG4GqGA+eCpQoAauC8Tn9JEzFT
         0SbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=42bgXOSkTM29qVL8y/IkYX6GZZXgdN0DnIgOWMBf1cA=;
        b=rQMzXCMqJD0XWVt3c+Q01VY+X2yDdeqm9wp6G6x05cN92JVmNrmJVr2PY6bOTsqzhw
         8uikiKBhxy/2+cUNfhX0TsT+LttuXNJchfwkkBFgqrdueqLd7vwvs3k3fPt8ReQnLmZU
         sVPEjzd70nPl99iFArmm0BKq5gymu76ZCB6LIIm/Xl84M6whW0Zi9S68S3c104zcQKNk
         FirDmgxn6E1FiAe9kydE7BPDJqEdfvccArKnTuguWBpjYiVuOdPya//vdYOxa0BS0mHc
         VyZ9oMva/bmMYxcVP3VWkC1WhWOLr2tQuT5M49AO71NfC2zlDvqZojugGHbxyd0C91J+
         y2WQ==
X-Gm-Message-State: APf1xPD6u6qb3LJ4/uUU9WvPpudLlGjjJnyGdv/iDBrkXCXfxVz7B56c
        lC5UZmjmqqXdNR3+VrpL3vWZhSbG761saSZkIBk=
X-Google-Smtp-Source: AH8x225fAl5Dc47sr64cgGdLSDi7fzc5eZike08FCh6o7dzXqqA7Jht6ePIF9Ul3yn6NTr3klGpaRACcgfFTVqTf5cA=
X-Received: by 10.55.177.135 with SMTP id a129mr2190376qkf.112.1517902363498;
 Mon, 05 Feb 2018 23:32:43 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Mon, 5 Feb 2018 23:32:42 -0800 (PST)
In-Reply-To: <20180206061537.2573-2-ash@kambanaria.org>
References: <20180115054419.4112-1-ash@kambanaria.org> <20180206061537.2573-1-ash@kambanaria.org>
 <20180206061537.2573-2-ash@kambanaria.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 6 Feb 2018 02:32:42 -0500
X-Google-Sender-Auth: 1j6z7vdWpPHbIEHmSj75VBKVPD8
Message-ID: <CAPig+cSOgNfz+cYdcvsbbaf74RB0QNnmqLs9Ld9xdmarMaqzEQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] Mark messages for translations
To:     Alexander Shopov <ash@kambanaria.org>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jiang Xin <worldhello.net@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 6, 2018 at 1:15 AM, Alexander Shopov <ash@kambanaria.org> wrote:
> Small changes in messages to fit the style and typography of rest
> Reuse already translated messages if possible
> Do not translate messages aimed at developers of git
> Fix unit tests depending on the original string
>
> Signed-off-by: Alexander Shopov <ash@kambanaria.org>
> ---
> diff --git a/t/t0002-gitfile.sh b/t/t0002-gitfile.sh
> @@ -31,7 +31,7 @@ test_expect_success 'bad setup: invalid .git file format' '
>                 echo "git rev-parse accepted an invalid .git file"
>                 false
>         fi &&
> -       if ! grep "Invalid gitfile format" .err
> +       if ! grep "invalid gitfile format" .err

Since these strings can now be translated, you'll probably need to use
'test_i18ngrep' rather than 'grep'. (See test_i18ngrep in
t/test-lib.sh.)

>         then
>                 echo "git rev-parse returned wrong error"
>                 false
> @@ -45,7 +45,7 @@ test_expect_success 'bad setup: invalid .git file path' '
>                 echo "git rev-parse accepted an invalid .git file path"
>                 false
>         fi &&
> -       if ! grep "Not a git repository" .err
> +       if ! grep "not a git repository" .err
>         then
>                 echo "git rev-parse returned wrong error"
>                 false
> diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
> index d27f438bf..5743b482f 100755
> --- a/t/t0008-ignores.sh
> +++ b/t/t0008-ignores.sh
> @@ -307,7 +307,7 @@ test_expect_success_multi 'needs work tree' '' '
>                 cd .git &&
>                 test_check_ignore "foo" 128
>         ) &&
> -       stderr_contains "fatal: This operation must be run in a work tree"
> +       stderr_contains "fatal: this operation must be run in a work tree"
>  '
