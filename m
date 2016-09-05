Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BE951FBB0
	for <e@80x24.org>; Mon,  5 Sep 2016 13:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932448AbcIENnR (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 09:43:17 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:35194 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752686AbcIENnQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2016 09:43:16 -0400
Received: by mail-it0-f65.google.com with SMTP id c198so8879523ith.2
        for <git@vger.kernel.org>; Mon, 05 Sep 2016 06:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=1R3tZ1lK0uleV94qyCYXG+G56qQG7puqX4kph1hK0Dw=;
        b=V7gjhT8CElDlEKUK0QJB51aPfNVlmYbH5Igi/Hd8MugSxUBficAL5HJO8IcM1Jecvg
         oRGgL1XzZlJ/UA/FAQ6004RndsVmCoNOVq9C/+s1ds4H3AAqifScoCV2i/Q2r9mYfusZ
         anYf5BD11doEVhNgQnLmE7AwNv5dgasO82OCHI4t2LmDSASXvgnkBBUrHdWHN1xVwCSG
         O/qJCc4u3CB1mT4gtOVBIYtOtn8wJTvC99CAtDCsMj2OUIfi8/9LJda/R/6GDoqoMU3Z
         OIi/iPbc5Aa+gv+kG2Dvup3mY047XFOzPUmOkf5j8w2BhYhNMPv2oKJWfAOOOjldf4DN
         zSxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=1R3tZ1lK0uleV94qyCYXG+G56qQG7puqX4kph1hK0Dw=;
        b=XhDdXn3qQTeDP8BNmg4QrUSLGKNuWCWTqXnqNNbYiW4AfljbSNhSqj8V7SWIYMqSeC
         fS35QrusWzaGXabmXt+uwqp3ch919anoKKGYCjxkX+TrxXGGZqtZM3r/7vrxoA9XyRoD
         T244oVIHHBF/GGJW9ve5NBBO5wX9sax0pNI6bGvUbuYgIexHHmsZfC57PS7Hcn9+LCCU
         NJP6L/JtlVl29T/g7l1Yzv1oKU+A9gsI6fkgR66ZFSJ8YDurNUekyV6oukU0CmTP6mDJ
         42kvWFKZ0rejoCmtQmkOZK0q9/PUB6FAtbCRpXMjNJotf89Ai6Yx/aFrTLSBPtQdMA/A
         PZVw==
X-Gm-Message-State: AE9vXwMlfqCRAE0kGfL5U40yN+EvnNWaQmsSy7i0+q9qejJgiCfnw9Ve9BqBfEe0EcafT7qLD/LFGr30cs8YOQ==
X-Received: by 10.36.196.133 with SMTP id v127mr23188501itf.84.1473082995331;
 Mon, 05 Sep 2016 06:43:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.7.213 with HTTP; Mon, 5 Sep 2016 06:43:14 -0700 (PDT)
In-Reply-To: <20160905102444.3586-4-gitter.spiros@gmail.com>
References: <20160905102444.3586-1-gitter.spiros@gmail.com> <20160905102444.3586-4-gitter.spiros@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 5 Sep 2016 09:43:14 -0400
X-Google-Sender-Auth: qlbeMePnblaQj14J7bL4EcJHu4Q
Message-ID: <CAPig+cTsCDpCQ9j82OEa13YBYswDKfYd_dc1QbxRSRk3wiOhHw@mail.gmail.com>
Subject: Re: [PATCH 3/4] t5550-http-fetch-dumb.sh: use the GIT_TRACE_CURL
 environment var
To:     Elia Pinto <gitter.spiros@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 5, 2016 at 6:24 AM, Elia Pinto <gitter.spiros@gmail.com> wrote:
> Use the new GIT_TRACE_CURL environment variable instead
> of the deprecated GIT_CURL_VERBOSE.
>
> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> ---
> diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
> @@ -263,15 +263,18 @@ check_language () {
>                 >expect
>                 ;;
>         ?*)
> -               echo "Accept-Language: $1" >expect
> +               echo "=> Send header: Accept-Language: $1" >expect
>                 ;;
>         esac &&
> -       GIT_CURL_VERBOSE=1 \
> +       GIT_TRACE_CURL=true \
>         LANGUAGE=$2 \
>         git ls-remote "$HTTPD_URL/dumb/repo.git" >output 2>&1 &&
>         tr -d '\015' <output |
>         sort -u |
> -       sed -ne '/^Accept-Language:/ p' >actual &&
> +       sed -ne '/^=> Send header: Accept-Language:/ p' >actual &&
> +       cp expect expect.$$ &&
> +       cp actual actual.$$ &&
> +       cp output output.$$ &&

What are these three cp's about? They don't seem to be related to the
stated changes. Are they leftover debugging gunk?

>         test_cmp expect actual
>  }
>
> @@ -295,8 +298,8 @@ ja;q=0.95, zh;q=0.94, sv;q=0.93, pt;q=0.92, nb;q=0.91, *;q=0.90" \
>  '
>
>  test_expect_success 'git client does not send an empty Accept-Language' '
> -       GIT_CURL_VERBOSE=1 LANGUAGE= git ls-remote "$HTTPD_URL/dumb/repo.git" 2>stderr &&
> -       ! grep "^Accept-Language:" stderr
> +       GIT_TRACE_CURL=true LANGUAGE= git ls-remote "$HTTPD_URL/dumb/repo.git" 2>stderr &&
> +       ! grep "^=> Send header: Accept-Language:" stderr
>  '
>
>  stop_httpd
