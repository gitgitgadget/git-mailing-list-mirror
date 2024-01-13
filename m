Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D1715485
	for <git@vger.kernel.org>; Sat, 13 Jan 2024 00:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KjDblr6e"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbedaa77289so8449902276.0
        for <git@vger.kernel.org>; Fri, 12 Jan 2024 16:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705106267; x=1705711067; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nspPuU/+rgLUcJOqOUR5MyAf5pvHX3cUcU4DdkEzj5o=;
        b=KjDblr6eNkmcV6ZOE3qGjSLZ6IPJsnmaSsMUzxH+fpx8g6Any5L65QEDSPo1iu8Tof
         1upU9ITGwEnOennO5ZxUseMTQa4VMg8AXbcA8iN0PpWQqHwQ93c+lmyGBxxoJfnRT6o/
         CGtVg9atTIHOZwi7IwzmyyUL2eLjXzANYeQTBIlHwLPvyInHw0Fa/3ljHd38BgBxLZqJ
         6APx53KYBELJmYG6pAIJ+ZUPXp68eSUf8/IlWmZtkFBeVqLQl6J3eg9flyTnzwNhCYUA
         ME2DfzKqjtFGnQu83O/9ND19R3xmoVcZ8saXTsp6oL/nFGV0tWerNAOjI4wdWZtZYJOn
         E5Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705106267; x=1705711067;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nspPuU/+rgLUcJOqOUR5MyAf5pvHX3cUcU4DdkEzj5o=;
        b=CMsX8QPU0BI8cPxqg4L4WXTdfR8elyH6ub7xsMf641QRxyHhOd9fOFItR3p7XaWvoo
         crZqOzYMFFX6B//cuTyrHqCRZmyA7gcu+rxvIIX+a/2AJJk4UVMTT3DAkP630naf5BJ8
         JmVtABNa0MP5JauFKldo1P7kyB+PaHNNTINw1UGHX3/UnWsWRoYonT3yb2FbRnNdW4Ti
         YZlXIM2vPnOHnuuyNwpvbq8gdlH8O+3YunajymZvnLjbOWYPsr4Sq2+lXkUfBC+n3vf4
         HDEIfKvMgqSZUZqkxoSaAP8E6CaNf/qCr+MwE+mFqfR3Hq0ggihwk+Mp/k9h6iuTc3s/
         DEpQ==
X-Gm-Message-State: AOJu0Yz8c+yfJ5geolrHqbdeNEz4XChQ19T82BscYz4Y0r4FhLdrsaFl
	Iq4ljr8IBlWTvhievWMUuuA8bjioa43ucfhQzA==
X-Google-Smtp-Source: AGHT+IGWiN/N9BAGWojIB0qAzVejGMihsQLlvmYRPw46pFL/rA+/5bitBmN+gvDwjUUUbzgQRsIECuILI6o=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6902:2008:b0:dbf:62da:11ba with SMTP id
 dh8-20020a056902200800b00dbf62da11bamr64496ybb.5.1705106267698; Fri, 12 Jan
 2024 16:37:47 -0800 (PST)
Date: Fri, 12 Jan 2024 16:37:46 -0800
In-Reply-To: <xmqqjzoe8br0.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1640.git.1705043195997.gitgitgadget@gmail.com>
 <20240112074138.GH618729@coredump.intra.peff.net> <owlyo7dqig1w.fsf@fine.c.googlers.com>
 <xmqqjzoe8br0.fsf@gitster.g>
Message-ID: <owlyle8uhxut.fsf@fine.c.googlers.com>
Subject: Re: [PATCH] strvec: use correct member name in comments
From: Linus Arver <linusa@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, Linus Arver via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Linus Arver <linusa@google.com> writes:
>
>> Side note: should we start naming the parameters in strvec.h? I would
>> think that it wouldn't hurt at this point (as the API is pretty stable).
>> If you think that's worth it, I could reroll to include that in this
>> series (and also improve my commit message for this patch).
>
> I am not sure if it adds more value to outweigh the cost of
> churning.  When the meaning of the parameters are obvious only by
> looking at their types, a prototype without parameter names is
> easier to maintain, by allowing the parameters to be renamed only
> once in the implementation.  When the meaning of parameters are not
> obvious from their types, we do want them to be named so that you
> only have to refer to the header files to know the argument order.

This sounds like a good rule to me.

> "void *calloc(size_t, size_t)" would not tell us if we should pass
> the size of individual element or the number of elements first, and
> writing "void *calloc(size_t nmemb, size_t size)" to make it more
> obvious is a good idea.
>
> On the other hand, "void *realloc(void *, size_t)" is sufficient to
> tell us that we are passing a pointer as the first parameter and the
> desired size as the second parameter, without them having any name.

Thanks for the illuminating examples. Agreed.

> Are there functions declared in strvec.h you have in mind that their
> parameters are confusing and hard to guess what they mean?

TBH I only learned recently (while writing the patch in this thread)
that parameter names in prototypes were optional. I got a little
confused initially when looking at strvec.h for the first time because
none of the parameters were named. Having thought a bit more about these
functions, none of them have repeated types like in your example where
naming is warranted, so I think they're fine as is.

OTOH if we were treating these .h files as something meant for direct
external consumption (that is, if strvec.h is libified and external
users outside of Git are expected to use it directly as their first
point of documentation), at that point it might make sense to name the
parameters (akin to the style of manpages for syscalls). But I imagine
at that point we would have some other means of developer docs (beyond
raw header files) for libified parts of Git, so even in that case it's
probably fine to keep things as is.

Thanks.
