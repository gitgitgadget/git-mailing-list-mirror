Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F8252023D
	for <e@80x24.org>; Wed, 22 Feb 2017 18:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933049AbdBVSV6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 13:21:58 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34506 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932394AbdBVSV5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 13:21:57 -0500
Received: by mail-pg0-f67.google.com with SMTP id s67so1451076pgb.1
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 10:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=UEXa9deFGsyG/prwXn0bChbAKoEFnnf7ORAS5+A4mL8=;
        b=T28fwK86UkzENegmsRLMCr348vKfVr5HPlnyPwWEfJ1Rk/EIzEcyJcCjOI3/sojVjt
         n/PLJFg5lWaSvHoHR6+GqnmORW3VeRGKJBqobykmpqC2RAGdg3jpT2cIBMJmhyP1QhZG
         AHfuOJi8ot+1q3Wv26L9xyhuRUu3wt7XEclxs/m6QV0NzVpwLDL6lf685Pubid8t3ytr
         slzeog7lI67TF0VvCxyiBibn8/JZl04Tdkdd1Vs86Gbyg5Na+df4/z7rqrLkxFzX3Gf5
         MzchOOrwCHfiHABkXcnxlUTBkjFLb5JWV+JJkNPr0vaV9oyO9YBjl7hYD53g2jfD39uS
         KFhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=UEXa9deFGsyG/prwXn0bChbAKoEFnnf7ORAS5+A4mL8=;
        b=iAbnIetX1suDSooBLKClblnwK3YYH8rWUQDbUpH60U8L+wAsuXkmp9fHNGkSXOsb4G
         r8Ano2rlypYS09Ehv0OPFo+SvcW1Nmwzsso8z7KFFxnXsn1FyomYzSlOy5HaxtAFp/O9
         s2RRow7Sl9i7MD4f4IqxNOFHW5FYqKcVaRhcyPgYAOAVx//Rjwp2/C5eEHpiJmV86/+e
         OnZmwIBn7YJuiGkJlWmTc/Wx6SsoY6XaJw4iPCKzD01HFl2K5d7+2IBL1V/hNOZC5Jai
         VQSEBFQ2e3bmg6XxOF/HGgy7jTfrCco7jQoKf7OjbuEIcvIUAPn2u0spOETAkQX0O2ZH
         5q3Q==
X-Gm-Message-State: AMke39lyZF6nSThgNprhV0N3Rpxf/zGu6Q2vtTUwv9oIka+TKojCdrw5ROSy/u0K4fVM+w==
X-Received: by 10.84.192.107 with SMTP id b98mr49373177pld.160.1487787716303;
        Wed, 22 Feb 2017 10:21:56 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:21a0:716b:e013:d129])
        by smtp.gmail.com with ESMTPSA id h9sm3804292pfd.103.2017.02.22.10.21.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 22 Feb 2017 10:21:55 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Documentation: use brackets for optional arguments
References: <20170222122546.922199-1-sandals@crustytoothpaste.net>
Date:   Wed, 22 Feb 2017 10:21:54 -0800
In-Reply-To: <20170222122546.922199-1-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Wed, 22 Feb 2017 12:25:46 +0000")
Message-ID: <xmqq37f6cchp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> The documentation for git blame used vertical bars for optional
> arguments to -M and -C, which is unusual and potentially confusing.
> Since most man pages use brackets for optional items, and that's
> consistent with how we document the same options for git diff and
> friends, use brackets here, too.

This seems to date back to April 2007 X-<.

Thanks.

>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  Documentation/blame-options.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
> index 2669b87c9d..dc41957afa 100644
> --- a/Documentation/blame-options.txt
> +++ b/Documentation/blame-options.txt
> @@ -77,7 +77,7 @@ include::line-range-format.txt[]
>  	terminal. Can't use `--progress` together with `--porcelain`
>  	or `--incremental`.
>  
> --M|<num>|::
> +-M[<num>]::
>  	Detect moved or copied lines within a file. When a commit
>  	moves or copies a block of lines (e.g. the original file
>  	has A and then B, and the commit changes it to B and then
> @@ -93,7 +93,7 @@ alphanumeric characters that Git must detect as moving/copying
>  within a file for it to associate those lines with the parent
>  commit. The default value is 20.
>  
> --C|<num>|::
> +-C[<num>]::
>  	In addition to `-M`, detect lines moved or copied from other
>  	files that were modified in the same commit.  This is
>  	useful when you reorganize your program and move code
