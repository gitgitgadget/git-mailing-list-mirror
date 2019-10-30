Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 164C21F4C0
	for <e@80x24.org>; Wed, 30 Oct 2019 06:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbfJ3G5D (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Oct 2019 02:57:03 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:44638 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfJ3G5C (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Oct 2019 02:57:02 -0400
Received: by mail-ot1-f45.google.com with SMTP id n48so1156406ota.11
        for <git@vger.kernel.org>; Tue, 29 Oct 2019 23:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ftWSEJ/7aM7jkQVdDNeyzwz0tlyeUXZv6QRxupjnL30=;
        b=MICtOHvE0XO0x0MwVj8KZnzhDNxpM9Q3wGHohFcx817uM2TlZ3AQS6itTpMZQhoBgU
         9YD62YtKeYzqTyzhJPBjX/Rccr0YbgVr/JWRqWMV532lfiKO4mB0zCBxwje/Ea4sFwCa
         mpQFa6xH8/w+PgSAxOwpe0Gm97E3ndHANKW9MconVAm4uiXjNy5cVLfa0OWwsKvkgUXo
         XrzjgUcjRJ/DK+qiwwvv+y7d504uczUxKHEyERpcu3LFfyiKD3HIflNL3nsTEcDo83BH
         lyy4KPs9G3dxiWVbL4z3czn2FTuQ+U8xTzlNYZm2D6WfXdW47Z5xHHzZIrafKg9HeBpA
         XQoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ftWSEJ/7aM7jkQVdDNeyzwz0tlyeUXZv6QRxupjnL30=;
        b=QfpEuRU7e28krNTyvqEWfELZY1MjF9e/2fhKBA1bSVaKiUZh2YGXTHjnjILSd/P+tZ
         9f8J8CaUUzMHbOoi0KYlHYJ6kb5HLec5S4ExrtMiunT2SESlFPpIa+0j4G78XunAjAQb
         bcCrVSp5YQEaKJt0g0C62EOVOT86AqMg5cNdFln6ZFIxcFNrH99sroDeQPb1SQ+RdgkH
         Fedqnzv2zFVNGkXecdRK217pVDPaPPjw0MsDFxvGG/l0kMDcYa2ykeUYAtOyHn/I2J65
         JKXALeV6unoyYNUFYys+g04sobZ6a2vnVmOQtpNYEMaS9leCAy3E74ahFnhyUXaCL6Om
         BBkw==
X-Gm-Message-State: APjAAAUruu0YtCiMFRmzbZLdEyV3GHxCBn7Cmr4c4lOYnvTVMVpR2cVU
        FRiwXnQpZpwveP4P8w9nXq6zZ1ElQoZ4UBvWMgyZJQgZ
X-Google-Smtp-Source: APXvYqyIFWwAB7STvYJD9aoB5KfV64PCfBZ1bQ1sKa9nNM4zfrVu4WZR1D4UVd9ixJmif4hws5bLEnSXylqeLb9C010=
X-Received: by 2002:a05:6830:1e4a:: with SMTP id e10mr8318801otj.345.1572418621787;
 Tue, 29 Oct 2019 23:57:01 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqeez2fzsy.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqeez2fzsy.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 29 Oct 2019 23:56:50 -0700
Message-ID: <CABPp-BGV=5FuMfq1pYbbHCMMvyVGQPS_8yTjqhKoqrm7O1KFow@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git v2.24.0-rc1
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

A couple questions on the release notes...

On Thu, Oct 24, 2019 at 1:35 PM Junio C Hamano <gitster@pobox.com> wrote:
> Git 2.24 Release Notes (draft)
> ==============================
>
> Updates since v2.23
> -------------------
>
> Backward compatibility note
>
>  * Although it is not officially deprecated, "filter-branch" is
>    showing its age and alternatives are available.  From this release,
>    we started to discourage its uses and hint people about
>    filter-repo.

What do you mean by deprecation, then?

My understanding has always been that deprecation meant "supported but
discouraged", which is exactly what we're doing.  We also run the risk
of people seeing "not officially deprecated" in the release notes,
then being very confused why the documentation and the program itself
is discouraging its own use and wonder if they configured things wrong
or got the wrong version of git ("The release notes says it isn't
deprecated, but whatever version I'm running definitely does have it
deprecated.  What'd I do wrong??").

>  * The merge-recursive machiery is one of the most complex parts of

I fixed this "machiery" typo in en/doc-typofix but as that hasn't even
merged down to next yet, I'm wondering if you're planning to include
that in the release.  Should I provide a subset of those fixes in a
separate patch for inclusion in the 2.24 release?  Which of the types
of doc typo fixes would you want to see at this point for including?
