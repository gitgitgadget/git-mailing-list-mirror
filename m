Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A097202A2
	for <e@80x24.org>; Sat, 21 Oct 2017 02:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752670AbdJUCcX (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Oct 2017 22:32:23 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:48136 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751885AbdJUCcW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Oct 2017 22:32:22 -0400
Received: by mail-pf0-f196.google.com with SMTP id b79so13383631pfk.5
        for <git@vger.kernel.org>; Fri, 20 Oct 2017 19:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=VunGKno9X4wdt7WDv3gAS93CIdUrekKOEUH8RiJ6aNA=;
        b=J40au+a4wVbAMpkLyTc8LC0k8Lo4o+yIbEQCI422k0cAOFsG35/cunnsP/We+uyhye
         rPnvUa6Yn+AprF9KBu5JUuTG+dCEQOVqZOtiudNj86Grr7GRJVMJI+769KAaYGqvnkwh
         4GsKjc2KSnmNapOrD6DgNz0y6M/KnZCPKLRxLzrzFibY2ixAkQyV5cvJHhfOfM6G7iqs
         tHHrZO74K2G6G7Bj4P3w7E+WCxLImsVvzG1FV3a0SYVDFMHYJi7P9fohZGhe1RaYuESB
         F8uh+QHU5YVtmncXdFqwcd3AqUXIx93+KLuQ3ahtgtM7pKRv3fNe42tdz/0DWwmVznGu
         BNMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=VunGKno9X4wdt7WDv3gAS93CIdUrekKOEUH8RiJ6aNA=;
        b=KYQLqSQPCaId2VDSIZ2lxRRlTxyYzJQcTwXH1SrViA82WAG9z3VUN/T19XvLb6OmlV
         g/qVoExd+/AWgrdeu40JpC+6912tmLf5DCEIB3QzQteLod0Elnl0BUmcUhP/XgheNQpC
         7j21Vj13m/0li1bY95VQwVgTtSQfa393ikasxkatdGuaQvyhsWovFHocOoaRj2oj5P1d
         WlAIy710i2tWvGKo31P0Ys3cZbhfDEq7Jr1SXO2zVgm722pEli0qfdxwU90dQYfmxQPr
         Y+mH1bu62Tt2ZCdbZ3AX2VIdi9345IW3trzLYdIA3bk4TtmkWVwVBM7XBq5+GEi8IiYS
         LMvg==
X-Gm-Message-State: AMCzsaWorVWTB3qD0yupRfu9EAmtS4X1cgfzHOupbkKx5+8qlmpxyl5/
        qOoXMxAI6L58pfs0gWTbhi8=
X-Google-Smtp-Source: ABhQp+SXrsxErqv8W9DijqVH58ZHLOHJWy/cTAERqoyBYzZQHbrf/uChnlN65BJYZo1RhJvG5HKkNw==
X-Received: by 10.84.128.227 with SMTP id a90mr5598232pla.224.1508553142560;
        Fri, 20 Oct 2017 19:32:22 -0700 (PDT)
Received: from unique-pc ([218.248.21.162])
        by smtp.gmail.com with ESMTPSA id 70sm3467304pfv.97.2017.10.20.19.32.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Oct 2017 19:32:21 -0700 (PDT)
Message-ID: <1508553136.2516.4.camel@gmail.com>
Subject: Re: [RFC PATCH v2 1/5] branch: improve documentation and naming of
 certain parameters
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
In-Reply-To: <CAPig+cS7e2i-eEJV6NcRQ-+aVmn5C7mKONxU4TLAGA7GQBX=aw@mail.gmail.com>
References: <20170919071525.9404-1-kaarticsivaraam91196@gmail.com>
         <20170925082024.2691-1-kaarticsivaraam91196@gmail.com>
         <20170925082024.2691-2-kaarticsivaraam91196@gmail.com>
         <CAGZ79kaVUBuHVxaE0opXqiEwCr7MVFZHrt5ERQ0mF_deSHeOSQ@mail.gmail.com>
         <CAPig+cS7e2i-eEJV6NcRQ-+aVmn5C7mKONxU4TLAGA7GQBX=aw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Sat, 21 Oct 2017 08:02:16 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1+deb9u1 
Content-Transfer-Encoding: 7bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 2017-10-20 at 17:51 -0400, Eric Sunshine wrote:
> On Mon, Sep 25, 2017 at 1:20 AM, Kaartic Sivaraam
> <kaartic.sivaraam@gmail.com> wrote:
> > Documentation for a certain function was incomplete as it didn't say
> > what certain parameters were used for. Further a parameter name wasn't
> > very communicative.
> > 
> > So, add missing documentation for the sake of completeness and easy
> > reference. Also, rename the concerned parameter to make it's name more
> 
> s/it's/its/
> 

Thanks!

-- 
Kaartic
