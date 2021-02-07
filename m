Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D04C433E0
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 18:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9379064DF8
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 18:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbhBGSzh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Feb 2021 13:55:37 -0500
Received: from mail-ej1-f45.google.com ([209.85.218.45]:40773 "EHLO
        mail-ej1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhBGSzg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Feb 2021 13:55:36 -0500
Received: by mail-ej1-f45.google.com with SMTP id i8so21215678ejc.7
        for <git@vger.kernel.org>; Sun, 07 Feb 2021 10:55:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Cjb/jGnySicDRuup1vvx13pOARIil0skEO3alLl0Ug=;
        b=HpybTSnUlxKFIPwc6FBenLLFFF0E3zRzl2W2nDnBX8AV2GbK/YI4jGvhuOfxfOkIIi
         DKQwkoOFMw0bhire2kj+3u7R16MlDaVeKlb2hT70j3IjZmvrxXSlcMPtEgTZ7oNrih3S
         ZkZXzR83KaRxoF1H1kvujjHxX/ChhNX0JBtrQOsmEfoEIByQGb3PsvUyJFs92/K6jrb3
         U8kqVE86VRpPpmr9GDdL7aRpzgAUkPu1TrQunnuWz/nR7LZklTQkvLIFFx2GoBE6oFBw
         7w7+Fy4NELHrSrC3rPJBChxbtvleJtsq1jXs5uVZEpT2Pc94ndMOJgQS9ngn/JEmSovM
         g1zA==
X-Gm-Message-State: AOAM5338aCJzCUh/3cQrfDn0M4ppy4H8uoT05YsqXSNb1Z0stwE30EGk
        GO91dDAUoXhoQvPrWBht8Z3NKMxSwfaMTYFQWxk=
X-Google-Smtp-Source: ABdhPJyqZnXNjMDSiUkgO6UnVCNBTy22VxrvgnHwx1AOSx7Psf61HPQzqftX9zN/5WgaSqm4xipR6agjia6T4CFjGv4=
X-Received: by 2002:a17:906:a1c2:: with SMTP id bx2mr14093498ejb.138.1612724094920;
 Sun, 07 Feb 2021 10:54:54 -0800 (PST)
MIME-Version: 1.0
References: <20210207181439.1178-1-charvi077@gmail.com> <20210207181439.1178-6-charvi077@gmail.com>
In-Reply-To: <20210207181439.1178-6-charvi077@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 7 Feb 2021 13:54:44 -0500
Message-ID: <CAPig+cQ+_neX_FLCQawG44US6Rtu_4wgVe+HMNseh7AvjTu=Qg@mail.gmail.com>
Subject: Re: [PATCH 5/7] t3437: fix indendation of the here-doc
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 7, 2021 at 1:19 PM Charvi Mendiratta <charvi077@gmail.com> wrote:
> In the test scripts, the here-doc body and EOF are indented the same
> amount as the command which opened the here-doc. Let's remove
> one level of indendation.

s/indendation/indentation/

I found "In the test scripts" ambiguous. It isn't clear if you are
talking about all test scripts or the script(s) this patch is fixing
up. Sp, if you happen to re-roll for some reason, perhaps clarify by
saying something like:

    The most common way to format here-docs in Git test scripts is for
    the body and EOF to be indented the same amount as the command
    which opened the here-doc. Fix a few here-docs in this script to
    conform to that standard.

> Original-patch-by: Phillip Wood <phillip.wood@dunelm.org.uk>

I don't think this new patch is based upon Phillip's, so you can
probably drop this attribution.

> Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
