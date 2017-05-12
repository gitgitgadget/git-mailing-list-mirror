Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB15220188
	for <e@80x24.org>; Fri, 12 May 2017 07:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756712AbdELHsA (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 03:48:00 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:36446 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756674AbdELHr6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 03:47:58 -0400
Received: by mail-it0-f47.google.com with SMTP id o5so6256403ith.1
        for <git@vger.kernel.org>; Fri, 12 May 2017 00:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MLnR8NTv2snmDbxtuFLdJbPjmrplopCigUfMeY9UVuE=;
        b=P1lZ3LTiWEHSMW4rEhs6wrdZ3s4cYsNr+FedOZI9CYfXy0LD7Ks0C2Xf5moiLSHbju
         bgAoYi/d7Ik05URsqMfkGd49gSS6xACTVyVIXpSojW3ERIOtbpUZVXKyz9/U9X4H2M/l
         /cPT8zvVe74o62YiNlJpLsQZZ/VPWk2f4yyWIKIkE5f9W/H9+4Kd6QRBMUv9halFoG76
         9v5zpopRk6qca73MQrmkfGs+geUDC0OSHe7h7Y7HhuUaXIGboBvfAwinNydUaJlvxXpa
         QR1n/GSuNo6JH9fxSanOEz1RvHbjDOCytlGQisZ+XpDWDEt6bmiYy3++4lxKZLB4PrWC
         h2iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MLnR8NTv2snmDbxtuFLdJbPjmrplopCigUfMeY9UVuE=;
        b=YlavN2ROJrkv7OQKJGH+jkd5MBD/lVDE/xCV7NMIpVLCGS7DowFeD2XY90YrpxXXTD
         W6HN+rz5/qErosQ1o7qB+P57PwIotlC02Ged+GOdmzLo98Yq4a46dxzvaECnfyxqTnNA
         rALJ1M3+V6HqMMbdYa/LFV8kxs71gI/G+n4mfRYkXDad09+OqEakqKfw9fW+AxIYRuhQ
         sQD0utzTgdXcpuPH8SpAzRv28Q8/sNP50OQo90CbbMVQbaS/A+AFcToKVvxcWgYNHy8n
         oXAbNtVDTu4c8/vj6I8x9TyOxEsUyZa086Uo2moKN5mm1tkbZr5nNp30HcRqXqUpLPjW
         1/eg==
X-Gm-Message-State: AODbwcDYZPJjQi1wp//7nWsVfgw8+lcwacJEfF4VtBbjMxq9ngOdWzou
        nHhOws8NjW4imJ4if19O9NpVS2HBtFaJfKc=
X-Received: by 10.36.154.3 with SMTP id l3mr1753669ite.94.1494575277984; Fri,
 12 May 2017 00:47:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Fri, 12 May 2017 00:47:37 -0700 (PDT)
In-Reply-To: <xmqqpofe60dy.fsf@gitster.mtv.corp.google.com>
References: <xmqqpofe60dy.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Fri, 12 May 2017 09:47:37 +0200
Message-ID: <CACBZZX700n_nFvYxy0Z4M2cUqaOF0bNhLxJ9XJYGNDu8bk5HNg@mail.gmail.com>
Subject: Re: What's cooking in git.git (May 2017, #04; Fri, 12)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 12, 2017 at 8:43 AM, Junio C Hamano <gitster@pobox.com> wrote:
> * ab/grep-preparatory-cleanup (2017-05-12) 15 commits
>  - grep: add tests to fix blind spots with \0 patterns
>  - grep: prepare for testing binary regexes containing rx metacharacters
>  - SQUASH???
>  - grep: add a test helper function for less verbose -f \0 tests
>  - grep: add tests for grep pattern types being passed to submodules
>  - grep: amend submodule recursion test for regex engine testing
>  - grep: add tests for --threads=N and grep.threads
>  - SQUASH???
>  - grep: change non-ASCII -i test to stop using --debug
>  - grep: add a test for backreferences in PCRE patterns
>  - grep: add a test asserting that --perl-regexp dies when !PCRE
>  - log: add exhaustive tests for pattern style options & config
>  - test-lib: rename the LIBPCRE prerequisite to PCRE
>  - grep & rev-list doc: stop promising libpcre for --perl-regexp
>  - Makefile & configure: reword inaccurate comment about PCRE
>
>  (what is queued here is only the early part of a larger series)

What's the reason for only queuing it up to this point? AFAICT there's
no particular breakages past this point that would prevent the whole
thing from being queued.

I'm going to fix the issues noted on-list, but wondering what I should
do with the next submission. Do you think with fixes you'd like to
take the whole thing?


> --------------------------------------------------
> [Cooking]
>
> * ab/compat-regex-update (2017-05-12) 3 commits
>  - DONTMERGE compat/regex: make it compile with -Werror=int-to-pointer-cast
>  - compat/regex: update the gawk regex engine from upstream
>  - compat/regex: add a README with a maintenance guide
>
>  Update compat/regex we borrowed from gawk.  It seems that some
>  customizations we made to the older one were dropped by mistake.

Do you prefer that I pick up JS's "compat/regex: fix compilation on
Windows" patch & re-send, or for you to add that on top after that
discussion is resolved?
