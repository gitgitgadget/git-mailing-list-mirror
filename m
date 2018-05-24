Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE6ED1F42D
	for <e@80x24.org>; Thu, 24 May 2018 20:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935779AbeEXUF7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 16:05:59 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33937 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935330AbeEXUF6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 16:05:58 -0400
Received: by mail-qk0-f193.google.com with SMTP id p186-v6so2339037qkd.1
        for <git@vger.kernel.org>; Thu, 24 May 2018 13:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=fofWNZRwSiZr9M6HxXcO4YWuAAgwxM2B1IQpklj4gf4=;
        b=f2WfjOwYBbZ+jYGIcIEP28CN1hqvO+Dt/MsDRSwC2xCQuTd2avDmpZ6Tkp/1gR0SW0
         vQYtdhaA8CRTWUUdjCgei7PfVhzGW21xBkWyciYPGbDGsdTFP5gFXv6QEkSVKUy0RdqA
         rtw5fvIOWRDYVCIqb869bG8Zhc+7zYRBVGYsAwB6CgfhMU+06i7U22bqPV2lwtnwDwSG
         62sLyxpUflvDxVw1onhX40kj39DOc6gquu6ifXUo1LmioBrseL0GvwM1c6pP4J2plDbL
         bpzV8n8e1imewubTwNHtUPOEeG1Xqek0R4j6Q4Z31eQDcnoQg5mq5dFw7XdK88YQLUNY
         F7fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=fofWNZRwSiZr9M6HxXcO4YWuAAgwxM2B1IQpklj4gf4=;
        b=h4+IEg91WYfiWrq57PP4JqH2Q5VrdCyE7YfBt6ofVAADc9v4SzNAqcXEmdBN3XzW09
         rqSztc1q+qAUwIeZWXvpgPbBo4E+GaBwJgeuLjju15IqiQb90iT6Rrq3xTYOtAsmb4sc
         nE2u1Uu0gAP5w0uBR1me2HSNPsF0paJKujY6Y7wUQCkpE2jyTRlJR2ucEG/GB9LhtjKM
         JTfTsFFJ8WRFLsn0ZpdOipALHbnPSh+ncOLrBZYYEPXY7uad4f0KVyKqeC/Fh0ayh53M
         kvlIOfQsTRXHtxgYzD0uLXa6ETAZ45wWfabJnh0rzRbO3UbueZHpSDw8mteFkH4esFBw
         OStA==
X-Gm-Message-State: ALKqPwfqlEDb+pwceJFg5CFV/JfBpNwHtb/qUplzgLiuCYgvuYiWROdL
        8n3n+HaIO0fXEfc4sVqbn0mFwrwAudYwfDuMiS8=
X-Google-Smtp-Source: ADUXVKLuxFMUehXpRgOop7/iZNld07urrHLwc8YUTzUrf3hUT+8o7Wzyl2FsFnwV9JPr1otWZwSp1vkQga4iwx5r7gI=
X-Received: by 2002:a37:71c7:: with SMTP id m190-v6mr7901923qkc.91.1527192358100;
 Thu, 24 May 2018 13:05:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:aa4b:0:0:0:0:0 with HTTP; Thu, 24 May 2018 13:05:57
 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.21.1805241552080.6217@localhost.localdomain>
References: <alpine.LFD.2.21.1805241552080.6217@localhost.localdomain>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 24 May 2018 16:05:57 -0400
X-Google-Sender-Auth: 6bOaX6UJMHZLmj3Eb1ebhObb_GM
Message-ID: <CAPig+cR91cEj1EdA4JvQQED0HJ2Db-LyrWCB_8VdC6uwT47KbA@mail.gmail.com>
Subject: Re: [PATCH] Use proper syntax for replaceables in command docs
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 24, 2018 at 3:54 PM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
> The standard for command documentation synopses appears to be:
>
>   [...] means optional
>   <...> means replaceable
>   [<...>] means both optional and replaceable
>
> So fix a number of doc pages that use incorrect variations of the
> above.
>
> Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
> ---
> diff --git a/Documentation/git-check-attr.txt b/Documentation/git-check-attr.txt
> @@ -9,7 +9,7 @@ git-check-attr - Display gitattributes information
> -'git check-attr' [-a | --all | attr...] [--] pathname...
> +'git check-attr' [-a | --all | attr...] [--] <pathname>...
>  'git check-attr' --stdin [-z] [-a | --all | attr...]

Don't you also want "<attr>"?

> diff --git a/Documentation/git-check-ignore.txt b/Documentation/git-check-ignore.txt
> @@ -9,8 +9,8 @@ git-check-ignore - Debug gitignore / exclude files
> -'git check-ignore' [options] pathname...
> +'git check-ignore' [<options>] <paths>...

Earlier in the patch, you changed "pathname" to "<pathname>", but here
you change "pathname" to "<paths>", which is inconsistent.

It's also inconsistent and odd to say "<paths>..." (with the "...").
Seems better just to say "<pathname>..." to match existing practice.
