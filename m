Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12FD11F453
	for <e@80x24.org>; Thu, 24 Jan 2019 19:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732083AbfAXT4g (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 14:56:36 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53134 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729287AbfAXT4f (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 14:56:35 -0500
Received: by mail-wm1-f68.google.com with SMTP id m1so4508539wml.2
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 11:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Qu6F/rPEd1axT78+dow10z6s3c/ZC/voeud8gSiYyDE=;
        b=FFHJadqx2bfyloIiv39zSGla8/rcSFvju7KiWcOmDWiChZ/NoKyD+A7i/nsWQBoV9D
         OiRCCgdLtHmfxzhgb1k/vCc42pv71THuiDoFdIkHcaxQ9g+eL3tawIqR0LBHS3U0/klH
         X6VjT440xmEtL96zUwn7ajtq/cJnkRGfHiCqv1miHvdebHpeFadEKKDIxK0U8KE7x7xw
         PwbEk8ampr/747ExYSE2AMo19fukzf7tKVMC6Zc/YG1B+SCVTtrMCQzY4Q6z1CsDgBYS
         GJemNR0wf+d5XWMTrAKDY2tVktjgvgsnVvwvToMxYTqPZGWrpFUnquOFXLNlpvEKw9Hg
         KIHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Qu6F/rPEd1axT78+dow10z6s3c/ZC/voeud8gSiYyDE=;
        b=S7R7uydfLwKZWsRoPVuZqQ2wlZaOFG6BXDNQIzAKdbvDuNvtAbS45jrigQ0unveN2C
         UWa1T69o1o3plTu8NShflfOpcKmiQ3qm6lAmeRzaWO315zhsppY3ptesX2UkHGDhrE+E
         OwWQw6vxIV+yTlz6CN4r+QAYD7zVbh44XAwhSYb1MFoYLPkUUqLwuk55jHzP/yuaUToU
         9+BYm/kOsOsh9i5IvHVLWLwzwg6GcagDY/XXK/FdnraLYjtRmFS6181KJ4RE9BkTqtVU
         NXB7nRAiNp0T1iwZBaBwhuFE/igbL0y0W4999sFOn1hrRo90U3N8KxBrb/byyvOgoOJR
         Q/uQ==
X-Gm-Message-State: AJcUukdK0cGpJsLyL2MXUD5SsmIs+tGSIKF8ov9LpgDe1l9W0ryCwrb/
        uDF9xhOjgZOwQetRZJUd6/4=
X-Google-Smtp-Source: ALg8bN7kzaxj5jLaPHAAdx9TfAwEmdZU/q9H3tcpe5NBwUeHImqWf/3hXF4KNp5bF4bu/OAF9iG+sw==
X-Received: by 2002:a1c:dc86:: with SMTP id t128mr4216843wmg.42.1548359793714;
        Thu, 24 Jan 2019 11:56:33 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id v132sm62159819wme.20.2019.01.24.11.56.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 11:56:32 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 00/11] nd/the-index-final small update
References: <20190124082912.24401-1-pclouds@gmail.com>
Date:   Thu, 24 Jan 2019 11:56:32 -0800
In-Reply-To: <20190124082912.24401-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Thu, 24 Jan 2019 15:29:01 +0700")
Message-ID: <xmqq36phj0cv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> This was noticed by Ramsay [1] and I almost forgot.
>
> [1] http://public-inbox.org/git/419519f9-1b48-93bb-eead-eacf6b383f70@ramsayjones.plus.com

Not forgetting is good ;-)

>       diff --git a/repository.c b/repository.c
>       --- a/repository.c
>       +++ b/repository.c
>     +@@
>     ++/*
>     ++ * not really _using_ the compat macros, just make sure the_index
>     ++ * declaration matches the definition in this file.
>     ++ */
>     ++#define USE_THE_INDEX_COMPATIBILITY_MACROS

Hmph, that's an interesting trick.

Thanks, will replace.

>     + #include "cache.h"
>     + #include "repository.h"
>     + #include "object-store.h"
>      @@
>       /* The main repository */
>       static struct repository the_repo;
