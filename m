Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D861A1F406
	for <e@80x24.org>; Wed, 13 Dec 2017 05:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750749AbdLMFkf (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Dec 2017 00:40:35 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:43928 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750737AbdLMFke (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Dec 2017 00:40:34 -0500
Received: by mail-wm0-f47.google.com with SMTP id n138so2614675wmg.2
        for <git@vger.kernel.org>; Tue, 12 Dec 2017 21:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VDF/YQ2IStjcrmaLAXk+kr26touXVBZutrd2ufO3K1c=;
        b=TqNeHOSYTf7qIq0V8F2tKTJA3q3VE75tFR+hDeV47omQINfkmO9P0jJb20S/NdFdfQ
         XG1bPAdUaPOHFaZyl5Ar7xEtHWQLB/k5aM7NKqPAshyZfakxjzJALdoy8kWXTUE8ZOaU
         C8LsPTsF+ib42PYNsizat7cBx4m2O5x8QHm0a2zQE6bQrLzVcYDj5lceZlaLyl0YUVt1
         47xgK4qdLVXnBojNM/vssF6HQdu1eS+dr3gz3jch2K6KlJUNZT9WW7n2b/TDOg1B7uNL
         baJfEPEugRIcwxHiYYL/+u4VUUV20Ph+UwAGxHKkmSyqTxjwvpPh9JZEJ4eHb9vRGbLR
         X6Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VDF/YQ2IStjcrmaLAXk+kr26touXVBZutrd2ufO3K1c=;
        b=Kas4LCaZpwo1QF3ZOKOEfGjSAX7spBzM7jmyaAUIwqvsps2H2HWc8yYD8GI/ltquvz
         PfBYuQAJ6VGcIwU24+nSu45XAgLv3XyQ1ahTEHyJBgd26Z5z7I60+DKqNFaG/XoY0the
         ZqpEGPUCSjra3Sh3cpAxPlq8MZblYnrv1U7f5l2/e5KOdYiCq+xOQIf7zqlkCULZCjys
         oZvx/UbCnO9vNxD91uoqMQY5Us6nUi288DPZwcrBbnp+hzrILdt/21FSYE+e0swxYZuC
         gcB97NO5sj3wSJmFQyDubrYd0y3vGN3mslvqGM58XwTLOoEufZSSckU4yYpjJT7AhHEn
         wbng==
X-Gm-Message-State: AKGB3mLoLChxolk/hwCNch4WQ6Y5FMZS9MNCL/CINPuNkE74ozXDOiVZ
        tf8M96RP8LrWjQSwKp+psVHYWqZw43n2u9eIRtsxmw==
X-Google-Smtp-Source: ACJfBovApKoGyODf2lEOtRWRuwlQ0uxTcxXla6NYM/UvGkrm0w6Gcptt1hx9YQl/G3DsWF4T618xf1peLHIOKV9XGHs=
X-Received: by 10.80.182.217 with SMTP id f25mr6255852ede.104.1513143632782;
 Tue, 12 Dec 2017 21:40:32 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.174.252 with HTTP; Tue, 12 Dec 2017 21:40:12 -0800 (PST)
In-Reply-To: <E1eOwqn-0005Bd-OB@rmmprod05.runbox>
References: <E1eOwqn-0005Bd-OB@rmmprod05.runbox>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 12 Dec 2017 21:40:12 -0800
Message-ID: <CA+P7+xrWFE+6t-Z8cGQX5WtZP1_EQSa+J7vF65dLDSOnLfFxXQ@mail.gmail.com>
Subject: Re: [PATCH] doc: Modify git-add doc to say "staging area"
To:     "David A. Wheeler" <dwheeler@dwheeler.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 12, 2017 at 6:32 PM, David A. Wheeler <dwheeler@dwheeler.com> wrote:
> Change the documentation of git-add so that it consistently uses
> the phrase "staging area".  The current git documentation uses
> inconsistent terminology ("index", "cache", and "staging area").
> This commit switches git-add's documentation to consistently use
> the phrase "staging area", which is higher-level and should be less
> confusing for new users.
>

I know we've used various terms for this concept across a lot of the
documentation. However, I was under the impression that we most
explicitly used "index" rather than "staging area".

Additionally, I think there are many other locations which
consistently use "index" as the term already.

Thanks,
Jake
