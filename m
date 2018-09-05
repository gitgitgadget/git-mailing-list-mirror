Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D56531F404
	for <e@80x24.org>; Wed,  5 Sep 2018 16:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbeIEV0Y (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 17:26:24 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:35666 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727145AbeIEV0Y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 17:26:24 -0400
Received: by mail-it0-f66.google.com with SMTP id 139-v6so10364719itf.0
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 09:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ai5vfZYwn0pHoqd8JptR+bEqjMC0eZrmo6aKPOnfAD8=;
        b=lifpTzD8hsBtWuxc+OaqEvc5izXACcgrI2oqGXL83pZ7/W0gZW3Wfs65yl8OyA4eMZ
         4HJYfXREWzo97NbS9fojcSMJ/QnjuTHMQqjmqV2Xs2/hszd6kIRM4qfgDRSO8N47NN0S
         lwTbtMDiP3dSzAZ7+RXfQ6ABoOaawj7DUz842AU8rtKqVmDRcHbZfwfoL6EqfGFinZGn
         YbnqzIAI2B/SeXMjtoeXZ0clzM0qCuOk5gMvcs6I1krlL1fUQmftPZCT5buYUTLHVbbg
         6wlFVnFllkzrqnz+IZpBBCyifMuA9YK0FLu3fY6THB3Nz+ZZpdEZVOu6pK+d7kWElSM8
         bwBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ai5vfZYwn0pHoqd8JptR+bEqjMC0eZrmo6aKPOnfAD8=;
        b=L0Lfp45celckjgtRQrNK1Rd/aAmwHNpf01xhvLrdff2CRa/KcooJnK8BKi2rZ3++KE
         x0vWNvlxt6vvDj/H72kkUIbst9alBjVb+DibeWmxoA+ippVI93+nZhQIQQF7uBjOgkjs
         sQQlxT0sh4EBY2aT65+L+8ah9K8hnARBL5/czXDg+rl648NJ5SwUVNtEzjLWlwwXAje/
         slosjD9g5o/z4cfkS6x0xGjlBobjjcZJwqZ4xJtcX8wFG/HEcTI6MAhlVqqpFyWNxjNj
         55o798KFlSFHFjYRaqICvakdg80SIjN6EyaU0LFIb70xLGu0JBqskVyf5viKonZ76gzn
         pxbw==
X-Gm-Message-State: APzg51B4stYdgYaNZv/aEdU7lZFffzyv9/NBRuLV18lP79HqjqUHqQrS
        +XvODURT5BYpE/Xxr4QP/R75xm+5z2Oxkq+uufs=
X-Google-Smtp-Source: ANB0VdYssyD1ADw+sYKHuJBRMHoheiimD3FLsjOz6NaOF1SEqvkdPssTQEnC+3WmvspxiQkii4IOB1In5CJkdC5ZmCE=
X-Received: by 2002:a24:328d:: with SMTP id j135-v6mr1138935ita.5.1536166521794;
 Wed, 05 Sep 2018 09:55:21 -0700 (PDT)
MIME-Version: 1.0
References: <20180905164753.22711-1-newren@gmail.com>
In-Reply-To: <20180905164753.22711-1-newren@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 5 Sep 2018 18:54:55 +0200
Message-ID: <CACsJy8Cf5+3+6yDwe4Y4wYLze4Y6naW-pj134KTpXM+wyWbFVQ@mail.gmail.com>
Subject: Re: [PATCH] merge-recursive: remove superfluous semicolon
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 5, 2018 at 6:49 PM Elijah Newren <newren@gmail.com> wrote:
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
> Once I saw it, I couldn't unsee it, and it quickly started getting on my
> nerves...

Bad Elijah! Should have grepped and fixed all three ;-)

$ git grep ';;$' -- '*.c'
builtin/receive-pack.c: hmac_sha1(sha1, buf.buf, buf.len,
cert_nonce_seed, strlen(cert_nonce_seed));;
merge-recursive.c:      struct dir_rename_entry *entry = NULL;;
remote-curl.c:          options.filter = xstrdup(value);;


>
>  merge-recursive.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index e5243dbc54..1b5c255918 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -2239,7 +2239,7 @@ static struct dir_rename_entry *check_dir_renamed(const char *path,
>  {
>         char *temp = xstrdup(path);
>         char *end;
> -       struct dir_rename_entry *entry = NULL;;
> +       struct dir_rename_entry *entry = NULL;
>
>         while ((end = strrchr(temp, '/'))) {
>                 *end = '\0';
> --
> 2.19.0.rc2.1.g7fc77f67e1
>


-- 
Duy
