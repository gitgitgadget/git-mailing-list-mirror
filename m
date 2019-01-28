Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CDF61F453
	for <e@80x24.org>; Mon, 28 Jan 2019 18:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbfA1Saf (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 13:30:35 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51704 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbfA1Saf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 13:30:35 -0500
Received: by mail-wm1-f68.google.com with SMTP id b11so15119127wmj.1
        for <git@vger.kernel.org>; Mon, 28 Jan 2019 10:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=iIygQoY1ZT63BYvFEQ2bNnGuUHkr2Wx4Qn3U9xEhSdg=;
        b=TA1rmsZBdOwowAZe9tndyEfLTsV9EvCESfzpXE35SqJe710Nn1EkE1Dcrmvcpez7dn
         KfEHF1eXaTou1EkTjnWeQwn3dUPYl6VsyR31bMRkUbr0bT65ePXyjcNvJJbcJt1H/AzL
         Uh3TKitpRXSRYqkRd/mv14DppjaTtskHiPgbB+meFEMXRkcPG50Yz0+KIYYa1mjQfyoa
         RwBxSeEc8gscHzbjmrqGTUVSMpU34S3WN3tITJLT68fMQ5NgpY4PQaArz9K5SbiEIPtB
         d0XfJv+NeZ2BAanRTuwdoacRKfq3zbKdS7JsTR0OjRIs1AYZkruAPDYl6hIgSYRmxgL8
         +V9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=iIygQoY1ZT63BYvFEQ2bNnGuUHkr2Wx4Qn3U9xEhSdg=;
        b=D46KnXcujPWKk9RNsQ+2ZMUeKidRsz2i7G7CpgdTQJ73CTMCxHNcqqw+BkxqxjYp+n
         M3bZMDOvxt4hpek5NpDipBf2DlKAT7U1e2VoAqOrhznwODLwPvXPI3JTh+9KXVXvIUsu
         e4M3ACDAtNgYw09V9ovEiBmz7QqsNBz6wycHwabeCBfzeA8IatU7lMKPReYtF8ChXiw2
         tr15QH7XjNLnQeZo3KhmNJeGQlo2P35vED1yhO4xnnajtK4Ke5k0Fb5S7LOGMO3CYROI
         VwaY2jWX1q8GppJ7s7pcz0SdJTPyHblfPf0Pd8MvPstAvrf0LzBNoton/vhHo48m6uPQ
         Vh0A==
X-Gm-Message-State: AJcUukcXjIFndWIUlVZr+QIWYXfGYBXC+vSPN+BgTR3J9avgGL98gsn8
        Hl+T0iwhVBAqP+KM8x2gGTY=
X-Google-Smtp-Source: ALg8bN4UD3JJkOBQyps9HvzXAtdcL/ABbMNEKZp92i986MjkS9q0uYSzCoqRacqkg4z1GdDReGsaFQ==
X-Received: by 2002:a1c:e345:: with SMTP id a66mr17717529wmh.12.1548700232961;
        Mon, 28 Jan 2019 10:30:32 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id c10sm49761682wrr.69.2019.01.28.10.30.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 10:30:32 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Sergey Lukashev <lukashev.s@ya.ru>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: unclear docs
References: <57362151548583138@iva8-37fc2ad204cd.qloud-c.yandex.net>
        <20190128160620.GA23588@sigill.intra.peff.net>
Date:   Mon, 28 Jan 2019 10:30:31 -0800
In-Reply-To: <20190128160620.GA23588@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 28 Jan 2019 11:06:20 -0500")
Message-ID: <xmqqzhrkab3s.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think it means:
>
>   - if core.autocrlf is false (the default), then the text attribute and
>     core.eol are used
>
>   - if core.autocrlf is true, then that overrides the whole
>     attribute/eol system

I think that matches my understanding.

> Subject: [PATCH] doc/gitattributes: clarify "autocrlf overrides eol"
>
> We only override core.eol with core.autocrlf when the latter is set to
> "true" (otherwise, core.eol would never do anything!). Let's make this

I fail to understand what "otherwise..." wants to say.  When
core.autocrlf is not "true", core.eol would not do anything?

But I can understand what the patch text says and it matches my
understanding of the overriding behaviour, so let's queue it.

Thanks.

> more clear, and point the reader to the git-config definitions, which
> discuss this in more detail.
>
> Noticed-by: Sergey Lukashev <lukashev.s@ya.ru>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  Documentation/gitattributes.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
> index b8392fc330..0ce8740e44 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -124,7 +124,8 @@ text file is normalized, its line endings are converted to LF in the
>  repository.  To control what line ending style is used in the working
>  directory, use the `eol` attribute for a single file and the
>  `core.eol` configuration variable for all text files.
> -Note that `core.autocrlf` overrides `core.eol`
> +Note that setting `core.autocrlf` to `true` overrides `core.eol` (see
> +the definitions of those options in linkgit:git-config[1]).
>  
>  Set::
