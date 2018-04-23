Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 074371F424
	for <e@80x24.org>; Mon, 23 Apr 2018 06:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751324AbeDWGH5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 02:07:57 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:35849 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751268AbeDWGH4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 02:07:56 -0400
Received: by mail-qk0-f169.google.com with SMTP id a202so15061188qkg.3
        for <git@vger.kernel.org>; Sun, 22 Apr 2018 23:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=4OnKuApOJl655/zlMXEZH5q8Y1ExQxwqlJEpCl203Is=;
        b=ES9jGW8fIvHkLV6hBpT40wNXkJGx0GDvTAbJWalP96Vb9cGiR/tLn7xC8PCQpmu6e7
         5AHEdyGwzgIPPf3aKexNzyjhjOTs8lTbKyY12j5JQ5H7RJNCV2P8YOPV0rDAmdgvV5U3
         lDDCbjxtJ/JlmUHNL4SAQQLfYUaJo3UmheldGBq3laMRkudyhR17+GXH7hXi4467GMUY
         rW9XuxO/UB8B34pYzLR5PWFAFPoUdPlNNH35ig9XlrfPULqei4apzm9+uFcvQ18YEvpF
         ymWdZg6r9l0RcabFyoR1Jg5150NLMAX0/kU6g4bnSd8LdjqtNfg/eGcwsmbeMVKx3RAJ
         I7mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=4OnKuApOJl655/zlMXEZH5q8Y1ExQxwqlJEpCl203Is=;
        b=QZPA2UuGeHgesyWfU3P06c+YzzFOFMGyUSmw/QX/9a9JMio49ZpTF1mU0Ds9Q0JauP
         RU3BZhB4si1/BpaNFhilGuAPf11S+1ExiSDSWKT/pcPIBXGsC76UcBDkmZjZWWeaIxBA
         UraB8+NQMqKPn0D9Zir3JjbUtp9TcyiK3HqwM5hW2zHFJwaaYdxpHa5RKEUs2eaJWiWb
         9X6RxqKz0ypGqzAe1CabEKJhtvF0RwYrvkloIFHXAgp49OfBuSSmb4UgECssm01G4VYQ
         FQAU36+aCdWHHnIZHzHB0OOPh13m7F2SUSTwhXD7R5cYUSFUK9zPcEA+7eGFruQPYTz+
         y5Ig==
X-Gm-Message-State: ALQs6tCw6iMp7dw3Ac4pa9czXbN0F7DC1LLDgDZH5K6eChBHBkXlATuw
        KNYO2EK5tOuJAEwMZgX0xW4lbBcDitgv8WMGbTo=
X-Google-Smtp-Source: AB8JxZoCOyJOsuimMWP4i0KLHjmPeZn6pA0IT37fXlwXfudQda//B6dw2Zv06f4T/q9Cge8vyQmVCSpprbsWDi6QB0w=
X-Received: by 10.233.220.1 with SMTP id q1mr20073862qkf.361.1524463675417;
 Sun, 22 Apr 2018 23:07:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Sun, 22 Apr 2018 23:07:55 -0700 (PDT)
In-Reply-To: <20180421165414.30051-7-pclouds@gmail.com>
References: <20180415164238.9107-1-pclouds@gmail.com> <20180421165414.30051-1-pclouds@gmail.com>
 <20180421165414.30051-7-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 23 Apr 2018 02:07:55 -0400
X-Google-Sender-Auth: 5_oorZI6Al_yKPnjet-wYzUhd2o
Message-ID: <CAPig+cQnmpR_WGZqb+A8zoH3D60VeJ0CWZkR0hXA_fgJSjWLUQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] help: use command-list.txt for the source of guides
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 21, 2018 at 12:54 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy
<pclouds@gmail.com> wrote:
> The help command currently hard codes the list of guides and their
> summary in C. Let's move this list to command-list.txt. This lets us
> extract summary lines from Documentation/git*.txt. This also
> potentially lets us lists guides in git.txt, but I'll leave that for
> now.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
> diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
> @@ -58,7 +58,11 @@ command_list "$1" |
>  do
> -       prefix=3Dgit-
> +       if [ "$category" =3D guide ]; then

Style:

    if test "$category" =3D guide
    then
        ...

> +               prefix=3Dgit
> +       else
> +               prefix=3Dgit-
> +       fi
