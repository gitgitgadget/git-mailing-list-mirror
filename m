Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F83E1F406
	for <e@80x24.org>; Wed, 16 May 2018 16:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750806AbeEPQ4g (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 12:56:36 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:44088 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750772AbeEPQ4f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 12:56:35 -0400
Received: by mail-yb0-f194.google.com with SMTP id m127-v6so491329ybm.11
        for <git@vger.kernel.org>; Wed, 16 May 2018 09:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nwpocxihxhtiQrwyCJLazLY71myNq6OU53eEZnhHPVM=;
        b=v3/R9BNS7Kkz25gC68GzuhPmJ04LLgZyU2YOf7xuBxmSK6yvH78YqTWH0r27H6oOJH
         yrYEYWj32AO+CZ6Z7l0zxsRbvdoBShT+Gfp2QN6C74KQjkU4Ne3lFuf4YK/lfUf7njMv
         oFgCZuDfvId2l6tuq9gVCD0F0AGi+qSyF58PTSAwN0S8Bp7DnwvFntP1TV238mSxMUJ/
         WnhGW+ssos3/+UI9o2vFOqpc8SAG9J7JU+e9fIZZf6ipZLcjuJABTgzjKH/U79/q6qC1
         TzRiXGOKyjtc6ERpDklDAVRtC3IZRwdZI/COQp4wg0SxXKHjfsyPEUhF68+GHLQWtskC
         I+AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nwpocxihxhtiQrwyCJLazLY71myNq6OU53eEZnhHPVM=;
        b=OPSXj0ZomgEnGcUDuzowYFXsNzt0unienZrOxapc8eddtin14hgDgPvy6PeZbb3vfm
         Tm9b7zX1+9K1Zbb4lV2sst7Bn+jEaecx1QJZOhKpie6X7QPS5dh5UHOGSwjLpPVkmZMU
         MaShcNYDrvcRU+y1rdCzZbHo9w6B1iZ/XEJpykSNRfBy+07zU46TqrDv/Z6Z3E0Yc30e
         rjwdkd5DWDMDKTM1YXx+xD3HXaw6ctDVK+BWsXotXMi4uRRwDJObfj5woarHK2G0oE15
         StuGicBl+oXg48QrA52iJHuPM/zylyv5U84XskzZZOt5iFzr4BzQbYvWwJVsUInyjzDY
         AEpw==
X-Gm-Message-State: ALKqPwe5De3aymC6Xqq5osvZdtRJ6EpIzIDbwPNYgpBee3cHQGwIzh0r
        BSh7xtSKFCNWNcDn9FMr+htH2hLWvO/R46Nl95uBq2ugd08=
X-Google-Smtp-Source: AB8JxZo9Av4OHjkfxneGA0M95i63Gud+ncq7xm7H+EYAPYhJuQwDgsX5i/fkhPboEfE3TTeBgc5Lo5cLkJ/J9TPiuSg=
X-Received: by 2002:a25:6cc2:: with SMTP id h185-v6mr968846ybc.307.1526489794586;
 Wed, 16 May 2018 09:56:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cfd8:0:0:0:0:0 with HTTP; Wed, 16 May 2018 09:56:33
 -0700 (PDT)
In-Reply-To: <20180516015630.661349-8-sandals@crustytoothpaste.net>
References: <20180516015630.661349-1-sandals@crustytoothpaste.net> <20180516015630.661349-8-sandals@crustytoothpaste.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 16 May 2018 09:56:33 -0700
Message-ID: <CAGZ79kZ3UVYgu6xO9OCT9ZZfarhmZ+iG+J0nMNzfnZ_jrnu8ag@mail.gmail.com>
Subject: Re: [PATCH v3 07/28] t1007: annotate with SHA1 prerequisite
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi brian,

On Tue, May 15, 2018 at 6:56 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> Since this is a core test that tests basic functionality, annotate the
> assertions that have dependencies on SHA-1 with the appropriate
> prerequisite.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  t/t1007-hash-object.sh | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
> index 532682f51c..a37753047e 100755
> --- a/t/t1007-hash-object.sh
> +++ b/t/t1007-hash-object.sh
> @@ -9,13 +9,13 @@ echo_without_newline() {
>  }
>
>  test_blob_does_not_exist() {
> -       test_expect_success 'blob does not exist in database' "
> +       test_expect_success SHA1 'blob does not exist in database' "
>                 test_must_fail git cat-file blob $1
>         "
>  }
>
>  test_blob_exists() {
> -       test_expect_success 'blob exists in database' "
> +       test_expect_success SHA1 'blob exists in database' "
>                 git cat-file blob $1
>         "
>  }

For the 2 occurrences above I think the SHA1 requirement is not
needed as the check if a blob exists (and the id is given as $1)
is independent of the hash function, it is just important that
the same hash function is used in the git-cat-file as well as...


> @@ -73,19 +73,19 @@ test_expect_success "Can't use --path with --no-filters" '
>
>  push_repo
>
> -test_expect_success 'hash a file' '
> +test_expect_success SHA1 'hash a file' '
>         test $hello_sha1 = $(git hash-object hello)

... here, where we create the blob to test without
writing it into the object database. In a way we test that
the absence of -w works correctly.

Oh, the $hello_sha1 is hard coded, which is why we
think this test is SHA1 dependent.

But that would fit in line with the test_blob[_does_not]_exist
being independent of the hashes?

Stefan
