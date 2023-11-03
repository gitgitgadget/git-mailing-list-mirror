Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6F2154AF
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 15:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f15G+Y7A"
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3857123
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 08:28:25 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9a58dbd5daeso346469466b.2
        for <git@vger.kernel.org>; Fri, 03 Nov 2023 08:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699025304; x=1699630104; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VytsDXoRoyIMOX7t/euzyOJFndPuo9Zb8s3FkY8Jbsw=;
        b=f15G+Y7AhHxB/Ep1gYCxv4gqTeGgIwm3RPXIv3hPPguy8SEMHZmeWBFdrM5ptSTX9Z
         k5Y+6X89+0qpirA8SzOEgKXp5deukXaLlpG86q6QZ04IK42jdg52pYNmvKypyV57ajus
         6+jZSCbFriyV41s75hg4mmQ2bnbKcXnSAaDLdcfNqcmAJ/vH/5lwnTbQLwV0fVf67omK
         b45IqX3x3+u++s5CtaYFwEHyztIiN4kOKwk7KcQiA1g3POWH2KTKq7y39L9pIZ6rRzpZ
         kGFCm1sRFotHlpr8s4QDo6d6wWanLM28W+rlHJoQEm26njAvCdkE6rtKaGQkCp/w20Hz
         4QcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699025304; x=1699630104;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VytsDXoRoyIMOX7t/euzyOJFndPuo9Zb8s3FkY8Jbsw=;
        b=SFw/zhlLkUk5jhD+wtQNm45Ik9NFNDDx9ZDUNJUJFHAgmyIl+TXjBryAdJlV5NebmL
         atCHz8f50q0r/ZKjHgEK9hHMyZhx70ETvMkdONsdTmGOifvfBRySAdhm5QHnHC0momxO
         Dl+kLwPzDyKRxPHUixA+RdxKpztWs8nocT5XLK9CyioOgnfgvZsT+iTCI/2vc+r52BTR
         u/Bqo8j6Las205JF0AixhYa2yk24wA05dciFaU7dvfZJ7ZJxhCyAmyZOtifIPqbvEQPf
         M8+mLPCJcNEQXODq3yWVQZCSWBHukXV6By075mWbQQDkU6/onj7YOJo2x1hwV/rccYXv
         7A8A==
X-Gm-Message-State: AOJu0YxYO1uDflJKCTu8AuB151LK2tCAcw4nDSiA3Yw34DQWXzLs8Rxa
	5Dox/+4mAq6H6GuN9K9G8WM1H4TqITrp54E2pJI=
X-Google-Smtp-Source: AGHT+IFpUUryhnxbet19t28cgxEjjOSjdRz10qarmWpejO7NMvWiblz27C5nxXx0urmr3W4Zh0z0vHq5Qrl4hWG6+Ds=
X-Received: by 2002:a17:906:6d0:b0:9c4:4b20:44a4 with SMTP id
 v16-20020a17090606d000b009c44b2044a4mr5139001ejb.48.1699025303989; Fri, 03
 Nov 2023 08:28:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3a2c362c019338ca7408b7a3bc5715b535d15b8a.camel@scientia.org>
 <xmqqa5sokdd3.fsf@gitster.g> <20231012000416.GA520855@coredump.intra.peff.net>
 <xmqqh6mwipqi.fsf@gitster.g> <3946c06e90604a92ad0dddf787729668@manjaro.org>
 <xmqqr0lzhkzk.fsf@gitster.g> <a831af51b6fb46b5d6fcd9768a7fb52d@manjaro.org>
 <cfbe174f-23ac-4a35-8db4-66bdfdfdc14e@gmail.com> <8022dae27797bf1e1770f099ed37f5d3@manjaro.org>
 <d54eedf0-7825-44f5-908c-a51541345872@gmail.com> <79cf1bf35ba6c9348735685b01e0f2f9@manjaro.org>
 <24c46f25-6b31-437d-9f89-1e8eb74136c8@gmail.com>
In-Reply-To: <24c46f25-6b31-437d-9f89-1e8eb74136c8@gmail.com>
From: Andy Koppe <andy.koppe@gmail.com>
Date: Fri, 3 Nov 2023 15:28:12 +0000
Message-ID: <CAHWeT-aftfawZ9DhqC1NkQrJAuArJZC65ZDr4FyPwEc7aXGVuA@mail.gmail.com>
Subject: Re: why does git set X in LESS env var?
To: Thomas Guyot <tguyot@gmail.com>
Cc: Dragan Simic <dsimic@manjaro.org>, Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
	Christoph Anton Mitterer <calestyo@scientia.org>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thomas Guyot wrote:
> >> I actually have one major issue with it, it's that displaying anything
> >> less than a full page will fill the screen with ~ on the bottom, just
> >> like when scrolling up on a partial page  without -F.

'less' has the '-~' (or --tilde) option to suppress that.

> I mentioned it slightly above, to be clear it would mean that:
>
> 1. less starts by just writing lined down as usual, making any lines
> above scroll up and overflow into the scrollback buffer as usual
> 2.  If less draws less than a page, exits as before - the effective
> result is as if pager was cat
> 3. If less reaches a full page and still has lines to write, it turns on
> -c's behavior and further updates happen from the top of the screen,
> preventing scroll up (at least on rxvt-unicode)
>
> Now, if all other terms misbehave here, that's an issue, making this
> suggestion mostly useless. And considering the number of Windows users
> we absolutely need to test Windows Terminal, and should probably test
> MacOS's term too (whatever that is).

For what it's worth, the 'mintty' terminal used by default for Git for
Windows as well as MSYS and Cygwin has another approach to the whole
problem. Its rather flippantly named 'Flip Screen' context menu
command with Alt+F12 or Ctrl+Shift+S shortcut lets users temporarily
look at the alternate screen buffer while the main screen buffer is
active, and vice versa.

If 'less' is invoked without the -X option, it will switch to the
alternate screen, where mousewheel scrolling works by sending cursor
up/down keycodes. While in 'less', you can temporarily flip to the
main screen to look up something in the shell session there or copy
something for searching in 'less'. While looking at the main screen,
the mousewheel will scroll the scrollback buffer. Keyboard input
that's sent to 'less' will flip back to the alternate screen.

Quitting 'less' switches back to the main screen, so the 'less' output
disappears and you're back in the shell session with the command that
invoked 'less' as the last thing shown. But again, the 'Flip Screen'
command or shortcuts can be used to temporarily look at or copy from
the alternate screen, which will contain the last page displayed by
'less'. (The alternate screen does not have a scrollback buffer.)

The 'Flip Screen' feature of course also works with other
alternate-screen applications, for example editors.

Apparently the Mac terminal has such a feature as well:
https://support.apple.com/en-ie/guide/terminal/trmld1f46097/mac

(Full disclosure: I originally made mintty, from PuTTY.)

Kind regards,
Andy
