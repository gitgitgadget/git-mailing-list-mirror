Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91B2D1F731
	for <e@80x24.org>; Sat,  3 Aug 2019 13:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390653AbfHCNuV (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Aug 2019 09:50:21 -0400
Received: from mail-qt1-f181.google.com ([209.85.160.181]:43665 "EHLO
        mail-qt1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfHCNuV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Aug 2019 09:50:21 -0400
Received: by mail-qt1-f181.google.com with SMTP id w17so32518984qto.10
        for <git@vger.kernel.org>; Sat, 03 Aug 2019 06:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AO+g+PGSpSQ09T+E3K8RbaAc2/nrH15TEd1Hv2MVRss=;
        b=kZMr4eekyTLQE7yAt7hmF2Vn0iAtn/iJIOhZp/ezchYgJVYE7Ag+p3215Ga7CHdl+D
         9QtrIEf8KUsZfbYdwIPJLBftQVZjx82Tp1sHT4mOJZfq8mZ+kT2rItPzcDnpTCZNIODu
         q2VX3O/wMZfTAMGg+VF75Vfs2v35CmSI9o7Wk3lgi8j/jm/tVAZYeur2NidJ1JrdBtCa
         7uTcI/3YKc0A/n1I7jssai7zOXRqXk2vQ+7qRe9qWevalxZ3yI6pkowzr5GhLU5+E5Gw
         k52D5M8dWdMPe7uPJTzlfkHnB28Efznve1woNSgVOItZF6alALOlfp6cTf93GIcVMkMW
         KNOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AO+g+PGSpSQ09T+E3K8RbaAc2/nrH15TEd1Hv2MVRss=;
        b=Y4rLQ0BqYBWf98DgBq1mcbhDzlI5YnHvBgZSfXlcDAyQQMABVl8SsOOcl+i4rAEDBg
         iWmBpFp5PFvi0gV4hPo2A9g0t1o++OxGHAXmifhPW7YoRZZ8o9+mcfzlWCg5gP7lYsQg
         3iaHw3pGLFhpvtr//YFzt08AXAE3Tj6XFIKxrWsnpCaKh1LB6GwowLELE1vvhxbLk4ml
         Lr/TwfK4T2Th/XQSAV/gd4R8ZHC+XA7MnarQjWbDt2Z2nC5o8k+QUbD1sk/mCE13jWq+
         b1ZW+YiBDxVOQME1xgR464t1e00INeSt/1Sai02l3gcqAqy1MHgjLNIfWk28XXa8nrtT
         aIlA==
X-Gm-Message-State: APjAAAV3xh3iGWX6XtOR2bphLzq5L6nBNo9ON/tr4uelT1lwKnLbQHoQ
        ZVAr2x25vLKUXTUi6ls4nAMJ4HliWP3bc8oN7d0=
X-Google-Smtp-Source: APXvYqzZxXua3Tj7emfCRLXPtAOWIzydBFWksGj4MYXStWGvP4Pq2EzSLAEAzcmWZSCN6FqkzZE00cU52ELA62dBJhQ=
X-Received: by 2002:ac8:4442:: with SMTP id m2mr42805825qtn.107.1564840220479;
 Sat, 03 Aug 2019 06:50:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190730033512.7226-1-worldhello.net@gmail.com> <20190803101832.30307-1-jn.avila@free.fr>
In-Reply-To: <20190803101832.30307-1-jn.avila@free.fr>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Sat, 3 Aug 2019 21:50:09 +0800
Message-ID: <CANYiYbEjnQS=3Rb4YsLFJLPJQOSk+rZwoHQj_=2A=NhdGEKczw@mail.gmail.com>
Subject: Re: [RFC] l10n: fix some typos for v2.23.0
To:     =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jean-No=C3=ABl Avila <jn.avila@free.fr> =E4=BA=8E2019=E5=B9=B48=E6=9C=883=
=E6=97=A5=E5=91=A8=E5=85=AD =E4=B8=8B=E5=8D=886:18=E5=86=99=E9=81=93=EF=BC=
=9A
>
> Signed-off-by: Jean-No=C3=ABl Avila <jn.avila@free.fr>
> ---
>  builtin/checkout.c | 2 +-
>  builtin/fetch.c    | 8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 91f8509f85..75efc37bc7 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1769,7 +1769,7 @@ int cmd_restore(int argc, const char **argv, const =
char *prefix)
>         struct option *options;
>         struct option restore_options[] =3D {
>                 OPT_STRING('s', "source", &opts.from_treeish, "<tree-ish>=
",
> -                          N_("where the checkout from")),
> +                          N_("where to checkout from")),

I'm not sure, which is better? or "where the checkout is from"

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 53ce99d2bb..3422e6bdf7 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1005,12 +1005,12 @@ static int store_updated_refs(const char *raw_url=
, const char *remote_name,
>
>         if (advice_fetch_show_forced_updates) {
>                 if (!fetch_show_forced_updates) {
> -                       warning(_("Fetch normally indicates which branche=
s had a forced update, but that check has been disabled."));
> -                       warning(_("To re-enable, use '--show-forced-updat=
es' flag or run 'git config fetch.showForcedUpdates true'."));
> +                       warning(_("Fetch normally indicates which branche=
s had a forced update, but that check has been disabled."
> +                               "To re-enable, use '--show-forced-updates=
' flag or run 'git config fetch.showForcedUpdates true'."));

It is a very long line, you should add line breaks and format the message, =
like:

+                       warning(_("Fetch normally indicates which branches =
"
+                                       "had a forced update, but that\n"
+                                       "check has been disabled. To
re-enable, "
+                                       "use '--show-forced-updates'\n"
+                                       "flag or run 'git config "
+                                       "fetch.showForcedUpdates true'."));

>                 } else if (forced_updates_ms > FORCED_UPDATES_DELAY_WARNI=
NG_IN_MS) {
> -                       warning(_("It took %.2f seconds to check forced u=
pdates. You can use '--no-show-forced-updates'\n"),
> +                       warning(_("It took %.2f seconds to check forced u=
pdates. You can use '--no-show-forced-updates'\n"
> +                               "or run 'git config fetch.showForcedUpdat=
es false' to avoid this check.\n"),

Try to make a better format, like:

+                       warning(_("It took %.2f seconds to check
forced updates. "
+                                       "You can use\n"
+                                       "'--no-show-forced-updates' or run =
"
+                                       "'git config fetch.showForcedUpdate=
s\n"
+                                       "false' to avoid this check.\n"),

>                                 forced_updates_ms / 1000.0);
