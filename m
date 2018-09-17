Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 480D41F404
	for <e@80x24.org>; Mon, 17 Sep 2018 18:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbeIQXdX (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 19:33:23 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:33979 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbeIQXdW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 19:33:22 -0400
Received: by mail-yw1-f68.google.com with SMTP id y134-v6so5824800ywg.1
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 11:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3CUJfq2yWeZS+ryOas5Rt5uJV+Oa/rvqHHAMPdSvz04=;
        b=POD4yX81oGog8ttcs69J+ugkTfYlzp9bi8koxPN8Qwxxr362S4+QG0RDavipgKLKHL
         t/bjO8b3L02Z5t6TWOryi+yPs3fuCQFSNnFsiKFfNAphtwAaKBd1O0X4gZ7oVTFAuTMZ
         JWeo9qk6j+Qdwp9ToeVF8ehfeuBgHie+JN/lenQe0btsbDMoO0UKlKxsACe860ZsrI1G
         GazaVcwKtZ1AkihEFC/TwIz8HSJFO/Hlw64t2PKKXlODcs4fc5LLAZae3fn6oeH5+fG0
         ibK11nE5NRk/6m58nD5vl9I7HDdJyT4HLBn2m8yBOndmPpT7F9jFvyn8ZwPxx1NXrt9A
         rjOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3CUJfq2yWeZS+ryOas5Rt5uJV+Oa/rvqHHAMPdSvz04=;
        b=mmC7nqj6HR3oW1mECgDPsegSBFJhERD6PQzc4vZR5/tUTj5s3/lgbfPd4LNryEWOtc
         u7rePQmUGETqtK1AM7fAAPwcC+e1caKyzZgdh3nRjL8ZhqiBovhj5A5ek0SO7DlO25LZ
         +C5K4TReEX3pqmqyANLCT826/NZzVD2yA1duo0mFNYPuiix6FY3O5Gmm/r4bByXF9+Mv
         eqOrjkioDQZqiKAiaplJicGvLcSl7scuoM+2Gnfn+JQkL5L4FukxZpssCHJ3am4KAF+M
         BqWuxZ7JwMs/00TOeAs5cvcfLmz+XJv+ABWT3iW4Gawt62ASkpHu0LVTU5VKCfuKkt2q
         KOTQ==
X-Gm-Message-State: APzg51DELpKvS8iPM7HAiyOg3poLyY60dhu4IaQmtb9blGi1dtoIa7Cd
        rCkiEZsemlMyNdrG3WmnWwi+mY+bAnrZcc7vwE2sQA==
X-Google-Smtp-Source: ANB0VdbeTO74WlnLxji9U9BLgu7q4hYMrqAP+9itaGWkpvzIulaSTHeZlOBzy0feGM+N0JEMgYDXeZxoup0DAdf8u7Q=
X-Received: by 2002:a81:5855:: with SMTP id m82-v6mr10317377ywb.300.1537207494614;
 Mon, 17 Sep 2018 11:04:54 -0700 (PDT)
MIME-Version: 1.0
References: <20180917015259.GA26339@sebastianaudet.com> <CACsJy8CAyXAaax8dSPUUzTFvpKVG19FDives3JthL4hBxgf=6A@mail.gmail.com>
 <87zhwgj9mc.fsf@evledraar.gmail.com>
In-Reply-To: <87zhwgj9mc.fsf@evledraar.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 17 Sep 2018 11:04:43 -0700
Message-ID: <CAGZ79ka4hQYHRc-=LkGFbFmzhJfj8+nOTUB41PnajySXeLuCFw@mail.gmail.com>
Subject: Re: Brandon Williams's E-Mail bouncing
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 17, 2018 at 10:51 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> Aside from that particular address bouncing [...] it would be nice if git
> {format-patch,send-email,check-contacts} & the .mailmap format would
> support and understand some way to map addresses to
> e.g. noreply@example.com, and prune them out appropriately. We have a
> lot of addresses from past authors which bounce, and where no current
> contact address is known.

Tombstones, eh?

For send-email I would very much prefer the proactive warning instead
of silently dropping that email address as I would want to know, so I can
try to follow up somehow and deal with it as-is.

I think the main purpose of the mail map file until now was to consolidate
multiple identities into one (e.g. misspellings or capitalisation issues in
names, different email addresses for all the same person), now you want to
extend it to also contain more information about an author-ident, such as
emails being active? Or recording if someone is not interested in the proje=
ct
anymore? I think recording that an email bouncesl is just duplicating
information
that can be easily checked. Recording that a particular contributor doesn't
have time/interest any more is slightly different, but IMHO the mail map fi=
le
is also not very well suited for that endeavor.

Oh, the above paragraph is written with git - the tool - in mind, not
the git.git
repository where we can (ab)use our own tooling. ;-)

So mapping all bouncing emails to no-reply@example.com would map them
to the same author ident, which we would not want. (e.g. we'd still want to
know how many different people contributed so far, hence keep them separate=
).
We'd need to have unique email addresses that still explain their intent,
i.e. <user>+no-reply@example.org would work?

Thanks,
Stefan
