Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9273C388F9
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 17:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A5BA208C3
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 17:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503404AbgJURUT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 13:20:19 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:34544 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2443297AbgJURUT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 13:20:19 -0400
Received: by mail-ej1-f65.google.com with SMTP id u8so4397060ejg.1
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 10:20:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+JfTqc1RV1NAehoPWMtM5LmjEZGLHdfcftLHdgRPFCg=;
        b=F08/464UTUKSOyv4PhXzUqVDnDRqhzcjL6hYv2f8Xf8kYdwjmsivovtynYRy185lDo
         dOzuHB4rzQSxcpXJby4gsDmXuDyeKAlxLyBbjQjbVga2Y3Bh0Y6p7+vP760EFHOHOHYU
         bmobkcCarFLJQswqp2FlS6EuCNcZe69GL8cnvdHD5dClSPGXMEhTKZSkKhJlm/3KSZQQ
         HnpktWI5iqkphAy7dQA4csbir1Ui+8Y4zHKK+ahWpIr8oweNHDJErpMeSXb0qMXbey9Q
         KVgrDCKhg88MCtoNC8+c4aBw7Wcb4sEXc8Z8daeUCKb448dP+q/CZZffG875jtgVbSHu
         ZXTw==
X-Gm-Message-State: AOAM531ZTSpohgtFwvKsm9UB0YA+FqYKowqqZAw4SPLYWAe0fiN0LH7f
        JykRAcfdBB2pB3U47OGaxaAZGHLkv504gujKC7g=
X-Google-Smtp-Source: ABdhPJyql0zuEjD8+HRx8zmx86pjImevujduvLTyDQUSv7jah7ERpEkRjR1QOnS67A4+aiwEFD5OY5iF+WBg25nUwj8=
X-Received: by 2002:a17:906:5f96:: with SMTP id a22mr4482184eju.168.1603300817685;
 Wed, 21 Oct 2020 10:20:17 -0700 (PDT)
MIME-Version: 1.0
References: <20201020121152.21645-1-charvi077@gmail.com> <20201021124823.2217-1-charvi077@gmail.com>
 <20201021124823.2217-4-charvi077@gmail.com>
In-Reply-To: <20201021124823.2217-4-charvi077@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 21 Oct 2020 13:20:06 -0400
Message-ID: <CAPig+cRzLpY4Pe11SQ0uux-_+x_CSVYM1FvRvDebH3TNi-bVow@mail.gmail.com>
Subject: Re: [PATCH v5 3/5][Outreachy] t7102,t7201: remove whitespace after
 redirect operator
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 21, 2020 at 8:51 AM Charvi Mendiratta <charvi077@gmail.com> wrote:
> According to Documentation/CodingGuidelines, redirect
> operator is written with space before, but no space
> after them.
>
> Let's remove these whitespaces after redirect operators.
>
> Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
> ---
> diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
> @@ -460,14 +460,14 @@ test_expect_success 'resetting an unmodified path is a no-op' '
> -cat > expect << EOF
> +cat >expect << EOF

There's still a space after the '<<' operator which should be removed:

    cat >expect <<EOF
