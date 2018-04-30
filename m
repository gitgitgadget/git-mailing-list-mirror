Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A18A1F428
	for <e@80x24.org>; Mon, 30 Apr 2018 02:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751447AbeD3CxJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Apr 2018 22:53:09 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:44633 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751343AbeD3CxI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Apr 2018 22:53:08 -0400
Received: by mail-qk0-f171.google.com with SMTP id z8so5698160qki.11
        for <git@vger.kernel.org>; Sun, 29 Apr 2018 19:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=4r04dEOhNerrFRGTofyb6Cz7WzigGJQuIbVncvaZzEo=;
        b=Jt8PR33eUtfb+8al3jprSE3+AH1N79Y4SWuCt3hiodHJGsCINGTM86sy5j+V0F8b5/
         668mtno74G1o6svBOZamkneP7V4g2o5CcwTDu8R+dRTsKK6bttL5ruWM9EHwySgk6UXn
         DYGhoDVSS2UiGVasC9qLktARK1drqvmD2AagC8/PIiP9d/PeszaO3tJsKtuSBMqMA466
         IG1YhMsU1sgPSk73kH5Rw++Od1td3SNiMuPz4KHBVG/XYmUfaIAkH18YYNfhW5n8YJrX
         FV0mwmqdBPFArmbNoHvzAiiFU+/KgxlKxGXKwhh687a0Pfu/AJMue2ggT88GhhOtwjXz
         +hDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=4r04dEOhNerrFRGTofyb6Cz7WzigGJQuIbVncvaZzEo=;
        b=SplRBYKJPeI3TaELjAFl265rqJ4gQpMiDoV8xNayZX3wXd+J/ntNb2F+NpBGz06uDA
         BO7owovjQT3z4Pp7dgjAB5yZr0iINklBsbifvLZXs57Dr0JzbqfBwG1F55BNrx1LGbyl
         dhR8a2vfzlUa7ALs9LdQclhcGOxx+CDdJHCgrJsa2KazcxJa1NaJyV8yWdPz7OM2TKzW
         EpP3z+Dx7/34Kg62huCNoIZLO+dYT1MhsPDMICz/5/trWNVVp1C05vG1NO9cBJmUBfMD
         mRSzSdff2bvIIxoFUpZEYFGLFG+PhfklQoV5XZAC3kYtj+DIjiIK5zMxr/SOuckx0gKv
         i73w==
X-Gm-Message-State: ALQs6tA0J7E1u1rRd1+InPIlmhoXVQDsy4hbNltpv+EkqdHAsPSgxTxR
        jn19xdk8yh0vMHBkyGTwl13gHdfvGQLcMcUOCes=
X-Google-Smtp-Source: AB8JxZq8axc/50AOF5+Uz04ovwPeg8Lir5gqFgPVclRXuGkSFUpRwcEIjSMGdeZWqMj1gmWq4pZez3kj1J7uOR1SBKw=
X-Received: by 10.55.108.198 with SMTP id h189mr94997qkc.2.1525056787405; Sun,
 29 Apr 2018 19:53:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.170.75 with HTTP; Sun, 29 Apr 2018 19:53:06 -0700 (PDT)
In-Reply-To: <0e85c7a16e3767eb03cdce0a7ed75a0c2b77d7d5.1525040254.git.johannes.schindelin@gmx.de>
References: <cover.1525040253.git.johannes.schindelin@gmx.de> <0e85c7a16e3767eb03cdce0a7ed75a0c2b77d7d5.1525040254.git.johannes.schindelin@gmx.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 29 Apr 2018 22:53:06 -0400
X-Google-Sender-Auth: VAkSVZz4jH4Q0jsGw6F3xDgXmGY
Message-ID: <CAPig+cQbze2cZ9bsDC0o+es2j+E7a5qb30xgzT-m7ZNkpMuRDA@mail.gmail.com>
Subject: Re: [PATCH 6/6] Convert remaining die*(BUG) messages
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 29, 2018 at 6:19 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> These were not caught by the previous commit, as they did not match the
> regular expression.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/submodule.c b/submodule.c
> @@ -2043,7 +2043,7 @@ const char *get_superproject_working_tree(void)
>                 if (super_sub_len > cwd_len ||
>                     strcmp(&cwd[cwd_len - super_sub_len], super_sub))
> -                       die (_("BUG: returned path string doesn't match cwd?"));
> +                       BUG("returned path string doesn't match cwd?");

This message used to be localizable but no longer is, which makes
sense since it's not intended as a user-facing error message but
rather is meant for Git developers. Good.
