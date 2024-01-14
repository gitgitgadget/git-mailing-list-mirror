Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFBE1640B
	for <git@vger.kernel.org>; Sun, 14 Jan 2024 18:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="molPIlEc"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5e73e6a17d5so143514357b3.0
        for <git@vger.kernel.org>; Sun, 14 Jan 2024 10:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705256404; x=1705861204; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jhfIB0y8OEAbzm5WYYLigoujmMASP5EKQqGvGmy02o0=;
        b=molPIlEc6ul884U8zc4fGHSZBpMu84a8PREpwDnKGjsKFrLkrCDdZFvWor7j1xzvHR
         ECun66vowV2QX+prtMLpQT8F9wyU/DOl8cmDWvrs2cssxbY8yuIYWGH4Gd4Fb/+1GI1X
         7troBthu4hU9B3e1+ag+Bh6Y8U3tVGLncvqcKYAj05TY3R6XrFRHyJnq1MFzGMZsjjZw
         8LPeE/1QvQF/acLOpDwV9eTGP8o/LYhlys6+6mKBQOeO6PqK3taVnQLxonzddT3PFpbg
         aPIGXzuxAiT1q650bwcTwSgINeJXKboJzhbAcy9Z4PpTWPSIRwuOibB3/ap8W95vYgjB
         A6Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705256404; x=1705861204;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jhfIB0y8OEAbzm5WYYLigoujmMASP5EKQqGvGmy02o0=;
        b=SG4thU3H5onODLHyE/CjwLwPnejUUAniWsCb5oibGT8Wls9FcQxaE9Eo1xFt1n2hoB
         QVSzEW2ZCDXGkQqLxvZCJYIZThmtsfvewUQ9eIcY8LWE7vzLG+i3BY0s06vfOz28cYgK
         0n9k/IiEww8gJSBqoiHk60EXHEX7+nDT2ImgYUE0sU3EPQoQ0xscRh+6+oSmZGEIemeJ
         AAEVhQHItyT4+JGNcGoh9lN5Z3+wgxzxyTNWlmw+fmI7uE+8mpdHuABFTa3NiE7KFb5v
         g6sRxuQKXL8XXwfxhjZl/GR0IjHMBCPPY101LqtCGGoQmbmvrj8p/6PiJLyuaP0if4Il
         MXTw==
X-Gm-Message-State: AOJu0Yz1PkxdgygJSIDAYTmFpb9lSdhd5n+QkLY+yvCPwx5/Fp9EtnPq
	0DkaiNjjh6aQXxfb5b1La4mVeVocPDDI5XhJTQ==
X-Google-Smtp-Source: AGHT+IGy/jDvdgIYVFvE8fxNpkWnDAgl4ClxGkzixfVCTkMFK0fcLJX7kFi9Vo0p5nZKVaSmE3z8vD5Zrx0=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6902:2687:b0:db5:45eb:75b0 with SMTP id
 dx7-20020a056902268700b00db545eb75b0mr1751492ybb.6.1705256404433; Sun, 14 Jan
 2024 10:20:04 -0800 (PST)
Date: Sun, 14 Jan 2024 10:20:03 -0800
In-Reply-To: <20240113073131.GA657764@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1640.git.1705043195997.gitgitgadget@gmail.com>
 <20240112074138.GH618729@coredump.intra.peff.net> <owlyo7dqig1w.fsf@fine.c.googlers.com>
 <xmqqjzoe8br0.fsf@gitster.g> <owlyle8uhxut.fsf@fine.c.googlers.com> <20240113073131.GA657764@coredump.intra.peff.net>
Message-ID: <owlyfryzixpo.fsf@fine.c.googlers.com>
Subject: Re: [PATCH] strvec: use correct member name in comments
From: Linus Arver <linusa@google.com>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, 
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Jeff King <peff@peff.net> writes:

> On Fri, Jan 12, 2024 at 04:37:46PM -0800, Linus Arver wrote:
>
>> OTOH if we were treating these .h files as something meant for direct
>> external consumption (that is, if strvec.h is libified and external
>> users outside of Git are expected to use it directly as their first
>> point of documentation), at that point it might make sense to name the
>> parameters (akin to the style of manpages for syscalls). But I imagine
>> at that point we would have some other means of developer docs (beyond
>> raw header files) for libified parts of Git, so even in that case it's
>> probably fine to keep things as is.
>
> I think this is mostly orthogonal to libification. Whether the audience
> is other parts of Git or users outside of Git, they need to know how to
> call the function. Our main source of documentation there is comments
> above the declaration (we've marked these with "/**" which would allow a
> parser to pull them into a separate doc file, but AFAIK in the 9 years
> since we started that convention, nobody has bothered to write such a
> script).
>
> Naming the parameters can help when writing those comments, because you
> can then refer to them (e.g., see the comment above strbuf_addftime).
> Even without that, I think they can be helpful, but I don't think I'd
> bother adding them in unless taking a pass over the whole file, looking
> for comments that do not sufficiently explain their matching functions.

So in summary you are saying that the comments are the most important
source of documentation that we have currently, and unless naming the
parameters improves these comments, we shouldn't bother naming these
parameters. I agree.

> I don't doubt that some of that would be necessary for libification,
> just to increase the quality of the documentation. But I think it's
> largely separate from the patch in this thread.

I agree with both statements. Thanks.
