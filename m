Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A74A1F463
	for <e@80x24.org>; Tue, 10 Sep 2019 05:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbfIJFEh (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Sep 2019 01:04:37 -0400
Received: from mail-pl1-f171.google.com ([209.85.214.171]:45932 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729014AbfIJFEh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Sep 2019 01:04:37 -0400
Received: by mail-pl1-f171.google.com with SMTP id x3so7912836plr.12
        for <git@vger.kernel.org>; Mon, 09 Sep 2019 22:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rVf85YIwXOpz10h4j6+6mGkLoqNtECzu3rZAJWMHqHY=;
        b=SkSOqmax6Wv5fG4wcBTMuvGJY7kKLqIG4H7b86VUIB+ntP3ilsoxAe3v2E7ScjJ9We
         844J1mmCq50wsY2mS5vxhEpK9oArELRpjmCOhXSmjcBROcIF8p17viS2QnfUbroEioGu
         lYLSGBYoB2l7fi6LS1zXlWyPjl+qMRVEGqhWgHAefSZ71H40KBmtDGoZtht/u1hvqQ8z
         HtFKiy8YjlUCkiU7oH2NNqJlBmkNyBmnnY8qYGU84CamgazMNyYYn67UxvP/KUk4KBy5
         d86BT3iE6JtbKs1UXisXkVIaQzN1sXRUTYCjwoE68RNYRQnSRN26exxLy1OxPq+AjNqD
         t+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rVf85YIwXOpz10h4j6+6mGkLoqNtECzu3rZAJWMHqHY=;
        b=B7onLxHKbq7gzAZx/aPnoX3xS1a/42H20r+jXDNWLcaNTRBdhghxVl4NtQ53rXNWZK
         p9IrawbVlB0LXVntgt8YXT0VkLD0HeqF/qCqjD4CU0Z2mq0AwIJRc7RGtdUL8IUMMRdz
         /CAwefGerU68YTWgI1d2F1y9ujYtDwt5ENZh7qb2u9KkXCKDtVtANXRtsJ4xNaa01Zf9
         FFzPD9kuKo4INarzHHNtRAmXDGzpTYUTU23Kb8JV3ZkMdAlnzn3+aKn15flsm1lzzWCh
         RKEa41j8ilapHl/Sxv+kyYmcPoBN5ldm4D2aabE+1vudMJlauaFn6txnGHNCZHKUmqiM
         jzRA==
X-Gm-Message-State: APjAAAX73rFTJmH4xDXOjkIPHkzSvJ4EasaJWzksUYZm7XjLpQEBDHUz
        NDqxroUUrDScgBiF7tUe1xgNTxfpij2rCOyYMlk=
X-Google-Smtp-Source: APXvYqz6O+5T40viZbcoVlajHMrx9ClfzmMVutZKgy8i2D5WXabY2mXrb1+H7I09D1pjBPSTGXAHZxFPzl2QCVqPGSE=
X-Received: by 2002:a17:902:fe01:: with SMTP id g1mr9350727plj.178.1568091875372;
 Mon, 09 Sep 2019 22:04:35 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqd0gcm2zm.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqd0gcm2zm.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 10 Sep 2019 07:04:24 +0200
Message-ID: <CAN0heSq9B8NSr7-Bcqpiags6wyMm_3KUGeo+7GZA85nd7GnG=w@mail.gmail.com>
Subject: Re: What's cooking in git.git (Sep 2019, #01; Sat, 7)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, 8 Sep 2019 at 14:51, Junio C Hamano <gitster@pobox.com> wrote:
>
> * ma/asciidoctor-refmiscinfo (2019-09-03) 2 commits
>  - doc-diff: replace --cut-header-footer with --cut-footer
>  - asciidoctor-extensions: provide `<refmiscinfo/>`
>
>  Update support for Asciidoctor documentation toolchain.
>
>  Will merge to 'next'.

Please hold off on this. Asciidoctor changed the way they handle these
attributes in version 1.5.7 and my patches are incomplete at best. I
developed these with 1.5.5 and now I am also able to test with 1.5.7.
I should be able to come up with a series that works with both of those
versions.

Martin
