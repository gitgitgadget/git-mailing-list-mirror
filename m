Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E3101F42D
	for <e@80x24.org>; Tue, 24 Apr 2018 09:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756293AbeDXJxf (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 05:53:35 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:45938 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756126AbeDXJxe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 05:53:34 -0400
Received: by mail-pf0-f196.google.com with SMTP id l27so11807557pfk.12
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 02:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3Aex8qwts3DZCizmMBHuUBvTDnCTvdRr9qJRzmwD9uc=;
        b=s/LgszewI41fLz/OA2xj+tuzdxVBHbXV1OG7w+JucWWmD68h88U5MmvLgIEGWu9udT
         i5KybikJKNhkqGUSGeADV60zWv0LtkvemQdG5g2ych/tMVf7Ac792UoxTGJiiRoPVSw1
         muCXJkgEe/SlilUV76J8J3qzT//pikUmO8pMfzZdwxmSylS0EFF7lbH+AdGs7aPknRXq
         8qnALdjoyc0wkmCbO2yFL75UHqDAlM0kAAhKzTwkKpCdXwYW2/jxv5IhELQTbbayMtxj
         mhqTJvVLnmiG/08us0Q+/+iJocf80Jq81wfrB6QYNQMajvkBoksg66zmNmRT3XVdueZY
         AKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3Aex8qwts3DZCizmMBHuUBvTDnCTvdRr9qJRzmwD9uc=;
        b=ieTPbeA+btVZdXh1Z3bbLpWFcUzsXgbi/yIYT28sHxd6g1Ng+nIJNIWJV9TO8OhXqs
         7dJfgUI6AIEWIeCsIIBgsiGOyJRfOpc0mZrt6bte4MYtRN/rCZat+p+1ftyc9XH3g1AI
         SFSXPOBEtKSHe3HLrmFbeYd07VzOC4ng7o8Q9uJ5Z0W/KlfWqwsTaPB/JBx/KOgOBKRL
         b4wdTrRuf4gtIlXzaF7Y8hUSzYjEJcSE6l3DR0d7aO64+Ztq7rTKPr0wes7WPVP9N4iw
         hpzpJM7l22BB8vo/gQ3KZY9FS/ScrGtuGZ0CNZOaO0q8DfCV+2Mp/reImKq5ffCPsSeH
         h1Hw==
X-Gm-Message-State: ALQs6tCMrdTny3wNkyoVsQH1lP4rLrZW9NJRl+EeWy6Dz5SBmi55I0NQ
        0p9vF97CG7WR0uhEFiOhe4ZFUAI2NwDXmy3eMuM=
X-Google-Smtp-Source: AIpwx4+PnplLCiEQRhwngGer7qkK3iz5RArX9hjsyfhVKB3VzAPYOBPHzo7j7gLXSJ0bTwjMVi80gEWfPymW4uU4icw=
X-Received: by 10.98.11.3 with SMTP id t3mr23399086pfi.32.1524563613729; Tue,
 24 Apr 2018 02:53:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.150.4 with HTTP; Tue, 24 Apr 2018 02:53:33 -0700 (PDT)
In-Reply-To: <20180423233951.276447-22-sandals@crustytoothpaste.net>
References: <20180423233951.276447-1-sandals@crustytoothpaste.net> <20180423233951.276447-22-sandals@crustytoothpaste.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 24 Apr 2018 11:53:33 +0200
Message-ID: <CAN0heSoCsFYqDmwTRCzh2FGDnOghBqVBTCOa7yEw0jtQ3LxDbA@mail.gmail.com>
Subject: Re: [PATCH 21/41] http: eliminate hard-coded constants
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24 April 2018 at 01:39, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> Use the_hash_algo to find the right size for parsing pack names.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  http.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/http.c b/http.c
> index 3034d10b68..ec70676748 100644
> --- a/http.c
> +++ b/http.c
> @@ -2047,7 +2047,8 @@ int http_get_info_packs(const char *base_url, struct packed_git **packs_head)
>         int ret = 0, i = 0;
>         char *url, *data;
>         struct strbuf buf = STRBUF_INIT;
> -       unsigned char sha1[20];
> +       unsigned char hash[GIT_MAX_RAWSZ];
> +       const unsigned hexsz = the_hash_algo->hexsz;
>
>         end_url_with_slash(&buf, base_url);
>         strbuf_addstr(&buf, "objects/info/packs");
> @@ -2063,11 +2064,11 @@ int http_get_info_packs(const char *base_url, struct packed_git **packs_head)
>                 switch (data[i]) {
>                 case 'P':
>                         i++;
> -                       if (i + 52 <= buf.len &&
> +                       if (i + hexsz + 12 <= buf.len &&
>                             starts_with(data + i, " pack-") &&
> -                           starts_with(data + i + 46, ".pack\n")) {
> -                               get_sha1_hex(data + i + 6, sha1);
> -                               fetch_and_setup_pack_index(packs_head, sha1,
> +                           starts_with(data + i + hexsz + 6, ".pack\n")) {
> +                               get_sha1_hex(data + i + 6, hash);
> +                               fetch_and_setup_pack_index(packs_head, hash,
>                                                       base_url);
>                                 i += 51;

s/51/hexsz + 11/ ?
