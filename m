Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BEBB1F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 10:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbfJUKj3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 06:39:29 -0400
Received: from mail-il1-f173.google.com ([209.85.166.173]:34260 "EHLO
        mail-il1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbfJUKj2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 06:39:28 -0400
Received: by mail-il1-f173.google.com with SMTP id c12so11553160ilm.1
        for <git@vger.kernel.org>; Mon, 21 Oct 2019 03:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=XMPLH+B+c0bVJMFd1FN5AAT63adoplThXfqcjqWwYRU=;
        b=G3Z6RhSjFppev0E685A0PLOx0Cy6Vlv+JzWRVFRICkl2e2JluFZFlsbMnY3fn5OoX/
         /BZGGkCIKdmg0PxA4T5DQrR/kuwfjIh2wr89XcyCQ83Be89LpyeYakhwtsQO+5v8kFAV
         ycY8sQyNhicVIFdR1jUi0Ke5xVAPB6EeRewBfSu/7TQK+jG1+vWX9+idacy0LbAJb16l
         HHZh9BRDME7Mvl9UzumqMN+oJTh44deLvmmPjm86vZoVx28c/TJQLMADltupz86nWO9+
         z6iCiWvN3t0GsX80B5zGWJ5OfibkVm+RC9P9NZOY39EouZZOpoDLhfRnu8efl+mAhHyg
         5pWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=XMPLH+B+c0bVJMFd1FN5AAT63adoplThXfqcjqWwYRU=;
        b=YRCjUTydG7qA9BIeHNAjN1eIbGJMGMUpbWHFUA9P3AIGziegxW2esKSEaxI+/0Eqiz
         FuG3+wF8ynwDBPDPcEjU6G8o/j7U+vIlwWGduA9BstSPcstnjI3nv/+IW2T9ZpUd1mhp
         zbJQXOcrXeP8o5PK3mbdgxSGX6KOWxBptreIBe2UtAlTgQF8notuyKK4dcWnUMlE6Blv
         N1CL3lW+hyV8drk8fabjY8Pfy1ATfUxYjrcgIs62AgQvFC4qGDhfkUD7YgYtU4GOKCZb
         OI4j85w7bdtQFxod37M0CGlx6RxJzcWnYIKFnmCeHhvL9BtIdvyASm3hZ2IyObjBSzvh
         v2FQ==
X-Gm-Message-State: APjAAAW7ZsG+/lB1aqqt2sZtLYJIEhqpt7dR6DVvoCh9i3pDLn7MktEf
        9Tn8t1uGjus5bbVAonN4+ZFtnhOxfssIZYbrXuk2J69L
X-Google-Smtp-Source: APXvYqylAk7RoypmjuC3ffIURWXI5eeOmmE+o2SzWCeOj5jcjNhR8fZ0GeBkLJ21Jgk9YTZr6w+4GhMPPZ+MX9bn65E=
X-Received: by 2002:a92:d3cc:: with SMTP id c12mr6536853ilh.127.1571654367786;
 Mon, 21 Oct 2019 03:39:27 -0700 (PDT)
MIME-Version: 1.0
From:   "Miriam R." <mirucam@gmail.com>
Date:   Mon, 21 Oct 2019 12:39:16 +0200
Message-ID: <CAN7CjDCacSKzN8fXgUe4ejNqM+AAe1o7NaDaFgM5WcYYV0bQ9g@mail.gmail.com>
Subject: [Outreachy] First contribution
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git developers,
I=E2=80=99m an Outreachy applicant, I would like to make my contribution to
apply to this Outreachy internship period.

I have found this issue tagged as open and goodfirstissue:
https://github.com/gitgitgadget/git/issues/230

But there is a PR from 4 months ago:
https://github.com/gitgitgadget/git/pull/271  and I don't know how to
find out if a patch including that change already exists or if it
makes sense to do it.

In case this issue is not suitable for my first contribution,  I have
also found this:
https://github.com/gitgitgadget/git/issues/379

In case any of them aren=E2=80=99t ok for you, I=E2=80=99ll try to find ano=
ther.

Thank you.

Kind regards,
Miriam.
