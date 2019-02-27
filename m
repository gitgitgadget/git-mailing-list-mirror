Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42B0120248
	for <e@80x24.org>; Wed, 27 Feb 2019 10:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbfB0KMw (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Feb 2019 05:12:52 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:44795 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729393AbfB0KMv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Feb 2019 05:12:51 -0500
Received: by mail-io1-f68.google.com with SMTP id y13so13035429iop.11
        for <git@vger.kernel.org>; Wed, 27 Feb 2019 02:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CGf5U1ilFNki5tfrLBhmmxVP8VKskPBxcUrn6mTDxhw=;
        b=oOWGEZGaWB8fSgKDRdWjJH0P/Be+ot+yw/oFWfjuYEYpbHV7CnaUs0LMYsSqW8apYb
         UgEw5mB23IrgTUjRjEyKrhDTxBnXyoM2zGVRALwntvz1fyRzZeKwgUHBWCxPSheC/SRa
         TlaEKCVE/OyNONkHBYxtIczIbsVKOQ1Kubn29kujfE5/+7GBFWL60yCGCKUK0fPNjR9w
         rYUe5uIl8beyBuYt8OaQXUvlY0aWtXzS9wA0n4q+a3e2+4Cvy2Is7NhC0NbetQpd9PJX
         mWprCFakLwTfUiAg38ccpCMqldz3iHKR94ZAd3aL83LDHp5VdTbHhfKZY6HpRUL5XyWQ
         ZzAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CGf5U1ilFNki5tfrLBhmmxVP8VKskPBxcUrn6mTDxhw=;
        b=aEmuDxCHalTux6jEDI4tBYQhH46vAd2uuqpuKZJujXvNwGCDNw9GGXN6ky22XAQZSX
         JTpCHewNFqpT7mNv47JFq5MYhe1hgaSLJVUeYPDdgwfSwvEK9B7M3/aZbvvbHeD04sbC
         UHebM9qyhcLMitpzUp+liFUipLvt4Nt+rr1F8qd2zMGBiKW7CL5zJB5q95liwKOKvbIi
         XWBVEg0OvGCBTsZKp67LdixBXg/9xa2VN0NzbJZgQ2oVD+dA40Ky2zsmRkkIByn4jDOk
         gv/iUlPflGSgjGi56c6obiqJB6Y7wOYgqW9vQ8mw8utC8QttSYKd2ZR2uL6eM+EgQz10
         Zssw==
X-Gm-Message-State: APjAAAXzSnk4rZNoYVdW25vhd/bbbB3dycv4GkQZkgK/4Yx5i66GmBof
        UgPvc5Zd/+OrFYK0M0qRnk3hFMI9W9M9VMTOpCA=
X-Google-Smtp-Source: APXvYqwKECQU00KFi1DtSfKgS/EuYoSIbnNXSOaJwOkEKEDMe+W82H0i5MsEm9VTzQWr6BJj93rcBtPxL8N1W06cu8Q=
X-Received: by 2002:a5d:9357:: with SMTP id i23mr1259910ioo.236.1551262370317;
 Wed, 27 Feb 2019 02:12:50 -0800 (PST)
MIME-Version: 1.0
References: <pull.152.v2.git.gitgitgadget@gmail.com> <pull.152.v3.git.gitgitgadget@gmail.com>
 <bfeba25c885484093bf8307294935f8baa6b155b.1551221334.git.gitgitgadget@gmail.com>
In-Reply-To: <bfeba25c885484093bf8307294935f8baa6b155b.1551221334.git.gitgitgadget@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 27 Feb 2019 17:12:24 +0700
Message-ID: <CACsJy8BYeLvB7BSM_Jt4vwfGsEBuhaCZfzGPOHe=B=7cvnRwrg@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] t3600: use test_path_is_* functions
To:     Rohit Ashiwal via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 27, 2019 at 5:49 AM Rohit Ashiwal via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
>
> Replace `test -(d|f|e)` calls in t3600-rm.sh
>
> Previously we were using `test -(d|f|e)` to verify
> the presence of a directory/file, but we already
> have helper functions, viz, `test_path_is_dir`,
> `test_path_is_file` and `test_path_is_missing`
> with better functionality.
>
> These helper functions make code more readable
> and informative to someone new to code, also
> these functions have better error messages
>
> Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
> ---
>  t/t3600-rm.sh | 138 +++++++++++++++++++++++++-------------------------
>  1 file changed, 69 insertions(+), 69 deletions(-)
>
> diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
> index 04e5d42bd3..ad638490ac 100755
> --- a/t/t3600-rm.sh
> +++ b/t/t3600-rm.sh
> @@ -83,7 +83,7 @@ test_expect_success \
>
>  test_expect_success \
>      'Post-check that bar does not exist and is not in index after "git rm -f bar"' \
> -    '! [ -f bar ] && test_must_fail git ls-files --error-unmatch bar'
> +    'test_path_is_missing bar && test_must_fail git ls-files --error-unmatch bar'

This line should be broken down in two. It was reasonably short
before, but now getting long and two checks in one line seem easy to
miss.

I was a bit worried that the "test ! something" could be incorrectly
converted because for example, "test ! -d foo" is not always the same
as "test_path_is_missing". If "foo" is intended to be a file, then the
conversion is wrong.

But I don't think you made any wrong conversion here. All these
negative "test" are preceded by "git rm" so the expectation is always
"test ! -e".
-- 
Duy
