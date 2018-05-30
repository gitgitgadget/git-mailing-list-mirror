Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 328581F42D
	for <e@80x24.org>; Wed, 30 May 2018 19:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932234AbeE3Tzc (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 15:55:32 -0400
Received: from mail-yw0-f181.google.com ([209.85.161.181]:34239 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932184AbeE3TzD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 15:55:03 -0400
Received: by mail-yw0-f181.google.com with SMTP id b125-v6so3451803ywe.1
        for <git@vger.kernel.org>; Wed, 30 May 2018 12:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XCKcuxSLIRosp+vgGty66/3TPRMuUlBCU1WKI3k17mE=;
        b=wP+7AGAUCg2Qy17x7dwntwyjvX2A22MMM1UxOhBLKf1OAjEND9bLX/i/ZedpplflEe
         DYmzwutiTUEsKUyu4TeiDqMUSOs2VhyMFjCarfkKVZy9VwGLkl1HD1+bm5JdSr/nup/w
         Dk59eAa7Ixfp8Ecemyr6wUpKL5zpDaGCta22+qUd+VXHmrE/c0FK5oNUB4tcNuasNZ0R
         tPFYvZdvNtr/Hfu8o2qOrR98zd4Umg5uhEi6MAZHS0MYV5jm6cR5UUso+byiLP1NCro8
         EZe0CxvBY+xHZQEEaN120qCnupM3T1qGFC/gR1JmRjjHN9MYFqb7dj/WNyzfnBu0zN2T
         LGAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XCKcuxSLIRosp+vgGty66/3TPRMuUlBCU1WKI3k17mE=;
        b=Yl2FP41JMfomEsVwH0mUWitdoJN4RFUfkwUGQGMq08da8rKhy1/Z3qJ/K2M8c1ez9M
         3dSkSFT3NeTYorNBk5mDVqox7q68EhZbnp7sqMT0tavc2g/Hn4rN0r/kR7yBwutYKXcY
         IIG7Ml9HGuaF9z2iqM/NEpc5qXMM0VQe8YBVJl3A69p8i9yuL8qrD41BnvD0js8B2yNq
         aTDastxkPjk1zUeo/rGbBZRN9H0p4ZoaBa68sE61dWTm9SHqFkdrdyRSPm/ymmTzssFQ
         6WcDnbvPw74/ex2SAaE47Yl4CSuiCEChF7DspHsSTKGkJtEmhwyfMsfjT2z2jPjVlini
         UO6A==
X-Gm-Message-State: ALKqPweAS6R7GmbLJdoRY934lpYG+ceuA56QamVR9vB9cuGwgRTludXO
        xTEuKLWAs+J32hhaE3FY593OxzeUSrr3TOj9m65yog==
X-Google-Smtp-Source: ADUXVKLkeVNe7su7UOUsY+LJN1TZ/8TuTycl5sHrMmlcdFWp7fYCpo/0Sby3PIye81GoO2haqlC6WJ5iAr8tZFCXH2s=
X-Received: by 2002:a81:b205:: with SMTP id q5-v6mr2263677ywh.414.1527710102987;
 Wed, 30 May 2018 12:55:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:e87:0:0:0:0:0 with HTTP; Wed, 30 May 2018 12:55:02 -0700 (PDT)
In-Reply-To: <DM5PR0102MB343149C5313DFE76852857DCCD6C0@DM5PR0102MB3431.prod.exchangelabs.com>
References: <DM5PR0102MB343149C5313DFE76852857DCCD6C0@DM5PR0102MB3431.prod.exchangelabs.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 30 May 2018 12:55:02 -0700
Message-ID: <CAGZ79kZFyD=ZxYxGhLvDZrEk-zaLiKnJDUt6G2teSFD4=hC+bQ@mail.gmail.com>
Subject: Re: Git installer bugs
To:     John Meyer <jmeyer@zerochaos.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 30, 2018 at 12:48 PM, John Meyer <jmeyer@zerochaos.com> wrote:
> Ran the installer, selected the option to not modify the path & the path =
was modified anyway... it removed git from the path (it was there from a pr=
ior install).  I should NOT have to manually fix my path after an update, e=
ven the option to add git to the path should be smart enough to recognize i=
t's there already & leave the path unmodified (sorry, I know that's 2 diffe=
rent bugs in 1 email, but they are related).

Are you talking about Git for Windows?
Please file a bug at https://github.com/git-for-windows/git/issues/new
