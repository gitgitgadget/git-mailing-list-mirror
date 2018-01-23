Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32A7D1F404
	for <e@80x24.org>; Tue, 23 Jan 2018 00:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751321AbeAWAyU (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 19:54:20 -0500
Received: from mail-qt0-f178.google.com ([209.85.216.178]:43494 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751253AbeAWAyT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 19:54:19 -0500
Received: by mail-qt0-f178.google.com with SMTP id s3so25775314qtb.10
        for <git@vger.kernel.org>; Mon, 22 Jan 2018 16:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=C2s2FJGFmcmZKkuFNUG9kVUAU337bxqI7PiHcVVOSdg=;
        b=gKA5ZF3mL0dfBITKMN+0zEwuDtlgt2Zy70YKf7N8NkijZ09V2WvLaHlbTz2vK+ZHiM
         l368L67P97SYSWu7mA79D/tKGP+nJerjGJy6WL+uR8F9sHmcx7uwvoryTfrzFyHm8zDK
         jlgTvfYDPQ5pZWStyP0XlnGTTw4eZaf6qbKDfMQ089mjY25cz+dzo7hBY2CHGOyJGcav
         npHwYBS/Hvw81Sg2IS4VS/0XbdFemaIzAVo/8U92a/4/ErAvTalixn3SyphK98hhQWnD
         8ESoN28rUzeU3Ub54dpi8lfcJ+m+VVDntALbIumEnXf2PDJgPsREkKxJYIZ3Zd+KSNO/
         w3mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=C2s2FJGFmcmZKkuFNUG9kVUAU337bxqI7PiHcVVOSdg=;
        b=VoRN2KXqKpMsMRTHEkcjZA72+YWdMNsUD/iCBFgX7LaG0dd1KU2lm7RhFI+YqPbswW
         7HRTJGSZYtd0KqhL1cvtj/zQLn1jLiJULTKaHlQa758G9k006iaC97fBTH9wY6WgGpZ/
         CtSOgg2lKxhOCnhKYMDvwzYA32aTEFDK/p+IB5eV9UIgD4vKRRexH1/XAOMo25qywZJq
         nRrC50iDlZc5OGqs8CCWU3d1u7lfJRhlA7oNL2qJ2e74WilIAX1ewg44BmsT/7DakYJm
         b0CkLuAjZqyFyFscM1wQZqKhmDNClX3PufTbNmeURbEuKfh/ubxvrBvTF9x6rv6k/IHH
         h0XA==
X-Gm-Message-State: AKwxytf8b4EDyKuVWa5HCrOTSLYIG7IA23kFTJ8YMQUKJgK210N8ChA1
        9KRRa59FMhsZMUiQ0EY/PJmGIjOaC4eOjaAj/MM=
X-Google-Smtp-Source: AH8x224a9OtaTXvJjxv94l46EJvbPXw5zXtmnRBSRCBz4K3mH+zcg6wrxkSgxC5ZjVv+BsxzBIFdoQhFczq8kJ8AmDY=
X-Received: by 10.200.15.218 with SMTP id f26mr1126404qtk.237.1516668858938;
 Mon, 22 Jan 2018 16:54:18 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Mon, 22 Jan 2018 16:54:18 -0800 (PST)
In-Reply-To: <1516665078-107974-1-git-send-email-gitter.spiros@gmail.com>
References: <1516665078-107974-1-git-send-email-gitter.spiros@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 22 Jan 2018 19:54:18 -0500
X-Google-Sender-Auth: tMTN1yDWMSxANaJxfjD0tEz8wMo
Message-ID: <CAPig+cSuBRcM7BBw1MKOOVSZv+CVVrY-dWfSGj+31DA4QMrruA@mail.gmail.com>
Subject: Re: [PATCH] Fixes compile warning with -Wimplicit-fallthrough CFLAGS
To:     Elia Pinto <gitter.spiros@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 22, 2018 at 6:51 PM, Elia Pinto <gitter.spiros@gmail.com> wrote:
> This patch add explicit fallthrough compiler attribute
> when needed on switch case statement eliminating
> the compile warning [-Werror=implicit-fallthrough=].
> It does this by means of a macro that takes into account
> the versions of the compilers that include that attribute.
> [...]
> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> ---
> diff --git a/convert.c b/convert.c
> @@ -1554,7 +1554,7 @@ static int ident_filter_fn(struct stream_filter *filter,
>                 switch (ident->state) {
>                 default:
>                         strbuf_add(&ident->left, head, ident->state);
> -                       /* fallthrough */
> +                       GIT_FALLTHROUGH;
>                 case IDENT_SKIPPING:
>                         /* fallthrough */

Why doesn't this /* fallthrough */ deserve the same treatment?

>                 case IDENT_DRAINING:
