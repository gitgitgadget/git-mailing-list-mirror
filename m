Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB7441F464
	for <e@80x24.org>; Thu, 19 Sep 2019 04:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730964AbfISElR (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Sep 2019 00:41:17 -0400
Received: from mail-pg1-f175.google.com ([209.85.215.175]:37305 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729098AbfISElR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Sep 2019 00:41:17 -0400
Received: by mail-pg1-f175.google.com with SMTP id c17so1141317pgg.4
        for <git@vger.kernel.org>; Wed, 18 Sep 2019 21:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m7p2pI9WxiXgH4L8YqNDEyQrG9Kvq2HcdLJO3ZekPZY=;
        b=ii3mkcPXIqhcnUXmB0TQi6zTHBN3kiAYA7CussirTQYukZ5KQncjchd9VHuAdwVezw
         mLfyBP3ia3gx9AhWdUM0ixaDa97svlkxzIYN5JRP6e/t9zqdwWIGEFRx/CZ515lvA8zd
         MGrGWsHMi/PiVowOs/FTWwYgbgJGoF04SvxSJoIPsee1/djErKE5MGyQJxUDJ3VT4f4G
         R8JiDPaJDmW9Uwx3Ty2oZnmtLDLxPf6cYuZxI4BdiWNqoP5nCI8exEBMvaWnFkaFqaoY
         N6C/dctjtXeZoCw3RCd4cTt8Y8wbkEX8FJwxvM/8JVQEOKYjKdzwMrm+3r1LcozGUM00
         89Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m7p2pI9WxiXgH4L8YqNDEyQrG9Kvq2HcdLJO3ZekPZY=;
        b=E6hvuKjWoogs/8hy70OhSxdhV528BSqAqhcWsrrTSikFP7BHxfkTUECnvMRY10Hg0H
         vTq5RIxkv+kjafbxDDOcWOrrUbvSndUzyoV1gI7MQAUd+/bvNf94zYr3xe5EDKESCthA
         Z7MUW2e9yhj/DYQaMldgAFfWgtzmdgy94zRq8vHYo1SP/716RM7QsYE5izHEpHt0jrH8
         ecB1n//b845deigP1ZEVAxuqnbKbO+8vKG/kHtc4pFYYgVC4fvxJFVlqAMwJOnW5df/8
         CdTNGHM1bBaAW1XUjVyoCJIESjDYnCW7B5q5C3FDCkorFya0/dpor91tbMlzo/XFeB8U
         6Sjg==
X-Gm-Message-State: APjAAAUzT8vktXU4XPH/D5T0CPip1DMX9W6irhfLvMHCrbjZavEJNtwx
        kZTa0EfzvRsg2NF8/VKihiVfqZY37gQf6b2mzosefvWQ
X-Google-Smtp-Source: APXvYqyKfLxmbqsv8+2VS3/nQ18OOW3gckxMwL0mz5CKRVfUl3FRVNSbyO6EGq+LIIb4H93a1/VvgA2QXitXLVe0Kk4=
X-Received: by 2002:aa7:8188:: with SMTP id g8mr8067905pfi.88.1568868076996;
 Wed, 18 Sep 2019 21:41:16 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqy2yl44lw.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqy2yl44lw.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 19 Sep 2019 06:41:05 +0200
Message-ID: <CAN0heSrB_eZwRcXkTaNDQR+U1Xp0R_14ke+fAYyVfaV=R3apxQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Sep 2019, #02; Wed, 18)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 19 Sep 2019 at 01:44, Junio C Hamano <gitster@pobox.com> wrote:

> * ma/asciidoctor-refmiscinfo (2019-09-16) 3 commits
>  - doc-diff: replace --cut-header-footer with --cut-footer
>  - asciidoctor-extensions: provide `<refmiscinfo/>`
>  - Doc/Makefile: give mansource/-version/-manual attributes
>
>  Update support for Asciidoctor documentation toolchain.

What you have queued at ma/asciidoctor-refmiscinfo matches the latest
version I posted. Thanks for picking it up.

>  Expecting a reroll.
>  cf. <CAN0heSq9B8NSr7-Bcqpiags6wyMm_3KUGeo+7GZA85nd7GnG=w@mail.gmail.com>

This reference ("please hold off") is from *before* that new version, so
you can drop this reference.

Martin
