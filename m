Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB1676DA1
	for <git@vger.kernel.org>; Thu, 21 Dec 2023 21:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B38poRgx"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50e270639d9so1600641e87.3
        for <git@vger.kernel.org>; Thu, 21 Dec 2023 13:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703195589; x=1703800389; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fVCymEf4Sy17sIciqwl6ryMelTw/hbpdWl16Qp7J0jE=;
        b=B38poRgxZp17C06b5T6u3cOu/FM81Uzos641/whcp4dC8bvD6mZ0dz6sCY1tb70oO8
         6bmczY8/ynaHdzDDo7V6khqlYYgvPXWb615sYUxxCjOJ6w4xuIRwbfRlpSTuW3VbVQvM
         tTBKmxVIm+/SH0D2NOmSbqngxW4zuwnVHv+0hdwhkis8tWbEc9uBQx3fQ6aGPLI2DYKX
         sbxEg+4wu8ZUftwzEW4ZMexic2oBXxthC3wllSx0DDa7Idm+DhuMjYGH+4vTejtp4bbf
         bwupSs1rAOGB/hbIQTxs9cG74MHpuGpmBfg1tQeN6iqOomZ5ZcXdf0m99oMum/xiPcuY
         FuKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703195589; x=1703800389;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fVCymEf4Sy17sIciqwl6ryMelTw/hbpdWl16Qp7J0jE=;
        b=DfZgrJBlRXqSaOTebW6AXtMpLgXdFUFr7MTllui5by445LHJWMCfnL3Ju8GNoRCFUA
         aWr2EMy4l5v4dEyn9bGxRFU5o/O4A6URp/knrn7pkmQ51wenn1vy2mhVDASj0Eq0Nkcj
         9JT6Vg/ceWyCmJq9gu8fvogzbgtKUBR47X33FAASWwUE6mssiY/8tKKS92hZxCw36VQs
         hOongnErb4kjYiQCJpzYn2nA/iMo57pmCpM43ks8IVI/nvrkvhq/qgr07lznoRb+8U/G
         kBlMNTAYssX6g7MEN0J879fgTeH7lRiqpHj8WWrDKUcY91NaJDhZOxDWn4ytYI2AUfXx
         UhjA==
X-Gm-Message-State: AOJu0YxQ/e/wbX/Eck9XxzYBKCZ20Ht6frxdLPZNlnBUCUW8dF2f9yZU
	ugFDNKvUoWjCW1rG8IU5aTxlBdO6Z/R3YQzCIlY=
X-Google-Smtp-Source: AGHT+IH9gVva0os5Mi0J4Yw5wxilgvoCq2eUULSTdDFmgJ4Q0a2dx97sv+EFy9Gs++L61G72PkfZvvHqXH+SBZhP4i8=
X-Received: by 2002:ac2:4259:0:b0:50e:40bf:e0a4 with SMTP id
 m25-20020ac24259000000b0050e40bfe0a4mr113216lfl.132.1703195588932; Thu, 21
 Dec 2023 13:53:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1623.git.1702975319.gitgitgadget@gmail.com>
 <pull.1623.v2.git.1703176865.gitgitgadget@gmail.com> <b9a8eb6aa4e87cd96fbf2b5d514350508076d756.1703176866.git.gitgitgadget@gmail.com>
 <xmqqedffl13r.fsf@gitster.g>
In-Reply-To: <xmqqedffl13r.fsf@gitster.g>
From: Josh Soref <jsoref@gmail.com>
Date: Thu, 21 Dec 2023 16:52:57 -0500
Message-ID: <CACZqfqCzJf5q2xcfPT3C0YAWS0qNxyQvYikisDokQ5Dw-ZFMww@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] CodingGuidelines: move period inside parentheses
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano wrote:
> > From: Josh Soref <jsoref@gmail.com>
> >
> > The contents within parenthesis should be omittable without resulting
> > in broken text.
> >
> > Eliding the parenthesis left a period to end a run without any content.
>
> Nobody seems to have commented on this one in the previous round,
> but quite honestly, for this particular instance, I suspect that it
> may become easier to read if we just lost these parentheses, as the
> next sentence "You do not have to include more than ..." is just a
> bit of extra material to support the first sentence like the one we
> see in the parentheses.  Alternatively, moving that "You do not have
> to" also inside the same parentheses might work slightly better.

> It might be even easier to follow if we moved the list of "approved
> headers" (and the "You do not have to ... more than one" note that
> supports the "currently approved list") totally out of line by
> making it a side note.

I think, in principle, it'd be better if it was its own thing, but the
structure of this entire section makes this really hard -- I certainly
can't imagine a way to do it.

The laziest fix is:

- The first #include in C files, except in platform specific compat/
implementations and sha1dc/, must be one of "git-compat-util.h",
"builtin.h", "t/helper/test-tool.h", "xdiff/xinclude.h", or
"reftable/system.h".

Beyond that, I don't understand how to parse:
 You do not have to include more than one of these.

(Sorry, I'd like to be slightly ignorant of the C parts of git --
let's ignore that I've been blamed for at least one change to them --
so, I'm not going to look.)
