Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2C521FC46
	for <e@80x24.org>; Wed,  8 Feb 2017 03:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753255AbdBHDND (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Feb 2017 22:13:03 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36630 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753027AbdBHDMk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2017 22:12:40 -0500
Received: by mail-pg0-f65.google.com with SMTP id 75so13785265pgf.3
        for <git@vger.kernel.org>; Tue, 07 Feb 2017 19:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=f0zyHenf+FIgKHThDMZWzC2vcT+UL0YWgVy8hxv2m0M=;
        b=XbwJ0CuJWIFZKgY9ipT/CFcOEOoSDt9VL4/NXC1R0WDTqUltkxzMlwNidy6rYfLEDw
         8ivhwvleMDA31lZ/iX30VBWDEHZP1NbB0S5HSrCbs62Gs3IOE1fcpyXizm2TazLL94K9
         p0Hue+YRocJCCF3Ky53IGzGkswX8DoomanzJn1gjTMMg+D1HJ2rX7ohFX3+lBQbfAhzg
         cvU8qIfIPBYfqOtK3OU9jFS4+xN80+WJLY2BejI2JV1Aaz9jlEK42e6d7dr7NX/3a8vI
         iiOFc908gc1mCYtDeySurvY18q7SgSX+/jx++UwvaUoK5WGGZYBGri/2VyM7yYaZF3V7
         eboQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=f0zyHenf+FIgKHThDMZWzC2vcT+UL0YWgVy8hxv2m0M=;
        b=o+rKpLij0ZpD8LKI93NeOnXZ4GxEDsSF4bRmE6YD/aI+ThmtbAOo10Z92YtxjwQxOa
         q4D0710LCAdm6FaqzQvfYXfCW9EY2q9giVZ4XtL0pQey+d+UXBG8cv/WZ9/M1cUwg8DV
         eQRpc2yQ3y04XACl+QL9hRM+avuq4CI7EaG57PVZNsPj3ydIZb7/WM22RklEvqBgZplP
         mfkLvRUU9PJLWZAYm9erXuoDomno3/6lcSL1eQXhmMB/i3Dn7hVgzvl0mpbfsntgj8RL
         b95PrA2xmjua1aFfC8gxgV1q+Zw1+eANEQnr9VPswOwuQA7xo1NyCOrU2hasxuV1FoqV
         Dorw==
X-Gm-Message-State: AIkVDXJ5CUxYCoKVVaNKEqYrnsv/JmT5JzELOploqsHq3B3ALWQ1eyv6nulz93dlpP4pJw==
X-Received: by 10.98.66.138 with SMTP id h10mr23358078pfd.94.1486523560175;
        Tue, 07 Feb 2017 19:12:40 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:1564:f4f3:f1b4:c9b2])
        by smtp.gmail.com with ESMTPSA id g87sm14934304pfj.20.2017.02.07.19.12.39
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 07 Feb 2017 19:12:39 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Fwd: Possibly nicer pathspec syntax?
References: <CA+55aFyznf1k=iyiQx6KLj3okpid0-HexZWsVkxt7LqCdz+O5A@mail.gmail.com>
        <CA+55aFzkTZAb1vy3G5M_Nb1BeOhTiCGksUfLa+ZQtiU2x6Q=Fw@mail.gmail.com>
        <alpine.LFD.2.20.1702071739060.17609@i7.lan>
        <xmqqefz9xv0x.fsf@gitster.mtv.corp.google.com>
        <CA+55aFwPLtuPciN1o_03CwkKqFWgZd_br9Q14qyr7a7N7mxTeA@mail.gmail.com>
Date:   Tue, 07 Feb 2017 19:12:38 -0800
In-Reply-To: <CA+55aFwPLtuPciN1o_03CwkKqFWgZd_br9Q14qyr7a7N7mxTeA@mail.gmail.com>
        (Linus Torvalds's message of "Tue, 7 Feb 2017 19:02:24 -0800")
Message-ID: <xmqqa89xxtnd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> No. The thing is, "git diff" is relative too - for path
> specifications. And the negative entries are pathspecs - and they act
> as relative ones.
>
> IOW, that whole
>
>   cd drivers
>   git diff A..B -- net/
>
> will actually show the diff for drivers/net - so the pathspec very
> much acts as relative to the cwd.

But that is not what I was talking about.  Let's simplify.  I'd say
for any command that acts on "everything" when pathspec is not
given, the two sets of actual paths affected by these two:

	git cmd -- "net/"
	git cmd -- ":!net/"

should have no overlap (obviously) and when you take union of the
two sets, that should equal to

	git cmd --

i.e. no pathspecs.

>>  2. I am not sure what ctype.c change is about.  Care to elaborate?
>
> I didn't see the need for it either until I made the rest of the
> patch, and it didn't work at all.
>
> The pathspec.c code uses "if (is_pathspec_magic(..))" to test whether
> a character is a short magiic pathspec character.  But '^' wasn't in
> that set, because it was already marked as being (only) in the regex
> set.
>
> Does that whole is_pathspec_magic() thing make any sense when we have
> an array that specifies the special characters we react to? No it does
> not.
>
> But it is what the code does, and I just made that code work.

Ah, OK.
