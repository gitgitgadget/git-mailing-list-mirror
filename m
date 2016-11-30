Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 993FE1FC96
	for <e@80x24.org>; Wed, 30 Nov 2016 00:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754872AbcK3AZd (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Nov 2016 19:25:33 -0500
Received: from mail-qk0-f182.google.com ([209.85.220.182]:34189 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753834AbcK3AZb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2016 19:25:31 -0500
Received: by mail-qk0-f182.google.com with SMTP id q130so6045774qke.1
        for <git@vger.kernel.org>; Tue, 29 Nov 2016 16:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jCq8HKFnGTBct0o6OIQk/zIljBVachQzEgZr9tBF3nw=;
        b=AeNpGNCKqD/oUQRtj5w7ghoed86o3lWZIZV7uYXZ8uKcttlhelmsOeYKBKy2DJSSYk
         iW3Bo+rcJI+RgKHZl8PgI+ocfkQzW3mJV9Jxxpq8yhzP189m98cks5c3y8jqyK3KLNZr
         gjZcOIqZjcLhzWbXE1O57qXP6nbWy4MsnuoSSX4gijxrTuXbwpLMCBbde0iQmDR2gU7N
         9wJdnr8tHmsqLbl3PFF8xj/0vou8pGOQo0ftK+qMd280+eIYGLQ1eyI8ymDoN/3Zzixw
         SNJbKGwZJpxbLXG8MUSErAn5Q0khi8gGTP+uCXms6h1q9YilMFOP13OJNF198x2e59eP
         itTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jCq8HKFnGTBct0o6OIQk/zIljBVachQzEgZr9tBF3nw=;
        b=U6E1ZQ6uVfvi061FIwU/6zUWKnRQZA17l3TQkwb8rKbroyuDJUvO67wZKjzfRSBLcB
         T6EjJnGDl+5/nhzrTqjUY8Zt7aesbSA41WaQgUdHF5H0dI1nS/kXfjVgVYcK8wgwtZvP
         5hfw+8r8lwuAr+zovFWyx8Q0eWEDeMYDMd4fvfsqEzthiCYe4G8DNjzZkq7ya+STxn2L
         cjdl4NLFqgxXjcj+OwBh9Wf8hI4fm45UAw/wk5lpxzj9JXjZVs2bfvoCZ8msFGwn1yRk
         f/NLZ955FMzpzSlt1zpND1V+kRM7s5ybjcLR1JBc/QuOhAEyNIkN42mqUGohNhvwuoHq
         QrFQ==
X-Gm-Message-State: AKaTC02dGcaUTRAoMsZ6KiBKULaUcK4CIfCDQmiWikZLQceK2dkkIdHbhKLx7tjLb6JzI+bp8WTiqk0oHyf2APwc
X-Received: by 10.55.16.147 with SMTP id 19mr26490252qkq.255.1480465530574;
 Tue, 29 Nov 2016 16:25:30 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Tue, 29 Nov 2016 16:25:30 -0800 (PST)
In-Reply-To: <CAGZ79kZbBufaKoJyTQa_DseE5GofMAwb=ujtEYn35r9VEwdJ2g@mail.gmail.com>
References: <xmqqk2bngn03.fsf@gitster.mtv.corp.google.com> <CAGZ79kZbBufaKoJyTQa_DseE5GofMAwb=ujtEYn35r9VEwdJ2g@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 29 Nov 2016 16:25:30 -0800
Message-ID: <CAGZ79kb36bOuwhqHZYY5zmOOcqerwSh=HRV91K1FiAQLEzZAGQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Nov 2016, #06; Mon, 28)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 29, 2016 at 11:21 AM, Stefan Beller <sbeller@google.com> wrote:
>
>>
>> * dt/empty-submodule-in-merge (2016-11-17) 1 commit
>>  - submodules: allow empty working-tree dirs in merge/cherry-pick
>>
>>  Waiting for review
>
> That slipped by me. Will review.
>

I reviewed what you have queued and it still looks good to me.
