Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=157.230.60.252
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792487601;
	b=mCbUvASKWcaAv1Lr9N7hmxWChacRmMmNUpowAo7CnXw72R9upUPwaYMm2rLELInymb4r
	 /WFX2sOyL7h2LVBAJ6czidrqzEim8AqpUjTSidWh3+HiyLy05xx1iRpoxj+YA+y5FwM7B
	 lC3MsQTB38RwU3mRIy2kg7w3/ZVJm8RqI64vQYZKdcU4xlGgG0dQziW92CHNIQaPaG+Jy
	 olsr6Uj9PmawDuHRGlDPq82ZMErRF8I6S0gHuOHCXxahR8SQ/BEK7PCuvK/GmUBl5wPCs
	 SAksr2dUvBqjJAs7kfDyZ4CuqAP5LAuxdkO7vHGNGIPVUEKOxFLbg8cRT7KLn9WbjBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792487601;
	h=DMARC-Filter:DKIM-Signature:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:To:From:
	 Subject:Cc:X-Mailer:References:In-Reply-To;
	bh=HtkdE+ttN4l02Cff81RNj/qjPctHWr14LjOJ9Ie+MuY=;
	b=e3k0Dzy60tPIdXNFIRnGxKSufO6ZluUd1Pu+4OACgMBumKgCbGb5rfF3TY0ukGOxtVQm
	 wqPw0e6/jMuyk3AprsKPVjYM1DhS6CDU1Ofany+Ta7tmwuP4culz5sb5slpTEXlreKfYY
	 o1aszCM1Cdgurr6fi7apyk0NwQywyzTNOvw4ktwUMCEqvHxD4DlCRDkcMKxYW4e7ljQJ2
	 m2Pg1zd48SiaecuBq4k6J7kq/plXuHmacv//XZUVyLtvmIjM0zpDq2WrQr8zNh6X3tPKy
	 LA9VKBI2YGyX31pXlblXi3HIKo+1akAbPqeXEba/piZ2oRIM4PZSPTiMxFz6+37fYnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lfurio.us;
	spf=pass smtp.mailfrom=lfurio.us;
	dkim=pass header.d=lfurio.us header.i=@lfurio.us header.a=rsa-sha256 header.s=default header.b=btiOOjrg;
	arc=none smtp.remote-ip=157.230.60.252
Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA02A606A31A
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 09:13:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA02A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lfurio.us header.i=@lfurio.us header.a=rsa-sha256 header.s=default header.b=btiOOjrg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1792487599; bh=rbJ9BmebXykbOlJduXHl/ltvrvl6lUwc4Y2W5/Jp62E=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=btiOOjrg1ZdzKtrtKnDFDdxApx/Nuhr7d12MPeIBxs60mPf8jah2bJC9jLznvZN3i
	 bIyhaTG2ANXMEH0EkJNUaDopVvIWbyQja00JbbEpLB8sJnyqMhGt31s5TXg5UX98Fr
	 zuJt+7I40cFO6vN7649Jl0IrZ96u+5nceKVxpfG8=
Received: by mail.normalmode.org (Postfix) with ESMTPSA id 92DAB619CD;
	Tue, 20 Oct 2026 09:13:19 +0000 (UTC)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Oct 2026 05:13:07 -0400
Message-Id: <DM9JTHREBQOW.3IOHX6OZK3BGQ@lfurio.us>
To: "Patrick Steinhardt" <ps@pks.im>
From: "Matt Hunter" <m@lfurio.us>
Subject: Re: [PATCH] init: show absolute path of (re)initialized repository
Cc: <git@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20261020053932.1274210-1-m@lfurio.us> <atcQb_V69vvKnxoF@pks.im>
In-Reply-To: <atcQb_V69vvKnxoF@pks.im>

On Tue Oct 20, 2026 at 2:55 AM EDT, Patrick Steinhardt wrote:
> On Tue, Oct 20, 2026 at 01:38:47AM -0400, Matt Hunter wrote:
>>=20
>> None of the discussion [1] around the original patch indicates that this
>> change was intentional, so address the regression by similarly using
>> repo_get_git_dir in this code's new location.
>
> This indeed wasn't an intentional change. I also confirmed that with
> v2.55 we print the full path.

And with 2.56 :-)  Output changed right at the beginning of this release
cycle.

>
>> In this case, git_dir is referencing owned memory that is later freed,
>> so declare a new variable to hold the used string.
>
> This sentence doesn't add any value as it simply explains parts that are
> obvious when reading the patch. I'd just drop it.

Yeah.. Will do

>
>> +		int len =3D strlen(full_git_dir);
>
> I was wondering whether we want to fix the variable type to be a
> `size_t` while at it. But maybe we should just keep it as-is.

It's not of consequence to this change, but I agree it would be more
correct.  I'll include it.

>
> I'm a bit on the fence about whether we want to have a regression test
> or not. It feels like a very specific thing in the user-facing output,
> so it's a bit dubious whether it's really worth it.

This is my thought exactly.

> But on the other
> hand, folks like you seem to care enough to make the test worthwhile, so
> maybe we should have one?

I could be convinced to add one.  I'll see if additional feedback comes
in before sending a new revision, but won't plan for a test as of now.

Thanks for the review

>
> Thanks!
>
> Patrick

