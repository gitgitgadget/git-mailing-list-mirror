Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FC1120288
	for <e@80x24.org>; Fri, 21 Jul 2017 14:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753795AbdGUOaU (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jul 2017 10:30:20 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:33278 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753448AbdGUOaT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2017 10:30:19 -0400
Received: by mail-pg0-f54.google.com with SMTP id k14so29633588pgr.0
        for <git@vger.kernel.org>; Fri, 21 Jul 2017 07:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=F9OFEwdbWjQs5EQ7fIW1m4758iOsnqx3Fh6UN8pm+Oo=;
        b=nJsWioa+vjDJhf+fgjZRHDFAynC2vfnRRu753KfXcrPEov56CuKQaF8OIlaBBfP9Rg
         yTbGC5FOQczlhqIySOlXpiXHyoLzWb+tIIMRZp/2n6u92O/KqeGXOcznLwn8m+VX1xjA
         GiQ93uCh4g0TralB/6HiwdNq9a6Mow6RjkT64bz2vkwply6fMfjjUBQiM+ig6uWxAtBQ
         9BGIGHe1b2PvUmky3YfX2+k+ZFatbFZPjK2KgAOAGvK6OBWS6cVBFsAQaYw0CuoljZ/Q
         bNWMOwnFmxKEkaN30TzPofLPBd8ZGi4nG9FCfSj1B8IYvwo0L2OlGscwUygYwdWxWF1E
         6eTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=F9OFEwdbWjQs5EQ7fIW1m4758iOsnqx3Fh6UN8pm+Oo=;
        b=OkCH/9U9TYXULG/biX2f5ldlRf3nA9istQqXX4M47MgcTz0+JhiIyehxqhnqEl9fr/
         0NqnzQK95YsLJqVUaLRM/CiZmY2yXwgeqIK1cdqK3fxJEt8JzFQ8Kxty+chcoYSIdMhN
         CZfJUfAg7P6rbm9HxKzWRNvmDJaQxEx3fPceyRgAtnGJGSPR1I40coLvyZghiXKURNO2
         vBBGSXYEUwyZAyZ9w2Z41wTMahkv2VqmRzjNu8YMJo9K15ptH6l0SB5YGNwgxMwI0Fzi
         KgXtknijufqicXYh/YO6Eo/iiO461XZl4RJAyhndJdgzlxA97xnMAhReyNiWwRp4qBDU
         TEHQ==
X-Gm-Message-State: AIVw110ykaWf+9CyOKYC/xDqUofV2oKHh0oSQAI/j4vg70B/mQKC14xD
        G+6Dyphw/omq9BDRQ+DZmgcNt5+TrQ==
X-Received: by 10.84.231.139 with SMTP id g11mr8344026plk.283.1500647419348;
 Fri, 21 Jul 2017 07:30:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.130.67 with HTTP; Fri, 21 Jul 2017 07:30:18 -0700 (PDT)
In-Reply-To: <CAHNyMp8xeye8EvtOdrX34QVCDsBCu3aLQVdyGRTVqyHXjZ4FFQ@mail.gmail.com>
References: <CAHNyMp8xeye8EvtOdrX34QVCDsBCu3aLQVdyGRTVqyHXjZ4FFQ@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 21 Jul 2017 16:30:18 +0200
Message-ID: <CAN0heSrQv=TjjE_=9PC14Ob2dn9g4Qq0Vm+yPoh6hmGzd1W_Uw@mail.gmail.com>
Subject: Re: fatal: bad numeric config value '60 days' for 'gc.rerereresolved':
 invalid unit
To:     Uwe Hausbrand <uwe.hausbrand@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21 July 2017 at 14:59, Uwe Hausbrand <uwe.hausbrand@gmx.de> wrote:
> git config gc.rerereresolved "60 days"
> git gc
>
> results in:
[...]
> fatal: bad numeric config value '60 days' for 'gc.rerereresolved': invalid unit
> error: failed to run rerere

It's not entirely clear, but "man git-gc" does seem to suggest -- at
least to me -- that one can say "60 days". Especially after reading
about gc.reflogExpire a few paragraphs earlier, where "90 days" and "3
months" are given as examples. Luckily, "man git-config" is a bit
clearer. It says that "records ... are kept for this many days". The
latter matches the implementation and the tests, which are all written
to work with just an integer.

So "git config gc.rerereresolved 60" should work. Hope that helps.

Martin
