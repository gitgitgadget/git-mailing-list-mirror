Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56B451F597
	for <e@80x24.org>; Thu,  2 Aug 2018 20:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbeHBW3Y (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 18:29:24 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43876 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726662AbeHBW3X (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 18:29:23 -0400
Received: by mail-wr1-f67.google.com with SMTP id b15-v6so3357738wrv.10
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 13:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=5PreEuWRctXJ+mVNLairApO/OwcxWxw3cCiJxLyigbk=;
        b=kajkQKKTyE4ic4w9Isu+IYwNVj6MUDGgniQaYygdEuitMwXCsKf/KA2s/lK63YznlJ
         /f3gpcJ0TB3CbNibbq6RIBQUgzV6V2Rt+WH5i41TL1BhznUgJKMSgzUCGGscIf6pdhYf
         uAiFcI1ks/auWSDB58W3V2kdxQrl2pHimL0/9L7zxaPyW6ecph7O+3I7iL9H5YhjUG6W
         pmkVuX9tFwsaiiRNZ7iiPlJDd8eBC9k90p+dnxQY7qEtEBAlUrpPc4aUjE/N5AJLcW0J
         3hNpeGsmOFgk8XHioxBnlfoBOwpgcqD33Em60Y8FTvfvWVFwCrYulCaftw2UCiCLEq3d
         vwWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=5PreEuWRctXJ+mVNLairApO/OwcxWxw3cCiJxLyigbk=;
        b=sghWPD76apcZH7mvCqg5Y1imJazNaMaNPFrIyySOnKhM9wBzhygtwGLIQOcTXAqgFb
         jGtfeTu8NqaPH9NhUdi5OTj/0Or3KpTxPj11wP6ggxe0sTaTD+s1ue6rZ0hYwnqv44Dt
         ITDfouVHTL+X1MG/XCIv1asTbPXneDV2AjnDF8WdVseTfDWTahDuRu9053gpRz0KhpDN
         blYHWTZtKhtfVmfGNlUEbfodqGlKFuC1tAjGXyBBPksHYspLM8tQqsUpRKa9kaZEKSVV
         osMKIp0dygieGSNcRdkwKjjy4eRd3akIi3JZ40iz2r5mFjKzDm63s4sC15yaSybq1LBr
         GMeQ==
X-Gm-Message-State: AOUpUlFrTvjzGX9HQg9TKuUJfXisfjUK1CvtiEfiVGGsc65Ztrfg1csX
        ZVTEBsceA9irAOSu8MkTaqw=
X-Google-Smtp-Source: AAOMgpc2mSaWGXl76RFXmnco1dU1ZIWPgbMngVD8iWaC7fLfMAQzoqj/YKGGhQc8y6TotLbnPC0leA==
X-Received: by 2002:adf:f342:: with SMTP id e2-v6mr620644wrp.161.1533242196742;
        Thu, 02 Aug 2018 13:36:36 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id h83-v6sm2459458wmf.46.2018.08.02.13.36.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 13:36:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>, git@vger.kernel.org
Subject: Re: Re* [PATCH] push: comment on a funny unbalanced option help
References: <xmqqh8ke6i7w.fsf@gitster-ct.c.googlers.com>
        <87k1p9u860.fsf@evledraar.gmail.com>
        <xmqqwot969mp.fsf@gitster-ct.c.googlers.com>
        <xmqq36vw4vu5.fsf_-_@gitster-ct.c.googlers.com>
        <b72e5848-a51d-a62d-2a3c-36ea6b8582d0@web.de>
        <xmqqtvoc3fgl.fsf@gitster-ct.c.googlers.com>
        <87effgtsnm.fsf@evledraar.gmail.com>
Date:   Thu, 02 Aug 2018 13:36:35 -0700
In-Reply-To: <87effgtsnm.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 02 Aug 2018 22:33:49 +0200")
Message-ID: <xmqqr2jgzess.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> Thanks, FWIW that's fine by me, and also if you want to drop this "fake"
> patch of mine and replace it with something René came up with (I have
> not yet read his 1-6 patches submitted on this topic, so maybe they're
> not mutually exclusive).

I think the 6-patch series supersedes this one.  Thanks anyway.
