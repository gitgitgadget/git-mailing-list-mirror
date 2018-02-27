Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E42A21F404
	for <e@80x24.org>; Tue, 27 Feb 2018 21:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751880AbeB0Vml (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 16:42:41 -0500
Received: from mail-yw0-f178.google.com ([209.85.161.178]:39980 "EHLO
        mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751633AbeB0Vmk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 16:42:40 -0500
Received: by mail-yw0-f178.google.com with SMTP id y186so119722ywf.7
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 13:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3B9y04O1mWhRYUhEubPjPJaxj8nyCQIlOmDPxtFspZo=;
        b=WaEoBm9F1DVBzIYm067h+vxW311mj69JqfOIgVixrYKt5Zy2zBq7ik239HRKLW3kJ2
         EMxhVELAJtl9myslpcmp8yBOXW+otvxYB0cTE7WESiHn74SK3PHkwyLacfRSmjU++06K
         4ZLFcY0kTVFPf4eyD88YskX4anpM6Wl+RgTiMKDvWeuujR7YjMzRb2RnOjXnaIGF6aRI
         KSt+HGhIjT40JCZHrDoZ/V7Y0SNs97ZR8dkKiWoeqgucaGm6CcondrjGaAmt+xpZpmMk
         8TBup35/3TRe3vCFUgvdMhtJK59800q21GuOC4QL4j6z8csRhb4IW5M+6gHeKFZq2OMr
         NVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3B9y04O1mWhRYUhEubPjPJaxj8nyCQIlOmDPxtFspZo=;
        b=qbM8JrzjtEW8dfqZVkQTXljuhCK0otIjgHvN/AaNDNR7Gh0QB9fA3sbsHbareqh+ll
         ZVwpPB4nM9n7XKSZJRPjAOx9TKJLRTYczTLoQmEXez5AECUIPlhIUeYBLIqOWZIKq0fj
         Ot60GHkQdLlejt4Ja0vPbj0ZvtFjk+efYSoJGCDgaNTM/ERpgYlG7p5ZPoRt/nQqGl5K
         lmi6wRe9Jck/TJK/axDZl/Q+fQGC3dgtV5oP3vbEj2kU8SzXopPTEZ6Zn70lJaUOr/NI
         uJIkABYq/p6fx+lLVVMgKj7BZXG80NuqOyI5jCsrKDnXMlpJMcA2FcKntWGdlgmQvMlE
         St4A==
X-Gm-Message-State: APf1xPCRV3n3nbQnN+KpfVlZmVPmMFpzGgrAX2+S3AMtziOYszfoiBaM
        n41JwcE0cVeXJ471QMZGV5f+DqlVZqlvnnw4la0pvA==
X-Google-Smtp-Source: AH8x224fsksd+yGa7zan9+YRZ55Ou5qF2zzXYKG01pUPdowodrUSfl+MYWlxRc6aeuGXNVpfzXK1wTOltkztZVllSDI=
X-Received: by 10.129.36.4 with SMTP id k4mr10378101ywk.238.1519767759473;
 Tue, 27 Feb 2018 13:42:39 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:cfcb:0:0:0:0:0 with HTTP; Tue, 27 Feb 2018 13:42:38
 -0800 (PST)
In-Reply-To: <xmqqh8q2p1ha.fsf_-_@gitster-ct.c.googlers.com>
References: <20180223233951.11154-1-szeder.dev@gmail.com> <20180223233951.11154-5-szeder.dev@gmail.com>
 <xmqqtvu2p2kx.fsf@gitster-ct.c.googlers.com> <xmqqpo4qp290.fsf@gitster-ct.c.googlers.com>
 <xmqqh8q2p1ha.fsf_-_@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 27 Feb 2018 13:42:38 -0800
Message-ID: <CAGZ79kYs8n2NF03S_ieFpVo14zqZMAcTn2x-7+Bm1-2Mwr0=Ng@mail.gmail.com>
Subject: Re: [PATCH] test_must_be_empty: make sure the file exists, not just empty
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 27, 2018 at 1:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
> The helper function test_must_be_empty is meant to make sure the
> given file is empty, but its implementation is:
>
>         if test -s "$1"
>         then
>                 ... not empty, we detected a failure ...
>         fi
>
> Surely, the file having non-zero size is a sign that the condition
> "the file must be empty" is violated, but it misses the case where
> the file does not even exist.  It is an accident waiting to happen
> with a buggy test like this:
>
>         git frotz 2>error-message &&
>         test_must_be_empty errro-message
>
> that won't get caught until you deliberately break 'git frotz' and
> notice why the test does not fail.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Reviewed-by: Stefan Beller <sbeller@google.com>
