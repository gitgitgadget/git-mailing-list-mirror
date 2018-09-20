Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24EDA1F453
	for <e@80x24.org>; Thu, 20 Sep 2018 16:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731215AbeITWYK (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Sep 2018 18:24:10 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35855 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbeITWYK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Sep 2018 18:24:10 -0400
Received: by mail-wm1-f66.google.com with SMTP id j192-v6so217213wmj.1
        for <git@vger.kernel.org>; Thu, 20 Sep 2018 09:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=CBwiOMYGijz7VjB/BuJZFkrrgJzJMikUTxdpYovqcbg=;
        b=tyUa5QHWD7WTRsxWhOcLfGwmQB+NZLwa+TH9mA3NQfF1iZZQ5zmUTvON1ANMRmH5de
         3uP02eITsKDT5Eof87OifhEVNglDrCs77cBU+JLFpLKV8Yc1HURxQnH/fVv8iCkg7jxJ
         NZ0259IWc9jySUrhRBlbilpW79HgTAsEzyGWl2f8pcEit8ph3HoBf+AHkvaynd5qZLdj
         gRoXrbQlW2//g0ggq7Fl0lkIid+/kkKH2xTLoEgtOfIDVPgHsUTSUg4FB4bV3/A2+CRZ
         wU6mzBktf5+wpRt3dFeOAcklim7P/32OCfka9JErM3JemEHGhym+EzPe9sIRKF/3aCbc
         B7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=CBwiOMYGijz7VjB/BuJZFkrrgJzJMikUTxdpYovqcbg=;
        b=TO+sf0W4FRNaxLS+YmyVISP/qVRg/LQK59rRkDsn/nkRxgZAO80mdE6BJjAcOPEyTG
         kq0ML9zqDc8AKPgwfIrsQR5GXk9IliQZLY0jYlWZyWEhqGl4JcToyEak46pb9DiDeH0i
         9L2Jnd0pfDynwH7dQSIm+6i0EKIBwoHISc76XmFhfG3ydS2v18wP5NqB0nLyPEW50EZd
         8e/dK3s6JtgF7ROfPfDf1aNmOSaWqpTmXcsncsDS2ASocZviVgK3DlxBkXFLYW6Mls+H
         XY+8jIKrFDKUl7mzXcTlmrH6SvedNwWbHwa/ro/CZqr7GoomAIvGjHRuhkqEuGt7/6Em
         tU8A==
X-Gm-Message-State: APzg51D87DD35mbLYYD9HzUXluzul8oeVR3MCLMtHs5YkI4Q/9RWN77g
        IP4zargI5Iru8ql2VT+o1LQ=
X-Google-Smtp-Source: ANB0VdZ7rUd6utNW8kOL5lm+Kgrps/TrQBeklsHtEBVkqZ+8WhRnFLHU8+lYohynhZ3eYDyo8iwyoQ==
X-Received: by 2002:a1c:c4ce:: with SMTP id u197-v6mr1642953wmf.10.1537461588162;
        Thu, 20 Sep 2018 09:39:48 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 144-v6sm3829398wma.45.2018.09.20.09.39.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 09:39:47 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] fetch doc: correct grammar in --force docs
References: <20180918054740.24180-1-avarab@gmail.com>
        <20180918054740.24180-4-avarab@gmail.com>
        <CAPig+cS6gPb0_niFrWHQafLgxwEFfdsQ1UDj8XU3avZJEp=Zog@mail.gmail.com>
Date:   Thu, 20 Sep 2018 09:39:47 -0700
In-Reply-To: <CAPig+cS6gPb0_niFrWHQafLgxwEFfdsQ1UDj8XU3avZJEp=Zog@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 18 Sep 2018 03:30:25 -0400")
Message-ID: <xmqqy3bw15t8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, Sep 18, 2018 at 1:48 AM Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>> "Work the same" is incorrect and needs to be "Works the same
>> way". Fixes grammar in document anion I added in the recently landed
>
> I, too, find those "document anions" problematic. Perhaps the
> physicists around here can do something about it.

Well, let's squash 2+3 together then.
