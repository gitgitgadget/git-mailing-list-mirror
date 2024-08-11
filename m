Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF4917552
	for <git@vger.kernel.org>; Sun, 11 Aug 2024 17:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723397225; cv=none; b=ltz2w803jOi1FK8yqgsaujNzekdif0/aS2q5hZUXAeGHj0S/AjhQUefXIvPoji/wFo1dfhVZRToD+mleXTRxLWYFRQAYGpcz4SqP51uYlnLFSzsXYR2v8EahXuYHNPv02oDNptjW4nuCBN1L9hlJ6mVT502p4wVhqY9bfz77GA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723397225; c=relaxed/simple;
	bh=PaMdnjG4e6xbU7XDD2mhlEdtTtUDYLC5qCofozqrDQ4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=hjKInFd8r2nRVSGh0GvBi/hkc0VO4sR5kkwQD6WaeVNgDp6sg34FhAWSUv6N+pK45QRGo+o8Xq/AoCtMeDlInv6Su1CaEx2j43zWth2NSte33GwKg7Ok3fJ2TdwOwqvvZ68ViYSM+dXHE/Ynz0CIbNQGKPhey48U21Gc4vGFsT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=x4NiKZVj; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="x4NiKZVj"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1723397213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FYXlv2o0rCGvBGlF/p0+zvchJkJ36MmupBIbopalvpE=;
	b=x4NiKZVjQxQquWlbTZKcOl6R71BqSZn04MWqvmDHHXvZR2Xz9/0OkplZHHIAMgXESBRJE1
	AjsvoJbRB1pB5zqbo2Qw2PdgUn4KD0SbAy0nPaDsfYyIN4Jhx6z3MkTCw8bv5aoOk6hxMK
	EyNmQLNpxjlQNdlsu7F7kN9T2eBfUhP65EBlQOluDYGUdE6q0Y8W/98lCz4T8CfYb4uq6R
	quE4YQJnb/5ujbLUCaIo5SdsXgpUTby9jybqM4q+KJK+JImugqTdANqupqhVbQP3TBhR0a
	cyZG35wx5fiqx+9Dm4MXMfBh4Lq+Sl9if4/J8/tuLJHCmSJ6Kgbh580G9jWCyw==
Date: Sun, 11 Aug 2024 19:26:52 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
 calvinwan@google.com, spectral@google.com, emilyshaffer@google.com,
 emrass@google.com, rsbecker@nexbridge.com, gitster@pobox.com,
 mh@glandium.org, sandals@crustytoothpaste.net
Subject: Re: [PATCH v2 0/5] Introduce cgit-rs, a Rust wrapper around libgit.a
In-Reply-To: <Zrdn6QcnfmZhyEqJ@zx2c4.com>
References: <cover.1723054623.git.steadmon@google.com>
 <cover.1723242556.git.steadmon@google.com> <Zrdn6QcnfmZhyEqJ@zx2c4.com>
Message-ID: <6398d60387a6607398e4b8731363572e@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-08-10 15:15, Jason A. Donenfeld wrote:
> Still the same name for v2? Cmon.

Yeah, I was also surprised to see that.  This _isn't_ cgit.
