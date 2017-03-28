Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CE6D1FCA0
	for <e@80x24.org>; Tue, 28 Mar 2017 16:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755136AbdC1Q4W (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 12:56:22 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:35602 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752585AbdC1Q4V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 12:56:21 -0400
Received: by mail-pg0-f47.google.com with SMTP id 81so63556892pgh.2
        for <git@vger.kernel.org>; Tue, 28 Mar 2017 09:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jnPRhpQlrsUz7c4g3oCj7zLSEOar5Mgsy+ZR+vvewbY=;
        b=aulB+lUnycTkqPALq9L/lbosYJ1zDVzVIAawbWU52V1RrvmIBKcp0evYoob8myQtJf
         kiQYdYv+2cefkfBGp8kzt1UFdh9bViOKLqcsKJqJB1DIe65jtC1ZoHWkjwbD5etebGRF
         7h+exzxr3HI8vCL99R+vbMp1rO4jUESCp8CSgMkPZwnogMqS2a7a1LeJ/IEQH8j8s23O
         kYZSk0Qrh2stcdSh1rBP8cC7VUrQnVHDGivxNDeFxyAc1AnkX1RQ2YquATt78F/cCdr6
         A2RflCgm3NcqPzEUPK2oSXUIGdMTcQYlm3bWBTY0FYwcqTjPD4114eglBIIHPKM5FbJd
         tvdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jnPRhpQlrsUz7c4g3oCj7zLSEOar5Mgsy+ZR+vvewbY=;
        b=XdnhSFPtpyWPB3v4E+rDE1UWrjWRFkp1d9uNyxjyIc7MEjmqgiXbiNimQUe0AL5llU
         ZFwC2+q1KyCjX2AIeknRFcY334uOlY9xegejQkVXIxVDRwTEoUbKU7ZM23x+/gYlgQ0X
         bLYTmJbCfVpJJPm0o33GeB7pxUMfz1OgtN5hhfA3aRC3NRuKG/jbw11nAnKZC4ngZS6y
         FP/if0fJ9kmJTRLqNgUjyX1elNd2m/M7ZkMjPn7T1MQyjbP3YJFD/wkPNRg63B4azs1f
         kStNt4GElU6S9m8agBy1FEjoghp5KF/Wjo5y0xR30BNybRBrkF5xuk/77edl5A94w03d
         EUhA==
X-Gm-Message-State: AFeK/H1gVLCsrIB7S+8U2Ob0whjzQ5c5dwHX9waMqRW1FhCWuZ9c94+Je9r9qRX4/4CQZzaMGOGD9rqIqWXLM94+
X-Received: by 10.98.69.86 with SMTP id s83mr33096734pfa.232.1490720161357;
 Tue, 28 Mar 2017 09:56:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.186.196 with HTTP; Tue, 28 Mar 2017 09:56:00 -0700 (PDT)
In-Reply-To: <xmqqlgrqz6ta.fsf@gitster.mtv.corp.google.com>
References: <xmqqlgrqz6ta.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 28 Mar 2017 09:56:00 -0700
Message-ID: <CAGZ79kY=jLJSCCT7MAsvurzRAS+LJKkwt=4HWGgu8nkg0ZXN4Q@mail.gmail.com>
Subject: Re: What's cooking in git.git (Mar 2017, #11; Mon, 27)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> * sb/submodule-short-status (2017-03-27) 7 commits
>  - submodule.c: correctly handle nested submodules in is_submodule_modified
>  - short status: improve reporting for submodule changes
>  - submodule.c: stricter checking for submodules in is_submodule_modified
>  - submodule.c: port is_submodule_modified to use porcelain 2
>  - submodule.c: convert is_submodule_modified to use strbuf_getwholeline
>  - submodule.c: factor out early loop termination in is_submodule_modified
>  - submodule.c: use argv_array in is_submodule_modified
>
>  The output from "git status --short" has been extended to show
>  various kinds of dirtyness in submodules differently; instead of to
>  "M" for modified, 'm' and '?' can be shown to signal changes only
>  to the working tree of the submodule but not the commit that is
>  checked out.
>
>  Waiting for further comments.
>  The endgame looked mostly OK.

I will reroll the top most commit

>  - submodule.c: correctly handle nested submodules in is_submodule_modified

per jrnieder's request to explain itself more (via tests, documentation)

Thanks,
Stefan
