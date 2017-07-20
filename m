Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E355720387
	for <e@80x24.org>; Thu, 20 Jul 2017 07:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934192AbdGTHma (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jul 2017 03:42:30 -0400
Received: from mail-yb0-f176.google.com ([209.85.213.176]:37884 "EHLO
        mail-yb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934186AbdGTHm3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2017 03:42:29 -0400
Received: by mail-yb0-f176.google.com with SMTP id c127so4120863ybf.4
        for <git@vger.kernel.org>; Thu, 20 Jul 2017 00:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=devcom-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=QxVqDI9zSmWzXjRWoioLoqBW0KzUhTVu+PqXLVkzpRo=;
        b=C4sj1xZ5GMrfcj74Wl0chklBohbFthF32vm5dInq5+4+HnF6vDJeCbGx06i+DImk5K
         AYqYD4GxFx5PJPsSUoZYZY0Wo1iXLQtvQgjT7k720C08iJxKDRV7NhBB4qumHgSPJAj6
         QXA1hqnJ90ejV9hgRneAxMBql9QvkPflb9Tb4MKwMiHBP3HDK7wRLLr0EYuUot4EiJM/
         s2/LDtZwfEV5e6HlO6iQDcBttHTVNR8jCvEpaydsYmSyYLY6TfqRlLsTb3mxOfBuj4qV
         kMuU2uupx901L/M/nIgrpNTOSd7EmbS+uKXXWT2auuuGAZyMn3AFIX6eNOMWJsP7r+r8
         1PKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=QxVqDI9zSmWzXjRWoioLoqBW0KzUhTVu+PqXLVkzpRo=;
        b=q6vaqQLHK/LUzar8v5KpbFr0yjzRKRe6oejbsXPJ4spNNReoJ2eNaj95fLIjdW9/xP
         YvdBWRWplABTHzY1UIgFVyndW+pePuZM0SfRk3GKeS8SZf4ddRXgP5iC9GsTckIKwfnx
         ahcNaK0Ni7GKW0klaekTiyXn9TkQyqEBOmgYlvqzkEmrrzg0EWPQy1M4rGPZMgqfk3/o
         y6YwsadVEBksAH5A1VCO5Nym4OkZab7lGysV/EfmPFNv71+RBgmVd7zds0yQRX0w+DIn
         qsQi9Kegmb80dnLAXzPdXX0gbr4vNO9ZbekdraM0XL8qDItT4YEpEiTwix0PgIWG/MH9
         ltOQ==
X-Gm-Message-State: AIVw111wVxmJ/UgSE/0GkT8ZI0+znA8np/UEX18PBVOF7994skLTIOa5
        16CmqD1VqjHMMHsZhR0XZRp8ca+HsBn7X7f3/wuDB8pifW8hkszhfT21QnVvk8l/sKWQpLqLJh6
        dEbUGm+zhgw5CkCwifd+wtxQ8ITld8Nj9vPEk8NMDCvfdVNVEu2IjhZs7mkY4Fo8tFKyzRUOp
X-Received: by 10.37.172.12 with SMTP id w12mr2376230ybi.86.1500536548799;
 Thu, 20 Jul 2017 00:42:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.198.3 with HTTP; Thu, 20 Jul 2017 00:41:48 -0700 (PDT)
In-Reply-To: <CAFc9kS8L-JJoJqKi7bB90qwKVW8gB=EFk9D8c=4YShqnamwa2w@mail.gmail.com>
References: <CAFc9kS8L-JJoJqKi7bB90qwKVW8gB=EFk9D8c=4YShqnamwa2w@mail.gmail.com>
From:   Volodymyr Sendetskyi <volodymyrse@devcom.com>
Date:   Thu, 20 Jul 2017 10:41:48 +0300
Message-ID: <CAFc9kS_xYVyPsW7qogDxLugxBb1p2vEFAoP=W9Rdnfqs6XtWKQ@mail.gmail.com>
Subject: Re: Binary files
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is known, that git handles badly storing binary files in its
repositories at all.
This is especially about large files: even without any changes to
these files, their copies are snapshotted on each commit. So even
repositories with a small amount of code can grove very fast in size
if they contain some great binary files. Alongside this, the SVN is
much better about that, because it make changes to the server version
of file only if some changes were done.

So the question is: why not implementing some feature, that would
somehow handle this problem?

Of course, I don't know the internal git structure and the way of
working + some nuances (likely about the snapshots at all and the way
they are done), so handling this may be a great problem. But the
easiest feature for me as an end user will be something like
'.gitbinary', where I can list binary files, that would behave like on
SVN, or even more optimal, if you can implement it. Maybe there will
be a need for separate kinds of repositories, or even servers. But
that would be a great change and a logical way of next git's
evolution.
