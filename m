Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D79F91F453
	for <e@80x24.org>; Sun, 20 Jan 2019 09:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730264AbfATJCT (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Jan 2019 04:02:19 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42993 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729513AbfATJCT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Jan 2019 04:02:19 -0500
Received: by mail-lf1-f67.google.com with SMTP id l10so13384660lfh.9
        for <git@vger.kernel.org>; Sun, 20 Jan 2019 01:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hWvii/t1efZiU1euaUm6CraXOWY3ql3EYBI2P6NC/3k=;
        b=iBZaosm1WAEeoW26W+7FF3Vz/fQk7gybGFrJ5JKATbV7hzG1frxpPBZkhvJ+PMsNKJ
         JJ+/GPNt3koIhm89Qg+sAGL5mJ0a3Ul6sSlY2D1QFQW52PeODa2knKfzLke9TNTDXJj3
         TLWvHpF8Xfq2ueK7n8QmoUwoxOWzRJnA9sMYGbrDohIaI3xJc628Ap5Cj77j+RByWIjX
         XfKmBCoeVFNrEODPst3Qp3q9lQXrEJTlCNhwknt9Do2bDgyGb99LP+kiRKsh07WeLBu3
         +yFW5PGOzIPS4z4cnZSyKvawj5uIQSRV9aPBb1fay5o1kzZumZK8CqT4Hiida5ysYmCv
         uRZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hWvii/t1efZiU1euaUm6CraXOWY3ql3EYBI2P6NC/3k=;
        b=Ni4jrS101915C7HwivFF7tHLu88RRJ8rdqC+1/wTR9mXCjE+61DFSEcY2bWKNT7j0W
         HmQGK6acdYgLu5rz6vTRPNQfGTXJUYJSz/JxUxPyp831euP8j7Q+/qWzc+CPzJp8WeKh
         8NALjQJLJNIV+sZD6pHiiSWdPcHNKwPeleRegoj3SQahd1JG08R3Y4Muv+1pY9OaXZfr
         es7Uo7BuelG9Jgx5/YWA5dZe1mCz7J3Dgp+jroUuE0/R2Nx+i7Bia9QnzTwdyag8fPLq
         qrCcbZG+qFsrd2Eax0mWXtiNADs+9OCtsvP1OBOdT37z7ftw+/z2zp3xcqA7LIdjf100
         DD9g==
X-Gm-Message-State: AJcUuke/6+mkJqYaKwvYJidn+Lt0KNf1ks30s/t5E2E6DuDB+zy7b5lE
        47Qcp7/8etpan4F2DIUn5Dx4C8SEqVPfFgWK7Yk=
X-Google-Smtp-Source: ALg8bN6Z7fysaL7o+9Qivjma6ZWBuUOwFz+RIKjmxAwvLUO5P+qTQK+xvERB9/XwLNhUKVb1AP+5vw+aMTzuDoEQY/Y=
X-Received: by 2002:a19:9fcd:: with SMTP id i196mr15866562lfe.82.1547974936976;
 Sun, 20 Jan 2019 01:02:16 -0800 (PST)
MIME-Version: 1.0
References: <20190119232334.31646-1-brandon1024.br@gmail.com> <20190119232334.31646-2-brandon1024.br@gmail.com>
In-Reply-To: <20190119232334.31646-2-brandon1024.br@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sun, 20 Jan 2019 10:02:03 +0100
Message-ID: <CAN0heSr3a9H46j3wiTwwbw7HFh4+4aFs5-qe=gtxYB3vC73KAA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] commit-tree: add missing --gpg-sign flag
To:     Brandon Richardson <brandon1024.br@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brandon,

On Sun, 20 Jan 2019 at 00:24, Brandon Richardson
<brandon1024.br@gmail.com> wrote:
>         # explicit -S of course must sign.
>         echo 10 | git commit-tree -S HEAD^{tree} >oid &&
>         test_line_count = 1 oid &&
> -       git tag tenth-signed $(cat oid)
> +       git tag tenth-signed $(cat oid) &&
> +
> +       # --gpg-sign[=<key-id>] must sign.
> +       echo 11 | git commit-tree --gpg-sign HEAD^{tree} >oid &&
> +       test_line_count = 1 oid &&
> +       git tag eleventh-signed $(cat oid) &&
> +       echo 12 | git commit-tree --gpg-sign=B7227189 HEAD^{tree} >oid &&
> +       test_line_count = 1 oid &&
> +       git tag twelfth-signed-alt $(cat oid)
>  '

Thank you for following through.

Let's see if there any opinions from others about this more verbose
construction, vs placing the oid in a variable and quoting it. We
obviously went several years without realizing that using $(...) as an
object id risked falling back to HEAD and that a completely broken `git
commit-tree -S` would pass the test. So being over-careful and extra
obvious might very well be the right thing.

>  test_expect_success GPG 'verify and show signatures' '
>         (
>                 for commit in initial second merge fourth-signed \
> -                       fifth-signed sixth-signed seventh-signed tenth-signed
> +                       fifth-signed sixth-signed seventh-signed tenth-signed \
> +                       eleventh-signed
>                 do
>                         git verify-commit $commit &&
>                         git show --pretty=short --show-signature $commit >actual &&
> @@ -82,7 +91,7 @@ test_expect_success GPG 'verify and show signatures' '
>                 done
>         ) &&
>         (
> -               for commit in eighth-signed-alt
> +               for commit in eighth-signed-alt twelfth-signed-alt
>                 do
>                         git show --pretty=short --show-signature $commit >actual &&
>                         grep "Good signature from" actual &&

Ah, good catch. I didn't notice that we had a separate for-loop for this
key. This comes from 4baf839fe0 ("t7510: test a commit signed by an
unknown key", 2014-06-16). What we want to test here is something
different, namely that we're using a specific, named key. But FWIW, I
think we're fine, and that we're not abusing the existing difference
between these two loops too much.

Martin
