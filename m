Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E04761F461
	for <e@80x24.org>; Mon, 26 Aug 2019 14:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731926AbfHZOoq (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 10:44:46 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39284 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731833AbfHZOop (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 10:44:45 -0400
Received: by mail-wm1-f66.google.com with SMTP id i63so16136966wmg.4
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 07:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6iTPzh2b9IwFYagNRmOsFgbk7vTQpAKCuDkRxnpU5Sg=;
        b=Uiln4RVR1Gzth/lo37r9CwBQUe/qQzZsetdRoBPDXez+p4rhnI1LKi0tfG6aTmZx4c
         bU5KP6bTV9wHOFFFzeH6Mg6hfkzldtS/GQU9GbuIEzizPEO/g6NL/kGkFCAsSmnu0UWZ
         qiw0LaBYdffgjrbVXSmoHgOK3eWWxQ8iC/WTFEzdnrW/V14mztFinicI90RTeseaQMcj
         GFYFrDiuf8c5/ydwjRDiKv5gaY/J+4iYjeFRxa+CT1pkrMxQF5rDVPRNsIIse1C0IeI1
         9Tps0yJfe+0mMpT4IZE2tMPPQBQXmKrJ/cbuV+Kjnnk2VKRhXDQkhgXRSXunNS91qVpw
         JZBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6iTPzh2b9IwFYagNRmOsFgbk7vTQpAKCuDkRxnpU5Sg=;
        b=mLy72lB2DSR+7k6UKRTeFQ7JBATdRfEFLLkK4/+n4v3+Q3iLvSbaqwnufS0wUKEe1E
         Oa7hBjuB4rztGnyX+OVCa147a33D4Tnns6nYShP9vc0DNM7XIevb5eyblWruI/hWQ+dO
         RJtuDp1+XbqAfP4VK9DZWjyaPe3CzCfJY+z3ti5ePNvXZbVXZXuu+Cg1plI3lZSaTC8t
         JqT5wPYL0nV1wv8Wc+rNwfPYfQYzVhCzjYMAIRNEg8zV3qs2Prkrk7WKNUyXUgkNyvmk
         88HhX9x82OL5RBjz4tXPDrbMLWo4sCPV2NF5iGJrNZ+w3vYNJYLAtyAkZB+cAXdAqte0
         ZUWw==
X-Gm-Message-State: APjAAAW3Moxwz5RVgziC/3fG7SX1QJAdj3nxHJ4OYeeItsNfyAwgft50
        GiXOUb/oyYJFvFHH2gyLG8npjh2unBE=
X-Google-Smtp-Source: APXvYqyjRmIwPZncLiPZt3UFaTsPt68WLkQLTsqyYtDQ1zQmKs6K8VCvlzWzqD4RlwR9LVwwAIyfgg==
X-Received: by 2002:a1c:a8d7:: with SMTP id r206mr22195998wme.47.1566830683886;
        Mon, 26 Aug 2019 07:44:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z2sm9486930wmi.2.2019.08.26.07.44.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Aug 2019 07:44:43 -0700 (PDT)
Date:   Mon, 26 Aug 2019 07:44:43 -0700 (PDT)
X-Google-Original-Date: Mon, 26 Aug 2019 14:44:41 GMT
Message-Id: <pull.314.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.314.git.gitgitgadget@gmail.com>
References: <pull.314.git.gitgitgadget@gmail.com>
From:   "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/1] quote: handle null and empty strings in sq_quote_buf_pretty()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     garimasigit@gmail.com, jeffhost@microsoft.com, stolee@gmail.com,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey,

The sq_quote_buf_pretty() function does not emit anything when the incoming
string is empty, but the function is to accumulate command line arguments,
properly quoted as necessary, and the right way to add an argument that is
an empty string is to show it quoted, i.e. ''.

Looking forward to your review. Cheers! Garima Singh

Reported by: Junio Hamano gitster@pobox.com [gitster@pobox.com] in
https://public-inbox.org/git/pull.298.git.gitgitgadget@gmail.com/T/#m9e33936067ec2066f675aa63133a2486efd415fd

Garima Singh (1):
  quote: handle null and empty strings in sq_quote_buf_pretty()

 quote.c          | 12 ++++++++++++
 t/t0014-alias.sh |  8 ++++++++
 2 files changed, 20 insertions(+)


base-commit: 5fa0f5238b0cd46cfe7f6fa76c3f526ea98148d9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-314%2Fgarimasi514%2FcoreGit-fixQuote-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-314/garimasi514/coreGit-fixQuote-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/314

Range-diff vs v1:

 1:  9d2685bdb2 < -:  ---------- quote: handle null and empty strings in sq_quote_buf_pretty()
 -:  ---------- > 1:  b9a68598d7 quote: handle null and empty strings in sq_quote_buf_pretty()

-- 
gitgitgadget
