Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0C0320401
	for <e@80x24.org>; Wed, 21 Jun 2017 16:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753144AbdFUQeX (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 12:34:23 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35195 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752757AbdFUQeT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 12:34:19 -0400
Received: by mail-pf0-f196.google.com with SMTP id s66so31680367pfs.2
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 09:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=SmiZb5voKRaQIaguReS/9anM1HxTS1hUlR0/31F7lEM=;
        b=Z+hiIaD+XEDhr9LnrsT3GbJ0O8vNBaFGfWT40wfsaG9P9tvVHZWqzwdIinGouAeCc0
         SGPdNxaOxQw3fJYdtg7tFsc1pVdUpm9WRHWJSbmZGhiL2oZFfrngwJHwoyza2xXvdG9n
         xz4NubFX2UocIsqu5iT5SS5bKW7BDeG2gyXS3laA2KQ7P1Ivs9vdcsqXFGVBYma9jcnd
         lLY6YBIXTzS0t7C3qDB+aukT34ypfQosZZ8qqS/F1s37aSOf5cJV1LLgDGo9Zqb4666E
         j1m9H8TvOQ/Nc+TLFUQvC6W3uai9C81/h1Eq6XVs61B1uxC9TBY7Lkggc1CZh4u72HN0
         vkBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=SmiZb5voKRaQIaguReS/9anM1HxTS1hUlR0/31F7lEM=;
        b=sgWKSpEH403PSi4CRqDXk9LIEpCF57j+4hDH++ku0ne0m/CvCmQ5LkzSYiWWbrJCoa
         4HUa3RUZNQS/yZcr56y9Shhk5UC22uOZBI/UIrqi7gzP3ZRgGAVFXPbF5FBY9AW2lS7g
         s6HlFjAz+ECHSjAxzHJI/Y+hdba/rLP6zY82/5hVQELUCLaXk8I/rR8Xt0FvHbmmBdW5
         NRXRNDSBJI9FtC0IHZJomx/yo0o6yqeLB/5ygmvAsNYICUSCVnN8w5c/SvDoqFLBPT3/
         k1FX0GNLbAcKUPTzxngpQvAvayccGQDjjiqrD9fCqI9GpJX3UcLibbPPFQnbypyT1fY9
         383A==
X-Gm-Message-State: AKS2vOyHBrLz6UD2k8YziRvTbz3MvlkLIR+kqLDrFw9CxqRa5AZkhJnt
        W8xbw42njsTNkg==
X-Received: by 10.99.247.83 with SMTP id f19mr38508574pgk.190.1498062854051;
        Wed, 21 Jun 2017 09:34:14 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b0bd:d7d3:4f2e:5016])
        by smtp.gmail.com with ESMTPSA id x5sm34438724pfi.103.2017.06.21.09.34.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 21 Jun 2017 09:34:13 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com
Subject: Re: [PATCH] status tests: fix a minor indenting issue
References: <1498048305.1746.6.camel@gmail.com>
Date:   Wed, 21 Jun 2017 09:34:12 -0700
In-Reply-To: <1498048305.1746.6.camel@gmail.com> (Kaartic Sivaraam's message
        of "Wed, 21 Jun 2017 18:01:45 +0530")
Message-ID: <xmqqwp85qozf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> Change the indentation from "\t " to "\t". This indenting issue was
> introduced when the test was added in commit
> 1d2f393ac9 ("status/commit: show staged submodules regardless of
> ignore config", 2014-04-05).
>
> Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  t/t7508-status.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t7508-status.sh b/t/t7508-status.sh
> index 5edcc6edf..35ea0b707 100755
> --- a/t/t7508-status.sh
> +++ b/t/t7508-status.sh
> @@ -1494,7 +1494,7 @@ EOF
>  test_expect_success 'git commit -m will commit a staged but ignored
> submodule' '
>  	git commit -uno -m message &&
>  	git status -s --ignore-submodules=dirty >output &&
> -	 test_i18ngrep ! "^M. sm" output &&
> +	test_i18ngrep ! "^M. sm" output &&
>  	git config --remove-section submodule.subname &&
>  	git config -f .gitmodules  --remove-section submodule.subname
>  '
> -- 
> 2.11.0

Your patch is heavily whitespace damaged, line-wrapped and
full of <A0> (nbsp??) bytes as can be seen by downloading from

http://public-inbox.org/git/%3C1498048305.1746.6.camel@gmail.com%3E/raw

I'll hand-tweak to make it apply, so no need to resend but please
make sure you can send your patches cleanly before sending a more
substantial patch.

Thanks.

