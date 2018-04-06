Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A1971F424
	for <e@80x24.org>; Fri,  6 Apr 2018 10:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751494AbeDFKuZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 06:50:25 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:34312 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751434AbeDFKuY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 06:50:24 -0400
Received: by mail-qk0-f177.google.com with SMTP id g7so641270qkm.1
        for <git@vger.kernel.org>; Fri, 06 Apr 2018 03:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=A/i/AzRfx4citoJSHojqQB86IGe1lrZ2KVnLEEfhehA=;
        b=OTjVX5qeR/UCTRrbuP0ZEd7Ih09h3LjtICws7ZDQDCApxVowaJVTu4SZ7jU5yeb9kK
         SkSNvBtG5SmfuaEtaVBf6h0d2bGXj36sgYRIE3MZKSIXGmKDDnobtfSc1X3iHUvz2hJp
         pANs3MJsYJTlV2CgE1YbOimbCJQeE+DurRvDBsMI3H38tUw38+1J3nBn8Qgf+1pw5T7v
         jgYYVfrV1qUuNDjWcumYXFPgNw746YblymprV9Wum3wUSLu4vhYUnrpo+le4TlS1sSYK
         4MgIXQpT7n6mjEomS2/uTqUjHMx2kJlcXL2OW12VcoEuRkvKkf1u4d/ug/VOOjNisj1M
         Ia7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=A/i/AzRfx4citoJSHojqQB86IGe1lrZ2KVnLEEfhehA=;
        b=AV5+xf8O9eEfsTI31ruZ7lUrlZWaxN2y9X/i4wqfZ8o00PUOgYmHrPBbMUC3PZJB4T
         Kyh89dbzK13YdKD7Uab1csSnU1aPrHVjVC2YfXwNVLQQso/C7Ge0Acr338NJhn8WXtsX
         SOT+nLV5rwjEoy73fq4LRyMprlPl7P1QDP6+xdpL8qvDNlYSEbNtLrOgawNzp69Xx2JU
         30f56LHuELEuM+P5sKnKhvzhNTLRAy+q/3i/EG7D/nTzLD3tdGNKEJQivvucMvAWgzMD
         mQfiyh+X7O2KLzRZT52VWds89CkvopsZAwq1/I4Bl4j2FxUn9mk8ZkPfjRM9ANtDnpqp
         7BOA==
X-Gm-Message-State: ALQs6tD5FmmiHXGM7EpSuWHGWdkE3fXuoRmLmDnSbuuSiGrq7YCYtKBv
        cIp/qFc0ILRImF30dyja+ttctZ3oEhmdbpgVsnw=
X-Google-Smtp-Source: AIpwx497Auyw0YtRNueo0ynVfU5YbgGY4brKiQRRQ6Ch5e9hJMWAuHMY89XjW89YybIyteeVgw1156C+xpzz/OgIVVo=
X-Received: by 10.55.108.69 with SMTP id h66mr34753411qkc.42.1523011823496;
 Fri, 06 Apr 2018 03:50:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Fri, 6 Apr 2018 03:50:22 -0700 (PDT)
In-Reply-To: <021133cae0d27359a5e3ee520fc26f58b7030f59.1522968472.git.johannes.schindelin@gmx.de>
References: <cover.1518783709.git.johannes.schindelin@gmx.de>
 <cover.1522968472.git.johannes.schindelin@gmx.de> <021133cae0d27359a5e3ee520fc26f58b7030f59.1522968472.git.johannes.schindelin@gmx.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 6 Apr 2018 06:50:22 -0400
X-Google-Sender-Auth: -UHhBU4ESOCzPZqiEpqpzfVYJcQ
Message-ID: <CAPig+cRL1t78W+58HnN3bFJhZa7b9iu=vQxfAq=rF79p1NgeHw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] Add a test to verify that push errors are colorful
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 5, 2018 at 6:48 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> This actually only tests whether the push errors/hints are colored if
> the respective color.* config settings are `always`, but in the regular
> case they default to `auto` (in which case we color the messages when
> stderr is connected to an interactive terminal), therefore these tests
> should suffice.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
> @@ -377,5 +377,23 @@ test_expect_success 'push status output scrubs password' '
> +test_expect_success 'colorize errors/hints' '
> +       cd "$ROOT_PATH"/test_repo_clone &&
> +       cat >exp <<-EOF &&
> +       To http://127.0.0.1:$LIB_HTTPD_PORT/smart/test_repo.git
> +        <RED>! [rejected]       <RESET> origin/master^ -> master (non-fast-forward)
> +       error: failed to push some refs to '\''http://127.0.0.1:$LIB_HTTPD_PORT/smart/test_repo.git'\''
> +       EOF

This "exp" file is not used by the test.

> +       test_must_fail git -c color.transport=always -c color.advice=always \
> +               -c color.push=always \
> +               push origin origin/master^:master 2>act &&
> +       test_decode_color <act >decoded &&
> +       test_i18ngrep "<RED>.*rejected.*<RESET>" decoded &&
> +       test_i18ngrep "<RED>error: failed to push some refs" decoded &&
> +       test_i18ngrep "<YELLOW>hint: " decoded &&
> +       test_i18ngrep ! "^hint: " decoded
> +'
