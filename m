Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB220C433DB
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 20:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F17A233FC
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 20:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbhAGUiD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 15:38:03 -0500
Received: from mail-ej1-f47.google.com ([209.85.218.47]:44224 "EHLO
        mail-ej1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbhAGUiD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 15:38:03 -0500
Received: by mail-ej1-f47.google.com with SMTP id w1so11443722ejf.11
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 12:37:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nMpmUKd9GmzM4gH77t99fXT8JupLwITW0/tlBy9Z2dg=;
        b=Xl+lFL7h26buk2w6NoGlpBW9HhkpKwG0p3bJ6e2ZulLdue2KVTwoYl9TUkmbOjSk7H
         IL5xadKen4mZwezV21QWvT1sWqXOSybtL2i6p8qx2IVdgLY2p4zf+Fipud/ycHZHcgfH
         XeMC3Lb7EVf5AlshzzsKBa7S2NZp057X+TTvCWiiVIIf/b0jYNCGcYJNfTbkkYSa6rT5
         COUWB2KKhqpo44gDa/lFQyLK5zA1HjPvrRr968vYPqmDuRjEjEVLXOgx08wibzbCu+e8
         UjkRbEHWfEOg/eYz98iSN1RL/P1uaPviD8MwHqemCtbvmS4VtwZ410OYDO4KKrP+8/KH
         jWyQ==
X-Gm-Message-State: AOAM531z7lTPH0dzxwIP8wgaI2qr6mE31zl4azpJFjWiTtN1cTwkWC3e
        jy55HxHqv9etID3I3VvUgXj+kAQKXaDLQuGcdGs=
X-Google-Smtp-Source: ABdhPJyuH9ww1hOM1EpujETefGKkEnhTs+pzSpTlgQQAStzjoPmEqlWdoaUTE5u0S+tEWBqM7raTyznu0y0wysLfAEQ=
X-Received: by 2002:a17:906:6b88:: with SMTP id l8mr435578ejr.482.1610051842069;
 Thu, 07 Jan 2021 12:37:22 -0800 (PST)
MIME-Version: 1.0
References: <20200829153920.17155-1-vvavrychuk@gmail.com> <274475559a6de9c95c9c6cd30b5d056a31cc2853.1610017875.git.liu.denton@gmail.com>
In-Reply-To: <274475559a6de9c95c9c6cd30b5d056a31cc2853.1610017875.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 7 Jan 2021 15:37:11 -0500
Message-ID: <CAPig+cSG0WMs2TRVDOWxSsoRD2Qo_+kGm2QTGgQC+sLjyGZ9ow@mail.gmail.com>
Subject: Re: [PATCH v3] git-send-email.txt: mention less secure app access
 with Gmail
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Vasyl Vavrychuk <vvavrychuk@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 7, 2021 at 6:12 AM Denton Liu <liu.denton@gmail.com> wrote:
> Google may have changed Gmail security and now less secure app access
> needs to be explicitly enabled if two-factor authentication is not in
> place, otherwise send-email fails with:
>
>         5.7.8 Username and Password not accepted. Learn more at
>         5.7.8  https://support.google.com/mail/?p=BadCredentials
>
> Document steps required to make this work.
>
> Original-patch-by: Vasyl Vavrychuk <vvavrychuk@gmail.com>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>

Thanks for picking this up.

Has this version changed in any substantial way from Vasyl's v2[1]? If
not, perhaps it makes sense to retain his authorship and sign-off.

[1]: https://lore.kernel.org/git/20200829153920.17155-1-vvavrychuk@gmail.com/
