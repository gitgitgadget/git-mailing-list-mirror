Return-Path: <SRS0=9JxE=D5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292F5C388F2
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 06:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C84602245F
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 06:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503256AbgJVGEQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Oct 2020 02:04:16 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44248 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503237AbgJVGEQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Oct 2020 02:04:16 -0400
Received: by mail-lf1-f68.google.com with SMTP id b1so712886lfp.11
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 23:04:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Eg2++a/rHZ2208Yt8ORKvbr554rKmbipE4DX73/zRpE=;
        b=LenkVRzH3ZP1GACUxSsK1XLtoJrIJDlHgPg3opfaVfqT655N70UHnHXQCedo7r6JNF
         1q3DBegPuYld6g+TJZ4EKf9u8PQwTv3CsK0PX16KMM4l9kAGEhkS3MzrvP3BT3roMoEG
         c3wP32NN4SNJY/k569XcsV+2y/dYiXSWvkStQZSBx+l3T0Gh5fjMxcJbH/LbiCOW/Fvd
         WFLcbPfmSHgTVV8KABUMXoz1bCugddfI3An0n9/GoJlahhbmDABylvNw+6R6j9veGfjr
         N7F6QTVIhImMJooe2sS+DPDJij2QyqCqKWaQA4OllEamB2X+MzopWxyNxsv/sjugP/lO
         jiig==
X-Gm-Message-State: AOAM5313/JVUFAI9QP5BOe9z6zSt6IWfDVESv3rkBYMUqp5j94uIGIFL
        cEGB9nwe0EQf8cmQGJxOQCrk4AXLgwlQEjlxpSQ=
X-Google-Smtp-Source: ABdhPJxBhDCXu+uHD1lr1HqdH648ZzHa1jQiMAqnmSPH4Y26eHmmEEt2/hqs1pBfVBbBITrNb4JkHYU6zH8oILAbg5Q=
X-Received: by 2002:a05:6512:3455:: with SMTP id j21mr316459lfr.135.1603346652969;
 Wed, 21 Oct 2020 23:04:12 -0700 (PDT)
MIME-Version: 1.0
References: <20201020121152.21645-1-charvi077@gmail.com> <20201021124823.2217-1-charvi077@gmail.com>
 <20201021124823.2217-4-charvi077@gmail.com> <CAPig+cRzLpY4Pe11SQ0uux-_+x_CSVYM1FvRvDebH3TNi-bVow@mail.gmail.com>
 <xmqq36264xx5.fsf@gitster.c.googlers.com> <xmqqh7qmolch.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqh7qmolch.fsf@gitster.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 22 Oct 2020 02:04:01 -0400
Message-ID: <CAPig+cSL-9o=c=iYtvHNDZmtRVoy2=EED1RdoX2Tsjnm3ioevQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/5][Outreachy] t7102,t7201: remove whitespace after
 redirect operator
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Charvi Mendiratta <charvi077@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 22, 2020 at 1:56 AM Junio C Hamano <gitster@pobox.com> wrote:
> Subject: t7102: prepare expected output inside test_expect_* block
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> diff --git c/t/t7102-reset.sh w/t/t7102-reset.sh
> @@ -82,15 +82,15 @@ test_expect_success 'reset --hard message (ISO8859-1 logoutputencoding)' '
> ->.diff_expect
> ->.cached_expect
> -cat >.cat_expect <<EOF
> -secondfile:
> -EOF
> -
>  test_expect_success 'giving a non existing revision should fail' '
> +       >.diff_expect &&
> +       >.cached_expect &&
> +       cat >.cat_expect <<-\EOF &&
> +       secondfile:
> +       EOF

You used <<-\EOF rather than plain <<-EOF when possible. Good.

(Might be worth mention in the commit message, but perhaps too minor?)

> @@ -191,38 +191,38 @@ test_expect_success 'resetting to HEAD with no changes should succeed and do not
>  test_expect_success '--soft reset only should show changes in diff --cached' '
> +       >.diff_expect &&
> +       cat >.cached_expect <<-EOF &&
> +       diff --git a/secondfile b/secondfile
> +       index $head5p1s..$head5s 100644

And used plain <<-EOF when necessary. Fine.
