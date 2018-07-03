Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E05F01F516
	for <e@80x24.org>; Tue,  3 Jul 2018 07:14:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753213AbeGCHOU (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 03:14:20 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:45978 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753539AbeGCHOU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 03:14:20 -0400
Received: by mail-vk0-f65.google.com with SMTP id l64-v6so498320vkl.12
        for <git@vger.kernel.org>; Tue, 03 Jul 2018 00:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0Ef2WDr3p0+DYWZv57rx8Y5lLuOZv1FyPLEMLg7XvlQ=;
        b=TkVdAwn1R3ZJ/WmbHOaVAkcNP1ySPfv82Pyek2SjG6ElEQOLDhXDC2oioUJFUAFGR8
         LmSBleVlFLes9lEQ0dGNsjWlB5AtU8iTzen3PBY2VXAS39nSOv4VmkL9kChustj0Wb5g
         4ATH1bCj86J4k44xyFVPgfCFcFLrZErEf49H+poa+hk2JTtEBDNiqaHJD7bICU9fV7Iy
         m3+Cop7gFG+5j37gWR02fm0KyiUDkMpW/KT/t9qiJy2OdrYetJN5jx1wE1LjmZxHNmn3
         IMQF7bpa8sZqabVNPySVUzxWKIxrv9shFQJwh1QGp2aoj7ayRnzJ30Rvvh45/PnxBtaA
         jf2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0Ef2WDr3p0+DYWZv57rx8Y5lLuOZv1FyPLEMLg7XvlQ=;
        b=ShvJmdKE97OS0/tlYSe6NG7zUXIiCMCsPKcJSF182EMeu6wI36EiYyf6tUwCMJ4aKI
         gvbL+IZjrAwl8U2inhzrauNAmyZca+tnKHM8DLgBatbx4bgI3fApMc/zsGhk84ZGtcuz
         Z4tMsxVj22V8jDsZpfQyo70OSGstHILt+WqBjTLAdnKHVbg665t3HrKDZ9GBqmdGybFh
         N3ZogEL4eBtXW3Lvo6jmGOnxEBk5SbrounTRkNLfbWeF2kPPuGBuCrcJu4ZZsST8IVL5
         4KOtn8xxUNYbV1ugUNOi3dDNliTsVkmOjYAfMKv6xDCo6a6IBaY+YrvfMZKDA5RxSKaO
         8Njw==
X-Gm-Message-State: APt69E2wGNp9OrUe+d/FN2pBQwqMbhAWhy21l5Czu+8hDTSkpBzpvp6J
        qnTNUtiroSgm6yKkLKAAek7fmyOFeRI9+gbeEYk=
X-Google-Smtp-Source: AAOMgpdufs2KyD817+lld5lns1jxf368Tf8nkJdrxzPRZ02vrdv0roCcGtvUHPOjuI0fKjD1ZS6OUASnuljSuN9pHqg=
X-Received: by 2002:a1f:3a89:: with SMTP id h131-v6mr3369144vka.184.1530602059269;
 Tue, 03 Jul 2018 00:14:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:21c7:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 00:14:18 -0700 (PDT)
In-Reply-To: <20180703035802.24060-2-jyn514@gmail.com>
References: <20180703035802.24060-1-jyn514@gmail.com> <20180703035802.24060-2-jyn514@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 3 Jul 2018 00:14:18 -0700
Message-ID: <CABPp-BFLciH4H712LzwXyn22esRU6FN87SLbUqOJP3CKvx+DdA@mail.gmail.com>
Subject: Re: [PATCH 2/3] ls-tree: update usage info
To:     Joshua Nelson <jyn514@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Joshua,

On Mon, Jul 2, 2018 at 8:58 PM, Joshua Nelson <jyn514@gmail.com> wrote:
> show [tree-ish] and [--] as optional

You're missing a Signed-off-by tag here.

> ---
>  builtin/ls-tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git builtin/ls-tree.c builtin/ls-tree.c

No corresponding update to Documentation/git-ls-tree.txt?

> index 14102b052..c5649b09c 100644
> --- builtin/ls-tree.c
> +++ builtin/ls-tree.c
> @@ -26,7 +26,7 @@ static int chomp_prefix;
>  static const char *ls_tree_prefix;
>
>  static const  char * const ls_tree_usage[] = {
> -       N_("git ls-tree [<options>] <tree-ish> [<path>...]"),
> +       N_("git ls-tree [<options>] [tree-ish] [--] [<path>...]"),
>         NULL
>  };
>
> --
> 2.18.GIT
