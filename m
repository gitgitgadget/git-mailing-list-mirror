Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E8E41F89C
	for <e@80x24.org>; Mon, 16 Jan 2017 04:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750893AbdAPEFu (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Jan 2017 23:05:50 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36732 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750839AbdAPEFs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2017 23:05:48 -0500
Received: by mail-lf0-f67.google.com with SMTP id h65so11008283lfi.3;
        Sun, 15 Jan 2017 20:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Mv4s8elhdN/ZtSDD3YlR7R5R35LuLLGHjMW3ZXMTK+g=;
        b=I6VQ5NHJFlgIM7DF/85WJitieA3aNk7DuiUqQ4j6DH4us5tHa7TnGyIWb7kuqNzZkB
         HZ+2M3cjpAROUj6frHzhiwc1yjhrR6+xDo3u2FTPLqj3U7iQ49OA5BZYSldBQv8G48iL
         us5L0PSK9g+ObY9m0N+b2Ry7XJ1DS2zRmrvayvVJA3CNYQtppKUhvT143SP2X2BbmB/b
         7UK0NDfD4uXkIYlsmUAPIE1LqrYox6+t8Z99a28QJNQyJGYkyI7kYvsbJoIqZOnCfx1s
         fVHDRokeFJ5PNsEyRaVIZBraa6q+2Q82HfdQ3cnYbpIESOtQ4Ixs77WhRbswenovO7jR
         cExg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Mv4s8elhdN/ZtSDD3YlR7R5R35LuLLGHjMW3ZXMTK+g=;
        b=SttrSdZW+S0DaBmu416ae46CRCJP7kOgIJICietUoQhQyEgbJ7dprSOEkBuzxkWXvX
         lDvoR5cWuRTAOjMjf2JW/FT7Kk66fWW1bfHu/4x+lWzHoZ+0b56fbhLBmwJPHYETfE42
         Rgj8gXfG0vRzQSXm6ifDpbDR9VCqzWtE+RxAqBhaOPlMDNLKA0s9FUuCCZDCE6zTyHT8
         wKhJOft+OwpTyo1qmqS0WajEg4b/IX1x8LQoJ7JbyOGLkOo3K3EfRrk6/8RSpQpoeLvy
         KhQpwAkhcoyj/247f3vP6wGNirD+0SqCf6FF7joWX9+z0C+z7J3M0hEm/sv8v6VTClKZ
         aJPw==
X-Gm-Message-State: AIkVDXJlGz8CmlYEjjBi5AWuazSXej4qEEmMv5ulH4+isnyhA9Q2R21b0h73lcuIFE5vmtFoj5kVa7lzGMRbiQ==
X-Received: by 10.25.75.79 with SMTP id y76mr8297040lfa.143.1484539546924;
 Sun, 15 Jan 2017 20:05:46 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.14 with HTTP; Sun, 15 Jan 2017 20:05:26 -0800 (PST)
In-Reply-To: <xmqqlgubc04z.fsf@gitster.mtv.corp.google.com>
References: <20170115183051.3565-1-wsa@the-dreams.de> <xmqqlgubc04z.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sun, 15 Jan 2017 20:05:26 -0800
Message-ID: <CA+P7+xojtk4QD2rtAy90ytHCpuaSAOy2SE-aXC4A863N020Efw@mail.gmail.com>
Subject: Re: [RFC for GIT] pull-request: add praise to people doing QA
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Git mailing list <git@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 15, 2017 at 4:35 PM, Junio C Hamano <gitster@pobox.com> wrote:
> As to the implementation, I am wondering if we can make this somehow
> work well with the "trailers" code we already have, instead of
> inventing yet another parser of trailers.
>
> In its current shape, "interpret-trailers" focuses on "editing" an
> existing commit log message to tweak the trailer lines.  That mode
> of operation would help amending and rebasing, and to do that it
> needs to parse the commit log message, identify trailer blocks,
> parse out each trailer lines, etc.
>
> There is no fundamental reason why its output must be an edited
> original commit log message---it should be usable as a filter that
> picks trailer lines of the selected trailer type, like "Tested-By",
> etc.

I have been looking at ways to use the interpret-trailers as a way to
filter commits and print out trailers, and this sort of feature would
be useful to me if it were generic. (and then pull-request could use
the generic interface to grab the data and then parse it into a praise
format)

Thanks,
Jake
