Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B56A1F453
	for <e@80x24.org>; Thu, 18 Oct 2018 15:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbeJRXuW (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 19:50:22 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:53671 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728307AbeJRXuV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 19:50:21 -0400
Received: by mail-it1-f193.google.com with SMTP id q70-v6so882840itb.3
        for <git@vger.kernel.org>; Thu, 18 Oct 2018 08:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a7uFnOjRQamJo0F9vDTf7dPHZ7ch2RXRogkwh4uAnEg=;
        b=I/eLioJVcKql3MmCbes7zK3aoPtOL+jxpWw00maZD7hKQuIm+D6GeRRRDtqZxpndX2
         tM2UR3udSPALoR1Qipwc+FxvmnFMZdr9l1qWdwglH3mnjGtBmxxmJnh//38gso3tLxfW
         NvOVGtUW8uGG9SDcsGpFfiIEGKkyEQi+LkLR7L8LWxFRRMLLVO4QqD3jD0ZLVskdnHr2
         7+XHmZNX69WYyI1WCkBOPognefrR/z1q/g9hJgpFhmIUYTjhJ6/wRnz0aMnmprYwXvsc
         GCv3dZVDjLJHtwfECXvY7STzijLE1/qwHxPklm7zB83fU4nYsIMd1NMCYVklxoXPJmXi
         vebA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a7uFnOjRQamJo0F9vDTf7dPHZ7ch2RXRogkwh4uAnEg=;
        b=ZHxZvzBT13fXMp7C2K16E6ENpE0Jj+mRE09iGk+1fOKZqlQxwVPpHmTQk2kmYrq8Y7
         Qm4ri8X4XTbcOOVoOzCMBRTCdEyFvWL4587rZ2dacCSTWeH9i73ruBkvrAE9ZjZHbU33
         WyyDQFpM512oG0ROBExNJ4FwDH/wIoJgTDAvoybqdWF0gGz3Nt9epHO7NlyjmtKKgXFo
         eJ23zrY+b24wJ+9P5RbAXK9WWZvEwMCGN7zstqltPXzH+HB3QnyRfWw6u+XrXXg0lZHn
         yRA+occbfmIQXil8cpNafNYYx1OkqDKAQt+cmz1Fptz8PcDg0b0j2Hn8ZkVu+p9uyoOc
         aRVA==
X-Gm-Message-State: ABuFfogLkgt8lRiXdEcjfei3uSgXWU+vH1tpho3IY13x4azpHf1UHeiw
        4K8YLN/CJQbb7GtDGUpxWOyhy3YsN0WQ+6USpPM6xlVx
X-Google-Smtp-Source: ACcGV61nr7+ajidgKPKUlLnCPK0NoNxRtnhSyYZcm/7Td61XaAqshECYxqNv0BHE5F9k4W6a3VERQ+pDIbNLWfM5GUY=
X-Received: by 2002:a24:7804:: with SMTP id p4-v6mr620873itc.123.1539877724889;
 Thu, 18 Oct 2018 08:48:44 -0700 (PDT)
MIME-Version: 1.0
References: <20181018070522.GA29499@sigill.intra.peff.net>
In-Reply-To: <20181018070522.GA29499@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 18 Oct 2018 17:48:16 +0200
Message-ID: <CACsJy8BOL+QOb3Vdh8RKbra-DDbJVyznTbCJgjK5h8L2y0H7yg@mail.gmail.com>
Subject: Re: [PATCH] config.mak.dev: enable -Wunused-function
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 18, 2018 at 9:05 AM Jeff King <peff@peff.net> wrote:
>
> We explicitly omitted -Wunused-function when we added
> -Wextra, but there is no need: the current code compiles
> cleanly with it. And it's worth having, since it can let you
> know when there are cascading effects from a cleanup (e.g.,
> deleting one function lets you delete its static helpers).
>
> There are cases where we may need an unused function to
> exist, but we can handle these easily:
>
>   - macro-generated code like commit-slab; there we have the
>     MAYBE_UNUSED annotation to silence the compiler
>
>   - conditional compilation, where we may or may not need a
>     static helper. These generally fall into one of two
>     categories:
>
>       - the call should not be conditional, but rather the
>         function body itself should be (and may just be a
>         no-op on one side of the #if). That keeps the
>         conditional pollution out of the main code.
>
>       - call-chains of static helpers should all be in the
>         same #if block, so they are all-or-nothing

Grouping is not always desired because it could break better function
layout. Have a look at read-cache.c where _ieot_extension functions
are #if'd because the only call sites are from pthread code (#if'd far
away).

In this particular case though I think we should be able to avoid so
much #if if we make a wrapper for pthread api that would return an
error or something when pthread is not available. But similar
situation may happen elsewhere too.

Having said that, if people do consider MAYBE_UNUSED before #if'ing
everywhere (and opening up more conditional build problems in future),
I think this change is fine.
-- 
Duy
