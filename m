Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C68551FAFB
	for <e@80x24.org>; Tue, 28 Mar 2017 18:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755159AbdC1SK4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 14:10:56 -0400
Received: from mail-lf0-f46.google.com ([209.85.215.46]:36404 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752700AbdC1SKz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 14:10:55 -0400
Received: by mail-lf0-f46.google.com with SMTP id x137so42540712lff.3
        for <git@vger.kernel.org>; Tue, 28 Mar 2017 11:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=hObXyWVO8QTaYZAj9bMd8t6neRKj4uQf2ef2K575HaE=;
        b=a0selEgIs96jva7BeshKl6RsVDP76xmxO/yV6HzKC5Mp3gClsBAnl8CTtx9wDcAsgR
         Mu7201MUIh1mFdOtx/Z00gqfifUmXc9bh8Gx7Tvc5MHNKX2Ca1xN49aqo44i8w8DPTJ5
         E0xvRG3JreqmwCAfoLg2HHUsDodaCiGf11GWap4BNflP9DGZxSHM02vb3c/6YAyy5Eok
         Hu5iH6HqZryhiUrApqRX1UstLMJmrIg2RXr96HiH+/7o3LSW0i58FeboPd6KJLsdrerl
         3mOx/ze4q5dOYl96Jfq4eG/VEjASRItw8Pwze2K3s/9FZEUG+OJsvwPHaCwtoKgKyWg1
         64Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=hObXyWVO8QTaYZAj9bMd8t6neRKj4uQf2ef2K575HaE=;
        b=XxYrjTGmlkeCkWeu7hRukKdMZ2XMF5RV3zm3so2+KULt5csxpCiAfkMpIz6x+LHFY5
         244YXIWLVw7LaoIuprhtohoP+SxC49AnbN5WlTMMllVRfkHVXhadhudJKwQSeYPXwdjY
         +UIXNhYvPgDATyhMJYbBl6o5sWdV+3Kpi0cb104mF8fiZOk3PeZ1AJUomgm0jIWNzczf
         XbLIpAh0FLtXFrH7Joub4Mt5/58hnq1SQGQZoOziqQ/K1N2jl4D4yxMofhy+ZDx42GAn
         KgH6mtlv6+15hmo38LX+kacRZ6LZaO/1W9PkwFgacgoy0ezffFxzLZOBUvWbet4dSkhg
         VDEw==
X-Gm-Message-State: AFeK/H1NLcVhYy6bTzhWL3t5QX3uEU8tDAFKKM7LMAxnIAgNOjmefZAAb3z6CY1yLfvdOLlW+k8xWY2EpbiRxA==
X-Received: by 10.46.88.29 with SMTP id m29mr2256951ljb.91.1490724648490; Tue,
 28 Mar 2017 11:10:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.145.30 with HTTP; Tue, 28 Mar 2017 11:10:27 -0700 (PDT)
In-Reply-To: <20170328175356.1GG4n_Oas%pickfire@riseup.net>
References: <20170328104652.XsS8a6ysu%pickfire@riseup.net> <CA+P7+xr+vJP=usEhnR2gZdNY+k8035sX9FgFvvrrL5j_xCu=Mg@mail.gmail.com>
 <20170328175356.1GG4n_Oas%pickfire@riseup.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 28 Mar 2017 11:10:27 -0700
Message-ID: <CA+P7+xrYKE1JOhmVQLVB1RKPnkGNsPPaW+-t8=PqcVpRDcZ=Nw@mail.gmail.com>
Subject: Re: Re: Microproject | Add more builtin patterns for userdiff
To:     Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 28, 2017 at 10:53 AM, Pickfire <pickfire@riseup.net> wrote:
>
> Yes, I can't reproduce it outside the test suite. I have added the builtin
> and yet the test fails. test_decode_color gets same output as expect but
> still it fails, should I send in the patch?

You also need to ensure you have the exact same color settings as used
by the test scripts.

Thanks,
Jake
