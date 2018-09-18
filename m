Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABB651F404
	for <e@80x24.org>; Tue, 18 Sep 2018 07:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbeIRNB5 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 18 Sep 2018 09:01:57 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43647 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbeIRNB5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Sep 2018 09:01:57 -0400
Received: by mail-qk1-f194.google.com with SMTP id 130-v6so464769qkd.10
        for <git@vger.kernel.org>; Tue, 18 Sep 2018 00:30:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XtLUqfVJo78x0ylou1SintY8iVGrjBnAqUEN4V+O+y4=;
        b=ZbyKt+GBM1iX6bJTC9bmJ1bUnRpQ5ZNMgM6NABFF+0gxqpvo2zqTFaMJaJz2OZNDzV
         TUzkdwyqj8tQ7ZEEJ6codAE0fB1tfCfGO72VclWpA6QmJIo/q1wSa8WqQDstsHXMbYG7
         BTqaCcnHxxq6Y7rURpcSA6byTBy9AHV2KQsJsPGQkfSxz54V+MLKjQGLxOK+H3GC1tXB
         sSvyJG4KSzorLJtV01cG2EBrwEic0hquGsBn5YyjUQjyy/rMrmiXMhuP2kn3lJE/z6U9
         xwN87FBdZmzLjfEGs5vbvrYPbKujRqNRZwYqySb1hF/SwC0L+ptaWNwiOmvFRp1SC42r
         A1PQ==
X-Gm-Message-State: APzg51Dpf+rV71R2tdpc4SctIe5dsx92f2BU9p6Ngv7fCITtGv9eAkZv
        2Z5aDYI7OWfQyX6+1OfDx+ktwHnROJQBpfDaVi4=
X-Google-Smtp-Source: ANB0VdYswJSPm4U19O0suNUVVlny5MV6o5D9ZTd67s+JER5yVOIU/A37fIN+KTZJCnKd7qcAlas45cEcUCnAJ37wg20=
X-Received: by 2002:a37:9306:: with SMTP id v6-v6mr19225587qkd.36.1537255837289;
 Tue, 18 Sep 2018 00:30:37 -0700 (PDT)
MIME-Version: 1.0
References: <20180918054740.24180-1-avarab@gmail.com> <20180918054740.24180-4-avarab@gmail.com>
In-Reply-To: <20180918054740.24180-4-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 18 Sep 2018 03:30:25 -0400
Message-ID: <CAPig+cS6gPb0_niFrWHQafLgxwEFfdsQ1UDj8XU3avZJEp=Zog@mail.gmail.com>
Subject: Re: [PATCH 3/3] fetch doc: correct grammar in --force docs
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 18, 2018 at 1:48 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> "Work the same" is incorrect and needs to be "Works the same
> way". Fixes grammar in document anion I added in the recently landed

I, too, find those "document anions" problematic. Perhaps the
physicists around here can do something about it.

> 0bc8d71b99 ("fetch: stop clobbering existing tags without --force",
> 2018-08-31).
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
