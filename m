Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F20536DA1A
	for <git@vger.kernel.org>; Sat,  5 Sep 2026 13:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788616383; cv=none; b=i3nKUT8xs0q/sXJKw8Ni1U0uiMm+ZdFWFyxSYi1zvgeiG8uX8CgeCB2Aih+JzzjdZ6f8N3Kp98uDifumPxFlt7LHFJ/Ow5wPQ2AvRpN2iQNnglP+bu5zfoHXbALuKjXMg/FDxGAcHVNKUyZ3R+HDdwDX4QGxWpEVjs0YuQ+Vcdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788616383; c=relaxed/simple;
	bh=B4Blxm7axvg31kGPWLEfY36fpcePuc3U0GT/u0I/0a8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZGIXNdG5hl9xdiNO0liNECROTsrtISW79TQfydFe00A4wDRKobwXFdjWtxaC8Hu7IIXGIp8YvxTNaajWIKaqKkeLN3R6MnpcIdSw5Z0Ao0RMimFRaBKyiPSMFlb2K/70JEtLwrO0YZSt4Tir502ZvU6Zf0Y3YBwSzmuN17f7Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=FhxOFLII; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="FhxOFLII"
Received: (qmail 18717 invoked by uid 106); 5 Sep 2026 13:53:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=B4Blxm7axvg31kGPWLEfY36fpcePuc3U0GT/u0I/0a8=; b=FhxOFLIIHBfuXXHmhT5Xcrf+n0/+kZ+L1GGl35vZSFm97hU3zDSb9hJeyhtEDlN0FknMjFKlJ90zvoRTO26DkO060GVAwj+Ksnr/RGcVrKGBUcK2VNU4Q6aoTq0SIK2186A1FmtYbWZ1xL7jKoTbY1QjOmo4r/N/xBlDdJTy8850FxmrF9ti1iXeIrw6KPUEDUWsEOuEkMnMzV1BuRnOoaDWxrQuKBnIEugnHw5w9pBYGSadC7mLIK2Ku4hwHnlXQKqimC6B3nf0THE4+SEECot26eU/nxngdZxbc86NtgBVEvvKm4BvdI1kV9haeQVc1kyNfxQn2LpAZ+K2C4NdRg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 05 Sep 2026 13:53:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 93099 invoked by uid 111); 5 Sep 2026 13:52:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 05 Sep 2026 09:52:59 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 5 Sep 2026 09:52:59 -0400
From: Jeff King <peff@peff.net>
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc: git@vger.kernel.org, tnyman@openai.com, Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/2] ci: bump ubuntu image version for static-analysis job
Message-ID: <20260905135259.GB3914039@coredump.intra.peff.net>
References: <20260726083254.GA3528497@coredump.intra.peff.net>
 <20260726083905.GB3529069@coredump.intra.peff.net>
 <andoDRDn5RvgNHrl@szeder.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <andoDRDn5RvgNHrl@szeder.dev>

On Sat, Aug 08, 2026 at 07:31:57PM +0200, SZEDER Gábor wrote:

> Using these to run 'make coccicheck' on 630cf86933, i.e. 'seen' on or
> around 2026-07-14, which contained a024a5818c (branch: add
> --delete-merged <branch>, 2026-07-14) with those problematic loop
> counter variables I got the following results:
> 
>   - 1.1.1: 1437.78user 56.66system 2:10.29elapsed 1146%CPU (0avgtext+0avgdata 223896maxresident)k
> 
>   - 1.2.0: ctrl-c after 2.5h.  The bulk of the work was done in about
>            10 minutes, but processing 'builtin/branch.c' seemed to
>            hang forever.
> 
>   - 1.3.1: 6532.81user 106.75system 9:35.04elapsed 1154%CPU (0avgtext+0avgdata 635592maxresident)k
> 
> So my Coccinelle 1.1.1 didn't hang, moreover, it was about 4.5 times
> faster than 1.3.1.  I got similar runtime differences between 1.1.1
> and 1.3.1 when checking e.g. v2.55.0 or current master; in these cases
> 1.2.0 didn't hang, but took about the same time as 1.3.1.
> 
> Am I doing something wrong?   Or is everyone else is doing something
> wrong? :)

I'd meant to circle back to this and get an answer, but ultimately...I
don't have one. I was easily able to reproduce the forever-hang behavior
building locally, and even bisected it. However IIRC I couldn't get
1.1.1 to build at all, so my bisect started a bit forward of that.

So I'm a little curious why we get different results, but not enough to
sink a bunch more time into building and timing coccinelle myself.

Ultimately I think we'll end up on newer versions in the long run as old
versions eventually become unavailable / uncompilable on newer
platforms. So given mixed signals about timing, I think I'd still prefer
moving forward in time as a general tie-breaker.

> On a somewhat related note, for a while now we've been unnecessarily
> installing all the dependencies of the "build and test" jobs
> (compiler, build systems, apache, p4, jgit, etc.) for the various
> static analysis and the 'documentation' CI jobs as well.
> 
> I think this is because 707d2f2fe8 (CI: use "$runs_on_pool", not
> "$jobname" to select packages & config, 2021-11-23) started installing
> all those dependencies for jobs using 'ubuntu-latest', including the
> 'documentation' job as well, though this side-effect was not mentioned
> in the commit message.  The 'StaticAnalysis' and 'sparse' jobs were
> not affected at the time, because they were using a specific Ubuntu
> version, but then 0178420b9c (github-actions: run gcc-8 on
> ubuntu-20.04 image, 2022-11-25) came along and changed the pattern
> matching $runs_on_pool from 'ubuntu-latest' to 'ubuntu-*'.

It has always felt a little nuts to me that all of these CI jobs start
with a vanilla base image and then "apt install" a bunch of packages.
Surely there is some mechanism for caching that intermediate state as an
image, at which point it is "free" to use it as the base for all of the
jobs, whether they need all of it or not (modulo some extra bytes in the
image, but to me that is way cheaper than the run-time cost of
downloading and installing packages).

I know Docker has some support for automatically caching intermediate
image states, but I don't think any of that applies here. From its
perspective, the all of our ci scripts are running and mutating the
container.

-Peff
