Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DB9720951
	for <e@80x24.org>; Fri, 17 Mar 2017 17:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751327AbdCQRnB (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 13:43:01 -0400
Received: from mail-ua0-f181.google.com ([209.85.217.181]:33495 "EHLO
        mail-ua0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751286AbdCQRm7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 13:42:59 -0400
Received: by mail-ua0-f181.google.com with SMTP id u30so48434954uau.0
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 10:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NRDFe7SWRhPpKnIVBWIKC16u60X1IlLU9zKAOeMgNiM=;
        b=D+vmHSKZspFLXKibEIfkPEHRSvwvHWRBNZPGLq1g1MKFzNLWHnN4Ojwdk+wGBJ/b16
         kzgBDQ0Xwi/lo2dS1QXBjHGnw2UiHW/0vHBarMei5rCRPcnQVlYCxLIANjcuTfrD7p3b
         B4E57HHFjLZEeuVnC2jFFLJEMKOawZKRWjFVQysX3z+HMHK+VCYkORtqi/SlxB42wb55
         1yqglaQyX0hfI4yT918QnbneVGE+KZz3XwG/PgrMfoEnQdNj2jKMelvYOJCdHXmj2tSu
         mGa7Z+QL6xVwkwsW3ObCwUWRZ8inHxDyEf00GOlZRVEtU7cWP7EEJZAal4rqO8lsqzP2
         +Gfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NRDFe7SWRhPpKnIVBWIKC16u60X1IlLU9zKAOeMgNiM=;
        b=ojezvopJfqs6q3QCUKKftFmaw5urI0e4Jnw95A2SwnbU3ZL2Co/gG8cEacBluYEG6j
         q16NWT6gclNwxANPkcrPlaec9WSURtnrS1+YGZ2uO3FJXtuFxQJvv842pgEn0qtsyP9M
         9bwIMx8cO/laM1tAabhoNplzYOwPZEUdDE4rA9jTp9Ed0UfwxEuS8R9jV6QKDJJKxc+/
         5zqZRzCs5Kcy2IUxwKtQAEhhL3NbZjdLOIwLlCWdQoqwBcvvgCRuYbuDdO/uAugb5h/4
         z07Tn5rKoP0LL24rSNlUj1EjxJKzdc7V6AVkNMRcQZkIP43CJtiTTsp/ArOk4Y4FJfqt
         ouHA==
X-Gm-Message-State: AFeK/H2jz2F1LAsH5BuoPGKlsuMM0YV2D9Xvm4UJl8Aqf3kXk9A+NSZDS3h3BcZNNhAfbHPG8FBJM769D+ca7A==
X-Received: by 10.176.1.119 with SMTP id 110mr5333895uak.172.1489770688316;
 Fri, 17 Mar 2017 10:11:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.37.97 with HTTP; Fri, 17 Mar 2017 10:11:27 -0700 (PDT)
In-Reply-To: <ae12d1eaac8cec63bbfe0eae3b428b781fd34d30.1489762895.git.git@drmicha.warpmail.net>
References: <ae12d1eaac8cec63bbfe0eae3b428b781fd34d30.1489762895.git.git@drmicha.warpmail.net>
From:   Ralf Thielow <ralf.thielow@gmail.com>
Date:   Fri, 17 Mar 2017 18:11:27 +0100
Message-ID: <CAN0XMOKrm7BOx5RUD5ki1DF-WieVAmOmx5=eAOnJcaFB+iQxwg@mail.gmail.com>
Subject: Re: [PATCH] l10n: de: lower case after semi-colon
To:     Michael J Gruber <git@drmicha.warpmail.net>
Cc:     git <git@vger.kernel.org>,
        Ralf Thielow <ralf.thielow@googlemail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for both patches to de.po!

2017-03-17 16:04 GMT+01:00 Michael J Gruber <git@drmicha.warpmail.net>:
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
> Just a minor thing. I'm wondering about lower/upper case
> at the beginning of the line, though. Do we have a rule for de.po?
>

There is no rule nor is there consistency. :/ Some messages start with
lower case because the original english message is doing so, some do
not.

I do not think it makes sense to adopt rules like "error messages should
start with lower case" or something like that in translations so it's an er=
ror
to do so.

I will add this issue to my TODO list to fix this in the whole translation.

Thanks

>  po/de.po | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/po/de.po b/po/de.po
> index e9c86f5488..f8215945e7 100644
> --- a/po/de.po
> +++ b/po/de.po
> @@ -7599,7 +7599,7 @@ msgid ""
>  "more than %i tags found; listed %i most recent\n"
>  "gave up search at %s\n"
>  msgstr ""
> -"mehr als %i Tags gefunden; F=C3=BChre die ersten %i auf\n"
> +"mehr als %i Tags gefunden; f=C3=BChre die ersten %i auf\n"
>  "Suche bei %s aufgegeben\n"
>
>  #: builtin/describe.c:396
> --
> 2.12.0.484.g92f9ab2bc1
>
