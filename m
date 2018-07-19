Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84F021F597
	for <e@80x24.org>; Thu, 19 Jul 2018 08:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730220AbeGSJa1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 05:30:27 -0400
Received: from mail-yb0-f177.google.com ([209.85.213.177]:33078 "EHLO
        mail-yb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbeGSJa1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 05:30:27 -0400
Received: by mail-yb0-f177.google.com with SMTP id e84-v6so2963874ybb.0
        for <git@vger.kernel.org>; Thu, 19 Jul 2018 01:48:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I+c2N6EY32qkZLcaHufh5FQyCm06GG9EaNC13NofvtM=;
        b=Kq6xn0jWuLQWaUJQudFJTrg14Gp1aRU+hpc/yNzCTiFqDmRkOhJC3BVlXJOc1+RJr+
         RsklHCShOtd2XuphaPuiEPryPtyDtfSN4OVMPoGjWIVvXBVRiZDy10lLfOC4inGI/g6I
         FpUoVoo3/elpA/a9ycaXIx2ujhrXfe8+RkZATZgOTF3Z9ZLSZbawsFCcDJ3/LYvo3MP/
         bHeFonCiVO/lgqvn/zdCMmt9kvDit89dapZydIw3WtfrDpM0RyHbu0iOXdsdxGj0q5jW
         KDvPkGOOxLb3umjk6T40GN9S6p7fxkFGvx+d9jrM0kD2EPtpQxOmQZ3YLYOprXQoQ5WM
         REWg==
X-Gm-Message-State: AOUpUlFtsUH7G5KutSVE+fZBH+ALF5YB1/BhbOVj/fzle3KI3V4rqPod
        z9+5SYCTTn2TghuCC6F12OLQdaa41rvggjw3O7M=
X-Google-Smtp-Source: AAOMgpc0DbIpCkXRrHsovKc4rVLZK/hamDCXdGgECa10wWNRrJmbIl7FJgA/XwgRyP0LPJIUP8/sbebkUmaYPPeKMds=
X-Received: by 2002:a25:488a:: with SMTP id v132-v6mr4999813yba.263.1531990100405;
 Thu, 19 Jul 2018 01:48:20 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqtvowi4l3.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqtvowi4l3.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 19 Jul 2018 04:48:09 -0400
Message-ID: <CAPig+cQTWHzYZ9+LqadhZ=u-NkDOtmf7gDL5MvahC3=SCfjhZA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jul 2018, #02; Wed, 18)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 18, 2018 at 6:04 PM Junio C Hamano <gitster@pobox.com> wrote:
> * es/test-lint-one-shot-export (2018-07-16) 5 commits
>   (merged to 'next' on 2018-07-18 at 26a6124963)
>  + t/check-non-portable-shell: detect "FOO=bar shell_func"
>  + t/check-non-portable-shell: make error messages more compact
>  + t/check-non-portable-shell: stop being so polite
>  + t6046/t9833: fix use of "VAR=VAL cmd" with a shell function
>  + Merge branch 'jc/t3404-one-shot-export-fix' into es/test-lint-one-shot-export
>  (this branch uses jc/t3404-one-shot-export-fix.)
>
>  Look for broken use of "vAR=VAL shell_func" in test scripts as part
>  of test-lint.

s/vAR/VAR/

> * bb/pedantic (2018-07-09) 8 commits
>   (merged to 'next' on 2018-07-18 at e9d075e8ed)
>  + utf8.c: avoid char overflow
>  + string-list.c: avoid conversion from void * to function pointer
>  + sequencer.c: avoid empty statements at top level
>  + convert.c: replace "\e" escapes with "\033".
>  + fixup! refs/refs-internal.h: avoid forward declaration of an enum
>  + refs/refs-internal.h: avoid forward declaration of an enum
>  + fixup! connect.h: avoid forward declaration of an enum
>  + connect.h: avoid forward declaration of an enum

I guess the two fixup!'s were meant to be squashed (and it's probably
too late to do so now?).
