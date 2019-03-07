Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00FF320248
	for <e@80x24.org>; Thu,  7 Mar 2019 03:47:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbfCGDro (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 22:47:44 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37493 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfCGDro (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 22:47:44 -0500
Received: by mail-wm1-f68.google.com with SMTP id x10so7779748wmg.2
        for <git@vger.kernel.org>; Wed, 06 Mar 2019 19:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=sWdhFIYbS0a3zfoHbkUOy1rqHC7LnAA1YlagIjQAf6I=;
        b=brteeYb68DsZuuGACa3msfSJsOgP92rVHO7dVK5FZ4wDVHDeEF8QRtgYeQkadtOvyx
         TdAEib/TUzw5w+G/ITYoVYFvP1rfj4iYMB2QlXX8cHv3Op5V/dozV8hhT2lD/vDfKMMe
         ZalddLR5lHLXCiP3MFz71AP+5VxOnjK3f/lWa2b9PwPZ/vunhXWYsMSP5vS6OVpvXR/d
         MeV9SZ2mFvMFXelBd52+cXNVHulqNcBbyeOQuPc/Yl+dgq7jNorvw84iNTJnIN3+tx+t
         0MF6gFfiluuafGeZU6G+9Oq6wBbpcYF+NfwqxfDjogV558mXg1Lv0d0myaRE1HGmL+9V
         Q+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=sWdhFIYbS0a3zfoHbkUOy1rqHC7LnAA1YlagIjQAf6I=;
        b=Z8BjU23CvSsuVCt4dLsW93qxMK4p+kbDtmFuPli3xcvEOQzhwSyWQzuUVip5wpfHsP
         hVa+ihneBQ2lN+hISyPJlCQJiy4M/0MOyPWWrCc7E5KuZtl3owwXnpXzLwMDwGCylbvt
         70KC09/FSBC5THvqLig/61UFD504ByaeskL2gefCLOAdVqUNJrStwk6Um3rvyL+29jUF
         xmk4rSZbnjz/RvjbEsej8jLiuVYyIhxhzVJFRcUu8465loxhXBqQOh1+ssT3mHV/phuB
         AJcExODs4toNqH+scuuxvv5BuTTHSqnIAqT8A5u6lmulWSJqlkGQ2/+STwJqr7Mx8Ojg
         EpYg==
X-Gm-Message-State: APjAAAX8FJ8NjB2LGuDT8BATY2MGH+hIIX+/v87WJPyLYttTJBH3urxC
        F/KKtzUpH6XsqPiEzgqKmvA=
X-Google-Smtp-Source: APXvYqyxEfhYU0cv+cFYI9AenKFwv5q5JK5dnSKBXeoRcEy8bpFz7pxDAE94fhGKwFCpi2osz4LU9w==
X-Received: by 2002:a1c:f502:: with SMTP id t2mr4158741wmh.124.1551930462361;
        Wed, 06 Mar 2019 19:47:42 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id f68sm7677424wmg.5.2019.03.06.19.47.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 19:47:41 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] Documentation/config: note trailing newline with --type=color
References: <b5ca6391fd0273fb7d6b92bc5ada96df93bc5cf2.1551487219.git.me@ttaylorr.com>
        <be22686b93fa76f0ff63a7d93cb731545c57cb22.1551916338.git.me@ttaylorr.com>
        <20190307025821.GB25656@sigill.intra.peff.net>
Date:   Thu, 07 Mar 2019 12:47:40 +0900
In-Reply-To: <20190307025821.GB25656@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 6 Mar 2019 21:58:21 -0500")
Message-ID: <xmqq4l8fny5f.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Mar 06, 2019 at 03:52:38PM -0800, Taylor Blau wrote:
>
>> In 63e2a0f8e9 (builtin/config: introduce `color` type specifier,
>> 2018-04-09), `--type=color` was introduced and preferred to the
>> old-style `--get-color`.
>> 
>> The two behave the same in almost every way, save for the fact that
>> `--type=color` prints a trailing newline where `--get-color` does not.
>> Instead of introducing ambiguity between `--type=color` and the other
>> `--type` variants, document the difference between `--type=color` and
>> `--get-color` instead.
>
> I just responded to the one Junio posted elsewhere in the thread, but
> for the record this one is fine to me, too (and it gets the literal
> quoting right ;) ).

Yeah, I haven't reached that message when I was doing mine.  Other
than "co-authored-by", which probably is not quite correct (i.e. I
would have added "[tb: wrapped it up with a commit log message]" and
kept you as the author, if I were doing it), I do not have a problem
with Taylor's version, either.

