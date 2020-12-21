Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73780C433DB
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 17:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 354EB22BEA
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 17:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725791AbgLURvV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 12:51:21 -0500
Received: from mail-ej1-f54.google.com ([209.85.218.54]:46224 "EHLO
        mail-ej1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgLURvU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 12:51:20 -0500
Received: by mail-ej1-f54.google.com with SMTP id j22so14580417eja.13
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 09:51:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bKsqPrzxwVJqmRJGk1zGvuHEL0oB8tyGmGhy69LIbTA=;
        b=uBSO0eZWvxj6XTLXYBkbwo/GPucJzpnx5D55WLG45vrrPem8IEk84EAxMpGprrhzFA
         K8gJ/7L8rvURv1ECcBR1OGGc+KdOqZLhPkMlKBoysptfzLNAGLDvNSKYt8jRgENE7G4d
         D/nYMeIqN2XGCxgSMZbdCM6bPpkhyop9UAGV2mH2XBjsYytInbiQxJfCLg30Fe3/etce
         N1A99vCSRGRlKTM6JABQywvEiRGL6RzbqMs8lCdghtkIojRnboFUDTrqWjYwUAqTdjFw
         gyHflF2ZTNf9nRzieFWZEZIE9LqjpX/n92fRUGE9nDo9C2X9ov/bJxQZ0QBjO1WInQ8e
         BMAw==
X-Gm-Message-State: AOAM533Yy3bvKH2dWyqilIuXA4K8yKetmAkWAukp6gDxuryBycUkeChc
        IMsybD81AN67uAWsFqp4HrjumbQCoJLYeKC9+ZlFo+lw
X-Google-Smtp-Source: ABdhPJx6CFE0rcJhjysZ+cd8yP5ZHt0uSstq4xlz/1KCUP+dlSqE+3wOrtuS7ClRWE19pbN476KY0R99XwAz8aJhMfE=
X-Received: by 2002:a17:906:15ca:: with SMTP id l10mr15976295ejd.402.1608573039029;
 Mon, 21 Dec 2020 09:50:39 -0800 (PST)
MIME-Version: 1.0
References: <xmqq7dpeqrz4.fsf@gitster.c.googlers.com> <CABPp-BFoSz40-1mNLrxCgMTccYqLOg6ifX5PeLDutbimF9ysPQ@mail.gmail.com>
 <xmqqblepnd9k.fsf@gitster.c.googlers.com> <CABPp-BErnY+zfmp-LWTe0EUB5QKKcLCP=4t9VxwvA_+DaBvDuw@mail.gmail.com>
In-Reply-To: <CABPp-BErnY+zfmp-LWTe0EUB5QKKcLCP=4t9VxwvA_+DaBvDuw@mail.gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Mon, 21 Dec 2020 09:50:27 -0800
Message-ID: <CAPc5daWFn3Y_MYUAPWgmYQEu9-9PYROewczrzGfd4qs8dvaZAw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Dec 2020, #03; Fri, 18)
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I'm still confused.  en/merge-ort-3 and en/merge-ort-recursive do not
> share any commits.  The only tie is that each "uses en/merge-ort-2",
> as you noted, but that was already noted separately.  Am I missing
> something?

Yes, en/merge-ort-2 is not yet merged to 'master' and these two share
the commits on them. Due to lack of better phrase that is labeled as
"tangled".
