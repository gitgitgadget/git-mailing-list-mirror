Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2B9D1F461
	for <e@80x24.org>; Mon,  2 Sep 2019 09:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730979AbfIBJNb (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Sep 2019 05:13:31 -0400
Received: from mail-lf1-f48.google.com ([209.85.167.48]:43568 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730117AbfIBJNb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Sep 2019 05:13:31 -0400
Received: by mail-lf1-f48.google.com with SMTP id q27so9852374lfo.10
        for <git@vger.kernel.org>; Mon, 02 Sep 2019 02:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=comRdNWzcRZkT3ytWsd6jtPKFktCzzS0ugCw4ZLTuHk=;
        b=Y31uyIyh7FRF4ACpAdOKe91rQpOkEE9B6Hcvn0OE4i5uGnDBHiP7rscsvGcBttkhMC
         OpzlD7k+SlSIhvLwRMjpznm5+i2CXPP4As9tK7Kqft65exmUrrVWH4mSYkoPHE29086x
         BX00hwcw0EyujIYIs8pImZju09ZxfFAcaz23sR7dubGU0mTBlsA+c2eDJN7K5L5evwyt
         pBp+wj67uWRM1wla/gGdifaRFS/qryZmFYyEZqg/afq0VgVt7mIoAIceYSfZ49HVrmA5
         ariZf+syFxEWsAsIR+ukjnOmRgrGaMDPGlWi/mNflrKHADinClviaj/hT5hLnIk5ijR8
         L53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=comRdNWzcRZkT3ytWsd6jtPKFktCzzS0ugCw4ZLTuHk=;
        b=dhvtnxGNFcDm/SBhdy0BFnBEyoaa3SbTd0nnCM+TTtvd72BMekLFtxV6ZSQlMPYnty
         Gx8F1n5f5PZ+lb9hby5F2e1by8SxaZqSlB508BXthi1amhnFLyvWmNv2+S7KjnyJolSA
         bnP4HVxES569ZfZYZ4bTQEhMa0RVvrC1/DUGUqXfjUaNSQPFuKpQvvokOanguNwCAzfw
         ompJtd5O6pu3xoU/UL7xU6ThfvtGiWOhBHsDh9KYQvPCXEwxt0C+mM4pe8RoplmlR/oG
         Mfqrk8FERBVb6Pk00GBPT7XC5vY7BG5qKaPTIU2Q2PRMj4jBscahtlriGCUkQhNzaFPt
         wNMg==
X-Gm-Message-State: APjAAAXwEU0xdzUMC0TvbyzpgCyhX65aysoPQShYz9pza5+ysSrLgo9X
        7vMtWdV/60C04lhnuZTfwElv1o5r9wu0irDJ6VPZQkJ26X8Waw==
X-Google-Smtp-Source: APXvYqxHIAXIsS+RMDvxIOA8qhsh83t/bkmhxBx6cAr9Yms5Tn34yjaVKW1kAWoihtI3sG8D8jC7T2HF5PyXHGU2EiA=
X-Received: by 2002:ac2:520d:: with SMTP id a13mr5848860lfl.101.1567415609375;
 Mon, 02 Sep 2019 02:13:29 -0700 (PDT)
MIME-Version: 1.0
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
Date:   Mon, 2 Sep 2019 11:11:09 +0200
Message-ID: <CAGr--=+ThYVyZUiU1wnt0yL+MzF1RXvHnbwo9NWyh95cLyhNRQ@mail.gmail.com>
Subject: git-gui: Long lines in commit message gets hidden, no scrollbar appears
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I just noticed that long lines in the commit message widget does in
fact not show a horizontal scrollbar.
So if a line in the commit message is more than 75 characters, it gets
a bit confusing.
Should it not have a scrollbar?
Example shown here: https://i.imgur.com/I3d6nBJ.png
