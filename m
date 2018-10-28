Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFF111F453
	for <e@80x24.org>; Sun, 28 Oct 2018 11:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbeJ1UN7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Oct 2018 16:13:59 -0400
Received: from mail-it1-f177.google.com ([209.85.166.177]:38526 "EHLO
        mail-it1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbeJ1UN6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Oct 2018 16:13:58 -0400
Received: by mail-it1-f177.google.com with SMTP id i76-v6so6418816ita.3
        for <git@vger.kernel.org>; Sun, 28 Oct 2018 04:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vrUQCw5ssPvsGZCokkX2OTRXDBreRPggsgo0IGHFpds=;
        b=hUIz2v57bqQ3kNiVywDE+EnGOPaZdokgdWV0MOHK4wSmSsLGIv6pjVL3MrOjirqyim
         fVOmcPQAFULVkgNpTFChNtODR5Y4yXkhinMgYo69PUZ7LLDconGVWbvB8KYPI/g7+0Aj
         KhVmjwzCu2X8kV1ZOApNuozpfPKd0aEAaggjcraDpype5WqyFcttfITgTSboBdHzdfN9
         yS+3Udbgp5cWiLTb8jeh0gtVK/rE937ZB/RpS1qfJ4OXUvRdpa5uxmUXeYWabmXNWiBt
         5mDS4DoMfoP+IOFwlpHK3Vuq5Ggw0HZ+4CThwJc1cqDEJrergxph3lc5Vso+WeFCvSeT
         URug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vrUQCw5ssPvsGZCokkX2OTRXDBreRPggsgo0IGHFpds=;
        b=mvOxqu8S+Fx7nCVwLZr60DkWS6NQWA4KRFAOsBEal9UcaTUtGBHfrCJHHuMcBJyAVt
         jUsgIzf9bYD0I/4pSvchlzgUUNeh1lMKlonip6Rzjme4D4yBRHrUU3UILc6M8BxqGYrq
         zgaFWReuWeXSmAjHvxI+ENOvu0j1ReMJ1I1MLYnrHe80v+4Q0OM32pLmRNmVlhpKk2Fr
         a9Zt2av1kotsuqBttBdPOz30hOkKhlgMu1AqouPnP3fOAPEWtdbpIUD+cIFm+WQSJ5U3
         nC84SVRbJYPQ4j5VRv28SNq5hCot5+ZbFB0Q2zNe/9J9jGZT1hcw0gAuB1vZ+wr5bfhY
         mWRA==
X-Gm-Message-State: AGRZ1gKvtDsj0C0YX7QhE4BLgi7JMSqZViAdNRsKb8mRe04EPn7lOj01
        Ou8PIQHq/HcnTxv360BFmPL/rMPYVS593NUkYL4=
X-Google-Smtp-Source: AJdET5f2e87lnoYO9ELz2kMDKSKPfcgx/HFojRmY88ygdEGSih5OPT6gDQWl6Lid4b5HgXijZQbI562/1rv8LGWBgRo=
X-Received: by 2002:a24:7804:: with SMTP id p4-v6mr7739553itc.123.1540726175701;
 Sun, 28 Oct 2018 04:29:35 -0700 (PDT)
MIME-Version: 1.0
References: <874dee7c-af9f-a609-c325-748160df89cc@1ec5.org>
In-Reply-To: <874dee7c-af9f-a609-c325-748160df89cc@1ec5.org>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 28 Oct 2018 12:29:09 +0100
Message-ID: <CACsJy8CGMs16xUaUEWvPgkjPt2PAFF2gpN_ksXSe6QDUAiPARw@mail.gmail.com>
Subject: Re: [PATCH] l10n: vi.po: fix typo in pack-objects
To:     mxn@1ec5.org
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jiang Xin <worldhello.net@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm not sure if Junio still takes .po patches or only Jiang Xin does.
I CC Jiang here just in case.

On Thu, Oct 25, 2018 at 3:05 AM Minh Nguyen <mxn@1ec5.org> wrote:
>
> ---
>   po/vi.po | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/po/vi.po b/po/vi.po
> index bc79319b6..e646825ed 100644
> --- a/po/vi.po
> +++ b/po/vi.po
> @@ -13663,7 +13663,7 @@ msgstr "=C4=90=C3=A1nh s=E1=BB=91 c=C3=A1c =C4=91=
=E1=BB=91i t=C6=B0=E1=BB=A3ng"
>   #: builtin/pack-objects.c:3382
>   #, c-format
>   msgid "Total %<PRIu32> (delta %<PRIu32>), reused %<PRIu32> (delta
> %<PRIu32>)"
> -msgstr "T=E1=BB=8Fng %<PRIu32> (delta %<PRIu32>), d=C3=B9ng l=E1=BA=A1i =
%<PRIu32> (delta
> %<PRIu32>)"
> +msgstr "T=E1=BB=95ng %<PRIu32> (delta %<PRIu32>), d=C3=B9ng l=E1=BA=A1i =
%<PRIu32> (delta
> %<PRIu32>)"
>
>   #: builtin/pack-refs.c:7
>   msgid "git pack-refs [<options>]"
> --
> 2.18.0



--=20
Duy
