Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20366FDA
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 11:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTv+w6W7"
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59F61BC
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 04:47:41 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1ef36a04931so1070459fac.2
        for <git@vger.kernel.org>; Fri, 03 Nov 2023 04:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699012061; x=1699616861; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1FCXBXpZTratVDY7FHxJZfx/d341YCSNwKLWRgeVD6g=;
        b=dTv+w6W7g0EHQ44bBJCWCwyD4dAHyxFgSTm7+mC96hfr4Vp1rf4QRZpIq8IObQBPeS
         FDJu80s3A46/HxkcIZUU+ab2sFpf6VONjde14Ys3sAGDjge0rno8lRwX4nsyKdkWNsgj
         RCG1z48Cx5UXETI9cTjsFjrxgfNhLl6JW7snDDvuu14bwt97AAjI9WLhoSrWXwui41Y+
         6trXZBAk6G7qgA1apFDsKxQr5/ks0OnGu8YxlMgcCfoBwhN6eTTdpLnIDou22xzRpAL7
         mxKTYL+s6tkjlOVE1eFUhvAYLseJpF22i5w0TvE49n0Bgw0r0aCDL+rEPkciswK1cOMT
         T5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699012061; x=1699616861;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1FCXBXpZTratVDY7FHxJZfx/d341YCSNwKLWRgeVD6g=;
        b=TXkjPV4RjoLuYvGFYlr1vvxTjqU5A/KzUq6kLH0xYOLIcL0tobQsOd02Nyl0t7xhyd
         zOIzl4MT8B0hbY62Ny06MnYSL2WY1ZOhg33NfseHQSCgscyrjkvx65B4Djwym3AIwK0t
         e1bdSSJkMCjWy1eZjPS7wbP6ekGjALL1kxqn+91AFYxKLJ8VbxnAtpvLw4JBnsiaJT0h
         F+jAaQzHE2IY4/cKUXuhegnlB2B2VIrF6J6/1y0Tc73j16KDCQd7VrmRgEtaTgnVmBFm
         ee7UXPnktgoH2uR+aE9hYuXxdKiK+3wn9sh3TxokyiAo7O8gZqUqoU3TFt+mTuHU4uar
         jLaw==
X-Gm-Message-State: AOJu0YzMC2VbTMVv984aHQnBHhqF6sxClFpejeJNRRGGJZ0eNfVlnuf6
	+Cyv2weLwbKrJo82gJfcem0=
X-Google-Smtp-Source: AGHT+IHaTGt2Nz+WLZ9k6lAirpft/gwYFEgafY1kLXcqkFUwSp1tOflr/yoLtiVve6u0oMl4XWNMaQ==
X-Received: by 2002:a05:6871:490:b0:1ea:4dc8:a17 with SMTP id f16-20020a056871049000b001ea4dc80a17mr24420699oaj.28.1699012060886;
        Fri, 03 Nov 2023 04:47:40 -0700 (PDT)
Received: from ?IPV6:2605:2a00:8001:dead::3ac? ([2605:2a00:8001:dead::3ac])
        by smtp.gmail.com with ESMTPSA id fd10-20020a05622a4d0a00b0041b2be3683csm632364qtb.69.2023.11.03.04.47.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Nov 2023 04:47:40 -0700 (PDT)
Message-ID: <24c46f25-6b31-437d-9f89-1e8eb74136c8@gmail.com>
Date: Fri, 3 Nov 2023 07:47:39 -0400
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
 <d54eedf0-7825-44f5-908c-a51541345872@gmail.com>
 <79cf1bf35ba6c9348735685b01e0f2f9@manjaro.org>
From: Thomas Guyot <tguyot@gmail.com>
Autocrypt: addr=tguyot@gmail.com; keydata=
 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
In-Reply-To: <79cf1bf35ba6c9348735685b01e0f2f9@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2023-11-02 10:19, Dragan Simic wrote:
> On 2023-11-02 14:19, Thomas Guyot wrote:
>> That's correct, you need both and also -y0
> Hmm, I tried the following:
>
>       GIT_PAGER='less -R -F -X -c -y0'
>
> In my environment (Xfce), the result after scrolling the output of "git
> log -p" up and down a bit was about 20 copies of the same screen "page"
> in the scrollback, plus a couple of blank "pages".  Not good,
> unfortunately, and actually much worse than having just "-R -F -X".

Indeed, I did notice it with xfce4-term - I suspect different controls 
are used to clear the screen, with rxvt-unicode the initial one scrolls 
anything in the current display to the scrollback (which is important to 
avoid clearing the last commands/output form the scrollback), but 
afterward screen updates do not update the scrollback, it remains within 
the screen.

These options may actually affect the behavior (I have put my current 
values there)

     secondaryScreen: True
         Turn on/off secondary screen (default enabled).

     secondaryScroll: True
         Turn on/off secondary screen scroll (default enabled). If this
         option is enabled, scrolls on the secondary screen will change the
         scrollback buffer and, when secondaryScreen is off, switching
         to/from the secondary screen will instead scroll the screen up.

So it appears I could disable secondaryScroll to avoid getting scrolled 
lines into the scrollback buffer. It's also noteworthy that with 
secondaryScreen disabled, rxvt-unicode instead scroll things up to avoid 
the current screen form being wiped out.
>> Indeed, but when less update from the bottom, it can add new lines and
>> let the overflow lines scroll up into the scrollback buffer.
>>
>> Then updating it from the top, it draws the whole page, top to bottom.
>> That's fine for a full page but not desired for a partial one. Also
>> note that on my terminal (rxvt-unicode) when less clears the screen to
>> draw the first page the current screen is rolled up into scrollback -
>> iirc that's a configurable option, it would be worth testing other
>> terminal's behavior on that. IIRC it may also erase it when using the
>> wrong termcap file.
>>
>> I haven't looked at the code, but I think it could be possibly to
>> start the -c behavior only after a full page is drawn, after exiting
>> on partial pages, which would give us the best of both worlds.
> Does the GIT_PAGER setup, as I described it above, work for you without
> the described artifacts, in any of the environments you have access to?

Yes, rxvt-unicode, with the settings mentioned above.

>>> Just to clarify, it's the "-X" option that creates all the issues, and
>>> the "--redraw-on-quit" option is already there to replace it with no
>>> associated issues, but the trouble is that only newer versions of
>>> less(1) support the "--redraw-on-quit" option.  IOW, it's all about
>>> improving less(1) to avoid complex workarounds required to handle
>>> different versions, such as the workarounds used in bat(1).
>> TBH I haven't tested --redraw-on-quit, even on Debian Bookworm which
>> was just released a couple months ago this option isn't available. I
>> suspect that the issue isn't -X, but the scrolling behavior controlled
>> by -y and the full redraw controlled by -c.
> When you get into the terminfo entry definitions, the root cause is that
> the terminal initialization sequences contain switching to alternate
> screen, which causes screen contents to be lost when less(1) exits.
> Thus, "-X" has been actually abused in the pager setups to skip the
> terminal initialization sequences, which may also result in other
> issues.

Right - this is something that rxvt-unicode addresses with the correct 
settings.
IIRC I disabled the secondasyScreen to be able to use the scrollback 
buffer (unavailable otherwise), which probably also means that with it 
enabled I would also have no issue without -X, but that would need 
testing. Also note that rxvt-unicode has its own terminfo file 
(xfce4-term uses xterm), and in some places I'm forced to use xterm as a 
fallback I get issues like current screen being wiped when switching 
to/from secondary screen.
> One of the solutions is to edit the terminfo entry manually and remove
> the escape codes that cause the switching to and from alternate screen,
> which I tested, but that also introduced another issue -- the screen
> contents was always present after less(1) exited, which isn't always the
> desired behavior.

But when less scrolls down (line by line, not page by page), it always 
append lines and let them scroll up. Won't you see these? (page-by-page 
otoh will redraw the full screen without scrolling).

Also won't it wipe the *current* screen so that you won't see the 
commands/output you had *before* running less?

This is why rxvt-unicode has an option to disable secondary screen, and 
scroll contents all the way to the buffer on switch to/from secondary 
screen.
>> Actually I just tested my
>> solution on xfce4-terminal and it doesn't work, the terminal still
>> push up stuff above on redraw (noteworthy is with rxvt-unicode the
>> first draw pushes the current screen contents up but no other redraw
>> does, which is what makes it work so well - I haven't tried to find
>> out what is being done exactly... OTOH the redraw on scroll down is
>> slightly noticeable there, while impossible to see on xfce4-terminal.
>> I'll install the latest less and see what happens with --redraw on
> Please test the "--redraw-on-quit" option, so far it's the best
> available solution, IMHO.

I will, not now though - need it compile less form source I guess...
>>>> If less could only enable this behavior after the first full page
>>>> draw, that would be perfect!
>>> Could you, please, elaborate a bit on that?
>> I mentioned it slightly above, to be clear it would mean that:
>>
>> 1. less starts by just writing lined down as usual, making any lines
>> above scroll up and overflow into the scrollback buffer as usual
>> 2.  If less draws less than a page, exits as before - the effective
>> result is as if pager was cat
>> 3. If less reaches a full page and still has lines to write, it turns
>> on -c's behavior and further updates happen from the top of the
>> screen, preventing scroll up (at least on rxvt-unicode)
>>
>> Now, if all other terms misbehave here, that's an issue, making this
>> suggestion mostly useless. And considering the number of Windows users
>> we absolutely need to test Windows Terminal, and should probably test
>> MacOS's term too (whatever that is).
> Quite frankly, I think that such a solution would be like "fixing the
> fix, which is actually an abuse", as I described it above, eventually
> introducing even more issues, instead of solving the original issue.

I'll let you know my findings... I'm not convinced --redraw-on-quit is 
actually going to fix it for all unless this does a lot more than the 
option name implies (but quite happy if it does).

Regards.
--
Thomas

