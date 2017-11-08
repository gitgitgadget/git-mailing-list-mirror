Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9F251F43C
	for <e@80x24.org>; Wed,  8 Nov 2017 14:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752628AbdKHOK3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Nov 2017 09:10:29 -0500
Received: from mail-qt0-f175.google.com ([209.85.216.175]:50419 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752627AbdKHOK2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Nov 2017 09:10:28 -0500
Received: by mail-qt0-f175.google.com with SMTP id d9so3421398qtd.7
        for <git@vger.kernel.org>; Wed, 08 Nov 2017 06:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=cNJnl9xSzPU1wAA6gwX+5/uyi23dbvIE5zP/iV3h5/w=;
        b=J1n1qfVKHOUauXO1bU9af53U5xykty0qxFgXxcbF3GrAJnzTU4xGdVYcFl5iispfK/
         HhGJf8C8A0lPL56i/4r6y0llXaQsyMt4Wqx0Hp0EmPGdoBvHyVUIO5RxFMiS8+kIurfq
         gu6ax+iimRr+BAgs12Hewrwly/AJS2o3eaqbGXAO6eGMnG2bmdptiHFbcFsmJuEzn2RR
         cEXYJeQaDE09I5JSh2ufo/g10WAe2GmA2sUBKC9nb5pS0MXvPpM+1ZBjQ6aA968xAcwO
         BdwCf8wFX8Kre/9UE/Wac6CEKgUm3//BdwcMU+FYlGSm6xdNqBbTS2YHw3UpJb8SwAMT
         jvgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=cNJnl9xSzPU1wAA6gwX+5/uyi23dbvIE5zP/iV3h5/w=;
        b=VOiUD08OLYJ1ylpPxF5RtgNNo2S+PsHEXoJfHkiguC8dU1JGDpYQbnURYt1sr4h6LJ
         whnFTiOMqPmQSpil8vHlT5U2KjDlk4mm8wC9OxJtsPHWah6lmpsjktPNKBvvXGFjmuiO
         H5AT7p+CyFNYDiISlbIjFAAmJ1aJnvv2zMkUqzRWWJ0QRHH+HfmHKah9zcDSC+nOCxEJ
         LQCHXYrnW2ZC0caybvOqsNJ886JhQ5TaNTm7517PcZ07fLl8Sh2IrmjM7FOlEdzlzvoV
         8PGLgT6U2+Av5ANQ7UDha5ymcRrN9wlAD7LXxjO5jWt0a2DOdzK4uDUGKVt0u3Zfni3g
         ZMLA==
X-Gm-Message-State: AJaThX6YqwZaTCDz3AyFxZrKi0do1s6rokmoC+zC//QeXfaf+O7LQVU9
        jrJb2rkSL+0+49yTUHhfszZ3B6qACvaiHq61vJQ=
X-Google-Smtp-Source: ABhQp+TMdyOX7qu2luxsxe7zxRJ/AyFzuvsA5Pa7MA8Mvtz3U+LmA0q4w/gmF6jk1wciS+X1v5K+2q9I1Ft719S7srM=
X-Received: by 10.200.53.12 with SMTP id y12mr1053710qtb.84.1510150227590;
 Wed, 08 Nov 2017 06:10:27 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.146.118 with HTTP; Wed, 8 Nov 2017 06:10:27 -0800 (PST)
In-Reply-To: <20171108134752.214056-1-adam@dinwoodie.org>
References: <20171108131601.280992-1-adam@dinwoodie.org> <20171108134752.214056-1-adam@dinwoodie.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 8 Nov 2017 09:10:27 -0500
X-Google-Sender-Auth: qIgGfS49a3-IgQZTWpih6aJ8AF0
Message-ID: <CAPig+cRaygrQ9_J1UHr_rynPsUn2J0--RHRvP2mFQbVQhWEm-Q@mail.gmail.com>
Subject: Re: [PATCH v2] doc/SubmittingPatches: correct subject guidance
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Josh Triplett <josh@joshtriplett.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 8, 2017 at 8:47 AM, Adam Dinwoodie <adam@dinwoodie.org> wrote:
> The examples and common practice for adding markers such as "RFC" or
> "v2" to the subject of patch emails is to have them within the same
> brackets as the "PATCH" text, not after the closing bracket.  Further,
> the practice of `git format-patch` and the like, as well as what appears
> to be the more common pratice on the mailing list, is to use "[RFC
> PATCH]", not "[PATCH/RFC]".
>
> Update the SubmittingPatches article to match.
>
> Signed-off-by: Adam Dinwoodie <adam@dinwoodie.org>
> ---
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> @@ -184,12 +184,14 @@ lose tabs that way if you are not careful.
>  It is a common convention to prefix your subject line with
>  [PATCH].  This lets people easily distinguish patches from other
> -e-mail discussions.  Use of additional markers after PATCH and
> -the closing bracket to mark the nature of the patch is also
> -encouraged.  E.g. [PATCH/RFC] is often used when the patch is
> -not ready to be applied but it is for discussion, [PATCH v2],
> -[PATCH v3] etc. are often seen when you are sending an update to
> -what you have previously sent.
> +e-mail discussions.  Use of markers in addition to PATCH within
> +the brackets to describe the nature of the patch is also
> +encouraged.  E.g. [RFC PATCH] is often used when the patch is not
> +ready to be applied but it is for discussion, and can be added
> +with the `--rfc` argument to `git format-patch` or `git
> +send-email`, while [PATCH v2], [PATCH v3] etc.  are often seen

It has become a bit of a run-on sentence, but aside from that and the
unnecessary extra whitespace between "etc." and "are", it looks good
to me.

> +when you are sending an update to what you have previously sent,
> +and can be added with the `-v <n>` arguments to the same commands.
