Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B37591FC46
	for <e@80x24.org>; Fri, 10 Feb 2017 21:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751441AbdBJVhO (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 16:37:14 -0500
Received: from mail-io0-f170.google.com ([209.85.223.170]:34026 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751029AbdBJVhN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2017 16:37:13 -0500
Received: by mail-io0-f170.google.com with SMTP id l66so60936100ioi.1
        for <git@vger.kernel.org>; Fri, 10 Feb 2017 13:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/LhSPriwnGVVRglgr+sfaz2ZkxvUvz5aDbHUJKLYuQA=;
        b=hpBOdyn1NPXgC79cLSdv+NI+q72fOsQlrRy/7NX6yuJTCAnglbRnKSCYrkMR0eGPKg
         cOUIjyrcaf+RkawxL4Ady1lzaNuEBoO0QkymAqDJxh5wgu04n9w+NuF8nlOjwRNey1Wn
         37tj+Kg0ObP6EX2D+D3GIKsw3hIEul2d+L/BjGBNDZDTESm6gYvcx4JwmeZgpQa405HV
         Rq52cxF6BQyU29bDFW3iSY7vZMeSzjNUq4aVqHQAa32mQvbz3FdheR6ygI2YDFB6DeI9
         xYndhtKZkaUt3grlRYBFnOSUanU1xo695t0JYUuqbM8UCRurepl7PZm7NNH4wztNM0be
         wFeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/LhSPriwnGVVRglgr+sfaz2ZkxvUvz5aDbHUJKLYuQA=;
        b=LZ5iOv0kfLVnYNIkupbw+9yA/t4AYy3UF6/pdIwxbyfqDcmBOUJFAQNZdcTj66Pfs2
         i2Yoy7/Vy/sWGMmJtGrV3tZ9r/S3yMa9SkG5+WHBOf/XcE4UqfwSzCRr2j4LozDvV7W6
         NByCLpb8AY3Am4Xg3kTX8eO4b6ITJKPbpc7qSC+R4wNnUWIA6bwAXGeKuY/p9NjzEbtf
         DLwPfGvwEL/Rxu7W1onVgYRlI3iFum9oZbDVXJs5Qyu+GJ4f9fEIVuadgSEneGtcgXFu
         hNVcPwrPh5N5HJGyVXcd50y8V3wEJz+QSNZy562SxpE7ezvyHHAsD3du47wOC9fTpwuT
         qA9A==
X-Gm-Message-State: AMke39lG7hf6TWERNfyTnXpIUDBsafWlrB2xaDakZc0kJocgiIhckFAQMaaBMFRCHETlm9/1AzNN6IWXFqg4s0Ua
X-Received: by 10.107.37.148 with SMTP id l142mr10115158iol.159.1486762632850;
 Fri, 10 Feb 2017 13:37:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Fri, 10 Feb 2017 13:37:12 -0800 (PST)
In-Reply-To: <20170210205749.c72ajnld7zjfjkwj@sigill.intra.peff.net>
References: <CAKwvOdn9j=_Ob=xq4ucN6Ar1G537zNiU9ox4iF6o1qO7kPY41A@mail.gmail.com>
 <20170210205749.c72ajnld7zjfjkwj@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 10 Feb 2017 13:37:12 -0800
Message-ID: <CAGZ79kaG=oqDM=1+rz_zk6Qn-7wAszxPnBtqrkAJS29_qT7SoA@mail.gmail.com>
Subject: Re: fuzzy patch application
To:     Jeff King <peff@peff.net>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 10, 2017 at 12:57 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Feb 10, 2017 at 11:20:59AM -0800, Nick Desaulniers wrote:
>
>> I frequently need to backport patches from the Linux kernel to older
>> kernel versions (Android Security).  My usual workflow for simple
>> patches is:
>>
>> 1. try `git am patch.txt`.
>
> This is not exactly an answer to your question, but "git am -3" is often
> a better solution than trying to fuzz patches. It assumes the patches
> are Git patches (and record their origin blobs), and that you have that
> blob (which should be true if the patches are based on the normal kernel
> history, and you just fetch that history into your repository).
>
> I've found that this often manages to apply patches that "git apply"
> will not by itself. And I also find the resulting conflicts to be much
> easier to deal with than patch's ".rej" files.
>
> -Peff

I have been told this a couple of times before; do we want to make -3
the default (in 2.13 then) ?
