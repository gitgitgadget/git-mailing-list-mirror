Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD6FC202BB
	for <e@80x24.org>; Tue, 26 Feb 2019 06:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfBZGDd (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 01:03:33 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42437 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfBZGDd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 01:03:33 -0500
Received: by mail-pl1-f194.google.com with SMTP id v11so270769plg.9
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 22:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=mvm/kGI6doRUZkh6cKAtS9lYOlgWGM3FTVOxK9virH0=;
        b=ftpIZRczCWqLQbVoaEJ83BY4JO7wQVfmFjg+F5YEXUq2u6YJuZRJCQY6GzYKD5sR2P
         PQkR6JFBw5B2YatOobujksWgVBeF+mEPEJyuJIXmGsZ1i1N9Ii8BRFJWJc33nlS9usP6
         HYfGMTqIyOPVPg6j8I8MkwKIJYKs8MAKSgAXopDgWkIeiCeP3GURR+6QGCox4pYkhkHb
         47DCZYOj6Ca9oAKjs3KPV097RYw2fRcJJbZfDsWFYq683+mCSwpeSpnbDk2Wjxhvbz4Q
         JcbWmFZtbt1KIyykdmcA9T1y3/SweXOyBstptMhLOwOjiJENq1eXK1NN2vOMNNXPmzkh
         lE2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=mvm/kGI6doRUZkh6cKAtS9lYOlgWGM3FTVOxK9virH0=;
        b=e7q3B++1sFIYZ8BM0fl6Rq8pGYHcdCmRVIBrf2oIKe/WftF6ABPEEBnPPJb0HaMY+F
         IHNuozzN+Md7tpYjFTwwJOV2yKTN2wdelp9+60FxFnXBQO23anYmskgj/5rfRm+S/CWg
         75iYIOZmfrtvcor+F31XsSgjLJYIBnWEy5I5QAFA5a9hBTedEVsD+pfOchHyJ4nWuJgB
         5Tp36NnKBdO1mVeODTXxErbK2PCW9VS9tPhvTXJ4nU1p8PuhlmgBt3jAvWsh4Cw5fz8J
         OpQQPeog4w6oZ3I+s/7Gad2+VUima48arQAWt2pVBbWKFkeAauMZnpEF114qAJd+lxol
         S4GQ==
X-Gm-Message-State: AHQUAuakDzbnTuvN/0C2gRmE1h6UH6XpXKT26LIpIEiEYnp53zTnTqkc
        efmFSdsTxt/Alb+WH78LHiWxJqqNd0KdOHdZR40=
X-Google-Smtp-Source: AHgI3IY6mhxZjbnGh0k+QQAjuzylOw+URdUEJEir15N9oqedJ5DY+baVN4+d9OeYrQVITZ3YKcbEvSlzwAhGIJ7MemM=
X-Received: by 2002:a17:902:6b08:: with SMTP id o8mr24227071plk.105.1551161012813;
 Mon, 25 Feb 2019 22:03:32 -0800 (PST)
MIME-Version: 1.0
References: <cover.1551123979.git.martin.agren@gmail.com> <20190226032201.GD601925@genre.crustytoothpaste.net>
In-Reply-To: <20190226032201.GD601925@genre.crustytoothpaste.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 26 Feb 2019 07:03:21 +0100
Message-ID: <CAN0heSqLbn7dRu4eARpyMqhFYpj3Pr5i=EMPnQZK9hUfWmf-KQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] asciidoctor-extensions: fix spurious space after linkgit
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 26 Feb 2019 at 04:22, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> Thanks for putting this series together. I would suggest an update to
> the commit message in 1/3 explaining the edge case that Eric Sunshine
> mentioned, but otherwise, I think this looks good.

Thank you. I'll do that, after waiting for a while for any other
comments, and to see what conclusion I and Eric can reach on the
`make distclean` tangent.

Martin
