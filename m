Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5F701F462
	for <e@80x24.org>; Mon, 29 Jul 2019 20:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbfG2Ulk (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 16:41:40 -0400
Received: from mail-io1-f54.google.com ([209.85.166.54]:44683 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728518AbfG2Ulk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 16:41:40 -0400
Received: by mail-io1-f54.google.com with SMTP id s7so122926026iob.11
        for <git@vger.kernel.org>; Mon, 29 Jul 2019 13:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xnx4cDUXV5ZwNMPm7wi1Eik37W7XBJk0Xeupa04T7zM=;
        b=0ItiRvd+MtXVxV/6ORRbYjqX83/a/jZkWeGqVp5k+vHo2hy/0+EiS2jwkv7onFVHrq
         FiI3DADCDN6G/bQPpJNj/XgvYlXLF5e8AJIIBbD4+2fU2cyVK/L83NNLC/ci38EswQf1
         7WZFfHQE/WzEjb/ZxrIiJxh1prNgHAl2HoFQDKLZT22NOJHQ+eJSIBSIOBYyoS+HGspe
         gbqM9tMJfTMQ25FVD0/dhAdoKVCAXzHCkFU5WwSvxMGa/AiF38AotMMuuUgAi0/p9yL4
         MbeaFkHDs64lbo5yzOr7H826+BzT9we8lvrn9m5egx5dOzu4KZB7CuHFF2ExRTHjZapQ
         cHpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xnx4cDUXV5ZwNMPm7wi1Eik37W7XBJk0Xeupa04T7zM=;
        b=d4kA5P2AznrHl4RC+HnTJqDmbXOcvakp0nKeH3yPy538iG1m6M2lhYGY+CmjS0ZULz
         OP8SyOuCSpZ9h2KDGCLdRUi/6ESsSkajICQVMfFBYbZvJGeVjmddhQmhb2YyxYBpcYON
         XVwPaGtxMhVNG3GGX4K3Tw9qgnZmpY7JdaKpNEFDR9LahX0+c9pDe4/h34Eu6DwxGfym
         tQxmQNYuC4S9ws9PbeeLG3j4VwWRjcLHYrqJMQp7RXoZ82go9Nx18uw9WyUkFrcFPSAM
         3HP9L0im/H5ZEtKFSCXqSTOglFUbKFwcaSIcrmLxvyQ7XeSVYXBGHlZrNZQjnFes/4oE
         /eFA==
X-Gm-Message-State: APjAAAWXcHChY3m1tDQfu+pyaCunk84d+0+vaZpcq1jQ3BHme3wszUYA
        UBMOpNlWfEPZHiK6p9ErivggdOzNi0GPTjMd1eJGjpL1h3Y=
X-Google-Smtp-Source: APXvYqxO/8+2LEHWD+TJR+VzwBKxfGjpK587xmbCkkNWULr7IMU5PQbOWcFIsRoNAUGglE5ftZlgpUmdOJ3xkaNmVTM=
X-Received: by 2002:a5d:9613:: with SMTP id w19mr66548265iol.140.1564432899206;
 Mon, 29 Jul 2019 13:41:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd-oW5MZNQ=AWwL+4wh6wERYJTMVv_1DKCBk4OK9Asui_bQBA@mail.gmail.com>
In-Reply-To: <CAHd-oW5MZNQ=AWwL+4wh6wERYJTMVv_1DKCBk4OK9Asui_bQBA@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Mon, 29 Jul 2019 17:41:28 -0300
Message-ID: <CAHd-oW6J4zOsr9jrbrZVMu6KyfYjoQTGQiABU6814t2J_3j82Q@mail.gmail.com>
Subject: Re: [GSoC] My project blog
To:     git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, everyone

I just posted an update about my project here:
https://matheustavares.gitlab.io/posts/week-10-a-bug-in-git-grep-submodules
This one is focused on a patch to correct a bug at git-grep
--recurse-submodules and some tests for the parallel inflation
patchset. Please, feel free to leave any comments.

Thanks,
Matheus
