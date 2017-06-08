Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C7B81FAED
	for <e@80x24.org>; Thu,  8 Jun 2017 05:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751367AbdFHFmK (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 01:42:10 -0400
Received: from mail-lf0-f49.google.com ([209.85.215.49]:33389 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750914AbdFHFmJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 01:42:09 -0400
Received: by mail-lf0-f49.google.com with SMTP id a136so13584534lfa.0
        for <git@vger.kernel.org>; Wed, 07 Jun 2017 22:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NkMeqrXcA68VEPJVZ8vaNxlgb/sBuFyNpd0XsXf0K7g=;
        b=rRSgrNb5rxeSnBbwvfjGWPI6JM5m9NBcXzf8o6vkMOgUcnomEv95hVTUFbNzisdazu
         J/ef/B6ktNMw8gIly3QYNcVsErnDMGj99PUcFPlDxVB1V7FWtMd4IKhdFoijEbOSKmp8
         DjSJt6Bkem5M2SpaA99qYMdSuZBjggW9ZprMDQMNf44X6+TDW4TRPzyzLk1AWRimcHLm
         TGB8dQD+1bwXSzl/U9RcqO3/FAPOZE4GCe4KH620zSA0bd0U1FXiIujlkHfabHZMORmz
         6RQ48HQrFjaJOW8qHyZehxD50/0KrcLQ5cLsUng4efYh+zy/AEwCHT2f8GvyELagpu7R
         ntyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NkMeqrXcA68VEPJVZ8vaNxlgb/sBuFyNpd0XsXf0K7g=;
        b=OGn7C2kRmWVIW32D3ap+UGyV9SihUKFN/Kfm3BOnK0+0FQ3qTnC03MEQB8IO9bMYWU
         IctBVrHzbelDFKUaKcTvxeV2iFe1Xb+EcraZVUSzl21Q3FJ+xRgISyHGnG/zQfUdw/KU
         gSr2VEPrwpsyL2eiH3cD2HOAlDh0opwX4TA56vWiYv6qaCUigdx5spR7YrOj8fbKtzdC
         g9zYFMZT/+2dzU8PC7Zb4ptHmuMcAkccaQuqT4Xxe7ZqGy6YDYgrJDuEE9sp7Qe0IJTv
         Vb7nZ873Fy7ENJhXezW66eyGa4FSnInROvDuwjwEM1JcWjNGFp3QXVEHU447ZvEx9PuC
         1zgg==
X-Gm-Message-State: AODbwcCyvMCtBZuqpIKWtLwoqmfyZohePFDaXn4urCniob6OO/6Q+MO1
        wH/bxrgCwxpum/enWE7NqKVazsyhhg==
X-Received: by 10.25.44.69 with SMTP id s66mr10490571lfs.58.1496900528094;
 Wed, 07 Jun 2017 22:42:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.79.17 with HTTP; Wed, 7 Jun 2017 22:41:47 -0700 (PDT)
In-Reply-To: <CA+P7+xpvZDHum-A4omMySTebgBLFzhkpD=DiL-_Mm_Qv-OkMaw@mail.gmail.com>
References: <xmqq1sqzkrui.fsf@gitster.mtv.corp.google.com> <CAGZ79kY2Z-fJYxczbzheu1hChLkKkdjEcDMwsP-hkN0TjUBotQ@mail.gmail.com>
 <xmqq8tl5apkk.fsf@gitster.mtv.corp.google.com> <CA+P7+xpvZDHum-A4omMySTebgBLFzhkpD=DiL-_Mm_Qv-OkMaw@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 7 Jun 2017 22:41:47 -0700
Message-ID: <CA+P7+xpCWUBap757N45DrGjvh+v51dg=A9MNOgN8xfVDqZtvog@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jun 2017, #03; Mon, 5)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 5, 2017 at 11:52 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
>
> I will try to find some time tomorrow to go over it in detail.
>
> Thanks,
> Jake

For the record, I got pulled into a project at work, so I won't have
spare time to look into this for the near future. :( Probably not
until next week.

Thanks,
Jake
