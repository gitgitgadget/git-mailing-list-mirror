Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955DF2EC57F
	for <git@vger.kernel.org>; Thu,  8 Jan 2026 18:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767896674; cv=none; b=qzzWk4/Hb6U2q7CxTB761Au1P3ip66fEvaDQcXbfWuYqq338u5NNvGMzUSIZ4nH9RA6EV3NmiSf6IQ39ViZbfnwrgDO1b0VD0lJldzSXTJCqRFv/yqvIZxEtvCGaoaPa93WHftdyMI6TK/Sc3TPmeunMlGQtaaIbQ5xisYQ+3c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767896674; c=relaxed/simple;
	bh=Z2kzkCBUnUihIqCpA2J1RKCqONLqrRXsmM8MRjkd4lI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OmPc0ofo+/NpioHC0+Tkn9OiKIJ2kiffcyHN6UUUhfJDPFDSSQIExQi8jwG9L4ofxJxuAqlnaiGXKuPAUrozZRsv9wjWgJxnGOxz30aU0QeFfuNzegDYTIZz8jdIL/X9G6Zk5eU9o6S3Dllvu0IWrnWyLKKJnph9JNsf94X+jxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=rhCRXWQZ; arc=none smtp.client-ip=212.27.42.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="rhCRXWQZ"
Received: from piment-oiseau.localnet (unknown [IPv6:2a01:e0a:d1:f360:6a04:84ce:a474:b0f])
	(Authenticated sender: jn.avila@free.fr)
	by smtp5-g21.free.fr (Postfix) with ESMTPSA id A4D0C5FFA3;
	Thu,  8 Jan 2026 19:24:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1767896663;
	bh=Z2kzkCBUnUihIqCpA2J1RKCqONLqrRXsmM8MRjkd4lI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=rhCRXWQZeGgkb3rHSK0GiFgIuEMb/jG8uwW7LA2etY7snS/irOAtOQzpaW3Y5dTuT
	 DvenX3dxTaWVf0HaiZZUPvr0ITeScsNkwCcd6iZXJLWLZ9LpaEcRFQGcWrhmq//y7w
	 kDUAjmyf/BS2NxBYmAQAEYImTvLZ+RbP6KnrdERLQcGYG2+LyTTMZYk0xz06ISEk5y
	 hCbYtYp0vS0at1Zlm+6yIY1K9mz9Uz/D1EL4+2RlNul+b3f9ak3f9+Ol4pqJcflaoz
	 yyOoNagmDPBPr3Lnl8lDm8N3/5H70GnfFY97q0X5mn15ThwQB7XM+Y/mnNwNwKlmFn
	 GAY32xyciMnGg==
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <jn.avila@free.fr>
To: git@vger.kernel.org, Michael Lyons <git@michael.lyo.nz>
Subject: Re: [PATCH v2 0/2] doc: git-blame: convert blame to new doc format
Date: Thu, 08 Jan 2026 19:24:21 +0100
Message-ID: <2813520.mvXUDI8C0e@piment-oiseau>
In-Reply-To: <20260108153039.658217-1-git@michael.lyo.nz>
References:
 <20260105230220.519303-1-git@michael.lyo.nz>
 <20260108153039.658217-1-git@michael.lyo.nz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Thursday, 8 January 2026 16:30:19 CET Michael Lyons wrote:
> Split and updated with JN's suggestions.
> 
> I tweaked the `--progress` documentation a bit more than requested. It was
> hard to write grammatical English that didn't imply something incorrect.
> 
> Michael Lyons (2):
>   doc: blame-options: convert to new doc format
>   doc: git-blame: convert to new doc format
> 
>  Documentation/blame-options.adoc | 120 +++++++++++++++----------------
>  Documentation/git-blame.adoc     |  72 ++++++++++---------
>  2 files changed, 97 insertions(+), 95 deletions(-)

LGTM

Thanks!


