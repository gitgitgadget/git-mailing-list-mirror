Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEC911CA5
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 13:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0ahQ065"
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4614138
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 06:19:13 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-77a277eb084so50767685a.2
        for <git@vger.kernel.org>; Thu, 02 Nov 2023 06:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698931153; x=1699535953; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mLLMHpGNrsh2/LPhpKjFv2m8veUvnFcCmmQhTS5ohvI=;
        b=Z0ahQ065RIrAC5ZArlu73xcnGLypscv2TFmdhI9ThlM9GHS2iby26V6WO20IAlV9+A
         rkjqrxy1QM9wjSMrqfrT9DcNJ5Cfw6Rx9BdZh8zgKv/5hcbj5ns1PX1lya0XN+uha6Lm
         IRx0FapwZj4wZrdQ31PBH4UeRHVsey6axUJ+ZrvQAGDIbYskNpFmRg66aqXujGJ3Eywq
         24qANIL95RlAAPhtClIm7LqrRRKn8hrLpQ2Mk1fWvJIFouKM1iabqAXNJV1gDmbHLP2R
         ZCLkl0ZWlSfxl4SOnSYWm6xc2Xra5VK0Fuvr9wH7PHLqTUPwK5Ph9IFC+QbPd87RXnfL
         h9Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698931153; x=1699535953;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mLLMHpGNrsh2/LPhpKjFv2m8veUvnFcCmmQhTS5ohvI=;
        b=vS0jn8mJwCIeikfQYvX/1RpQPgKF6HhMU8c7RLYeU6p1DCs9bR8LhSNMVdNWbCACVx
         l/VF2QS3APkz18z5/pI21AtX/e0UBbIXRV24msgDmysHslX5AvGIoOdmxwX4tQESWsRH
         18qedtfhhhVpbNXvrFX2I4jFBleiNcDPwtsmtLod/B8A666VXN51JrDdmhi8pEStMU/9
         f3Kqg1VCIEaIWoSHkSTfb6wbCVckO1thows1bPgOzUUFPA5tI1yVjFukUckCX6Fom2yK
         pw1Yo6HkTBQnm17wfFezV+sv67423HzZt8hov98eKdDwQ9ay88aa0Poc/ci5mBIzU2tl
         ByDA==
X-Gm-Message-State: AOJu0YxN/A698YD1s2l4+xzHLw3VIfpwx7fVZcuc5f1/olFfYNQExJ6H
	i1ecCPDs5yAyurQkZU9taeLRNXwICVZCUVR8FK0=
X-Google-Smtp-Source: AGHT+IGcSnPGXUkzurozVxep/0dKN5s7Yb5ct3HZNR2eDUyyfDgSYNPy2LDtlIYUcI66TE6OJJmcNg==
X-Received: by 2002:a05:620a:3727:b0:76f:1614:576b with SMTP id de39-20020a05620a372700b0076f1614576bmr21255910qkb.1.1698931152757;
        Thu, 02 Nov 2023 06:19:12 -0700 (PDT)
Received: from ?IPV6:2605:2a00:8001:dead::3ac? ([2605:2a00:8001:dead::3ac])
        by smtp.gmail.com with ESMTPSA id t27-20020a05620a035b00b00767d8e12ce3sm2329767qkm.49.2023.11.02.06.19.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 06:19:12 -0700 (PDT)
Message-ID: <d54eedf0-7825-44f5-908c-a51541345872@gmail.com>
Date: Thu, 2 Nov 2023 09:19:11 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: why does git set X in LESS env var?
Content-Language: en-US, fr
To: Dragan Simic <dsimic@manjaro.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
 Christoph Anton Mitterer <calestyo@scientia.org>, git@vger.kernel.org
References: <3a2c362c019338ca7408b7a3bc5715b535d15b8a.camel@scientia.org>
 <xmqqa5sokdd3.fsf@gitster.g>
 <20231012000416.GA520855@coredump.intra.peff.net>
 <xmqqh6mwipqi.fsf@gitster.g> <3946c06e90604a92ad0dddf787729668@manjaro.org>
 <xmqqr0lzhkzk.fsf@gitster.g> <a831af51b6fb46b5d6fcd9768a7fb52d@manjaro.org>
 <cfbe174f-23ac-4a35-8db4-66bdfdfdc14e@gmail.com>
 <8022dae27797bf1e1770f099ed37f5d3@manjaro.org>
From: Thomas Guyot <tguyot@gmail.com>
Autocrypt: addr=tguyot@gmail.com; keydata=
 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
In-Reply-To: <8022dae27797bf1e1770f099ed37f5d3@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2023-11-02 02:48, Dragan Simic wrote:
> On 2023-11-02 06:48, Thomas Guyot wrote:
>>         -c or --clear-screen ( and backward compat. -C or
>> --CLEAR-SCREEN )
>>                Causes full screen repaints to be painted from the top
>> line down.  By default, full screen repaints are done by scrolling
>> from the  bottom  of the screen.
> AFAIK, the "-c" option is about the way screen contents is updated when
> scrolled, and it exists to aid in resolving possible issues with some
> terminal emulators.  To make sure, I just tested it, and "-c" doesn't
> replace "-X".
That's correct, you need both and also -y0

>>         -yn or --max-forw-scroll=n
>>                Specifies  a  maximum  number of lines to scroll
>> forward.  If it is necessary to scroll forward more than n lines, the
>> screen is repainted in‐
>>                stead.  The -c or -C option may be used to repaint from
>> the top of the screen if desired.  By default, any forward movement
>> causes scrolling.
> This option is, I'd guess, also about aiding in resolving possible
> issues with some terminal emulators.  Or maybe even with some actual
> terminals as pieces of hardware, who knows, which may be too slow to
> scroll many lines at once.

With a value of 0, it effectively redraw the screen on scroll. This 
could have a potential impact on slow connections.

>> I actually have one major issue with it, it's that displaying anything
>> less than a full page will fill the screen with ~ on the bottom, just
>> like when scrolling up on a partial page  without -F. I can see this
>> being a major annoyance when using for ex. git log -1, git show --stat
>> or --name-only, etc. as I  usually do it to keep the latest history
>> within the current screen (and there's likely even commands that I
>> never seen using the pager because I never exceeded the page height).
> Huh, this confuses me a bit, quite frankly.  Isn't the "-F" option used
> specifically to make pagination invisible in case fewer lines than one
> full screen are displayed?

Indeed, but when less update from the bottom, it can add new lines and 
let the overflow lines scroll up into the scrollback buffer.

Then updating it from the top, it draws the whole page, top to bottom. 
That's fine for a full page but not desired for a partial one. Also note 
that on my terminal (rxvt-unicode) when less clears the screen to draw 
the first page the current screen is rolled up into scrollback - iirc 
that's a configurable option, it would be worth testing other terminal's 
behavior on that. IIRC it may also erase it when using the wrong termcap 
file.

I haven't looked at the code, but I think it could be possibly to start 
the -c behavior only after a full page is drawn, after exiting on 
partial pages, which would give us the best of both worlds.

>> OTOH by repainting from the top, the scrollback buffer is never
>> affected. only the last displayed page remains on the terminal.
> Just to clarify, it's the "-X" option that creates all the issues, and
> the "--redraw-on-quit" option is already there to replace it with no
> associated issues, but the trouble is that only newer versions of
> less(1) support the "--redraw-on-quit" option.  IOW, it's all about
> improving less(1) to avoid complex workarounds required to handle
> different versions, such as the workarounds used in bat(1).

TBH I haven't tested --redraw-on-quit, even on Debian Bookworm which was 
just released a couple months ago this option isn't available. I suspect 
that the issue isn't -X, but the scrolling behavior controlled by -y and 
the full redraw controlled by -c.Actually I just tested my solution on 
xfce4-terminal and it doesn't work, the terminal still push up stuff 
above on redraw (noteworthy is with rxvt-unicode the first draw pushes 
the current screen contents up but no other redraw does, which is what 
makes it work so well - I haven't tried to find out what is being done 
exactly... OTOH the redraw on scroll down is slightly noticeable there, 
while impossible to see on xfce4-terminal. I'll install the latest less 
and see what happens with --redraw on
>> If less could only enable this behavior after the first full page
>> draw, that would be perfect!
> Could you, please, elaborate a bit on that?

I mentioned it slightly above, to be clear it would mean that:

1. less starts by just writing lined down as usual, making any lines 
above scroll up and overflow into the scrollback buffer as usual
2.  If less draws less than a page, exits as before - the effective 
result is as if pager was cat
3. If less reaches a full page and still has lines to write, it turns on 
-c's behavior and further updates happen from the top of the screen, 
preventing scroll up (at least on rxvt-unicode)

Now, if all other terms misbehave here, that's an issue, making this 
suggestion mostly useless. And considering the number of Windows users 
we absolutely need to test Windows Terminal, and should probably test 
MacOS's term too (whatever that is).
>> Dragan, that may be useful if you're discussing with less
>> developers...
> We've basically reached some kind of an agreement about the need for a
> good solution, which turned out to be rather complex as a result of
> being quite universal and extensible, which was required for it to,
> hopefully, be accepted into less(1).  Also, the author of less(1) seems
> to be quite busy with some other things, and he prefers to implement new
> features himself.
>
> We've also agreed on another new feature for less(1), hopefully, which
> isn't exactly related, but should be quite useful.  It's about the
> secure mode for less(1).

Feel free to cc me on your next correspondence. If there are mailing 
lists archives for the thread I'll fetch them as needed. We have at 
least one working term/switch combination, which IMO is a better start 
than nothing :)

Regards,

--
Thomas
