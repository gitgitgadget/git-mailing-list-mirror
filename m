Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C481799D
	for <git@vger.kernel.org>; Tue,  2 Jan 2024 22:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="UXiM7Qi1"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3bbf67d619cso1874491b6e.2
        for <git@vger.kernel.org>; Tue, 02 Jan 2024 14:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1704234311; x=1704839111; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pLFpmjgqqhwFRzPU2FmcUMywV074PLZimD20jT67VlY=;
        b=UXiM7Qi1QS/5IjODcqTcGJ5ulcYbTBjPbd3022pZujmboffzI3TICo/foqcB6zkYFL
         CfOioozNSCmuU0bzhJi7ji7/HlaUY+HA7/yfwVnrKPHpxbqkJP8OgU0pnU/zJ+ZlFBY6
         KSKut6SKuBimz6tF0j5tooWVrrE7RVRxYmIHG734T2bmTO+wGxyWR1aPcZcvqoCfuu3K
         iEpgp14oJRAkschSASjsZ7k1Sdyt+nBKnHfJsHi9VXZF9SVsIP2dQR03rUU7LS2W8s7E
         Cfr732QICyDds0MfOADzo9ttjBa8Fgs4IMhC/OpKmF5MxS0ljjzqm9Q0NVfpbH4LSXai
         r7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704234311; x=1704839111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pLFpmjgqqhwFRzPU2FmcUMywV074PLZimD20jT67VlY=;
        b=WZGeXxofKUEgoToLLBbDUYrA89YmZ722+Epn25h36zdRFde6acMIDGKs7LgBeUMlFb
         u2ULz7spob+emIHaHJ63FICGfJgl88T4OXr8ZoKhp1V5rSlQ7+/+YThdzn6z5A5vKxqs
         7gBRnEQde8vFX+tRtRIOJuqrApynu7Koq5bpu2AVlSHxoqKogpNIgwXn5dWVsO6KSBAq
         ihbydRXFIYUA6hVcVeLaTGDW7pNKgeortzRKTlm47L+f/AP3Uah8wM+FksrIVXfOihP1
         PBmX6BeraUdu0rWjUPvKAXDhy0SgYUIMSDh4YCYLxmk83vOU2kvgoAowSgKRsK15Z+gZ
         Xd9w==
X-Gm-Message-State: AOJu0Yy5DjWiB9kwPLY+naQ4VPGobqSVLVm7aAlEhXcFyuN8u+Qb1eol
	0EO4c6/F6tkpymhdmIsiEXtdCpLXYZIEYg==
X-Google-Smtp-Source: AGHT+IGzbltrCAo/yFGf44SkWa4A/HnuRo8hAJa3JxnEo5KV+c3I68nx+whPHbUXmhNyBXtZUBQl7Q==
X-Received: by 2002:a05:6808:1156:b0:3bb:aaa4:3df1 with SMTP id u22-20020a056808115600b003bbaaa43df1mr10982274oiu.110.1704234311535;
        Tue, 02 Jan 2024 14:25:11 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a9-20020a056808098900b003bbc2bc270csm1954321oic.44.2024.01.02.14.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 14:25:11 -0800 (PST)
Date: Tue, 2 Jan 2024 17:25:10 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jakub Wilk <jwilk@jwilk.net>, git@vger.kernel.org,
	Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-clone.txt: document -4 and -6
Message-ID: <ZZSNRk6W7VC23LaC@nand.local>
References: <20230527123849.5990-1-jwilk@jwilk.net>
 <xmqq1qivd8d0.fsf@gitster.g>
 <ZZRqgmDycyAXCrGZ@nand.local>
 <ZZRzxZNb2Aq+2feW@nand.local>
 <xmqqr0izcrfm.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr0izcrfm.fsf@gitster.g>

On Tue, Jan 02, 2024 at 02:15:57PM -0800, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > Note that the 'clone' and 'fetch' versions for many of these options
> > have different wording. For example, in Documentation/git-clone.txt we
> > have:
> >
> >     -j::
> >     --jobs=<n>::
> >            Number of parallel children to be used for all forms of fetching.
> >
> > Whereas the description in the original fetch-options.txt is more
> > verbose.
>
> Yes, so it will be impossible to unify without changing the
> resulting text.  But unless one description is clearly better for
> one subcommand while the other description is also clearly better
> for the other subcommand, we should be able to pick a better one
> that would serve both subcommands, and that way we would improve
> description for one subcommand while keeping the other one the same,
> right?

Right. I meant to illustrate merely that this would probably involve
some word-smithing instead of just pure cut-and-paste, so that it may
not be worth the effort.

Thanks,
Taylor
