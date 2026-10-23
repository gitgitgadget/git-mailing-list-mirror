Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=157.230.60.252
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792758091;
	b=IYxB32WqRnT/SD0MmbLVie0R2yuAKgQqTWUVtW7EDH9zugS3AUqVk9CBzskb0qvKmEnK
	 M+wL5R4ke3k9gyVZixdNsGd7FAYaz2eGfo70espR+dcASRiXc/mw9/ZusAuBVqyjllcBy
	 Jy6746nzBzRyj/NkJhA//rpO4/rjcDQ5EJzk8Z0MURqrceAkg2aPctIw9EN+d/eWok2em
	 BZppeA2mkL6dzzy8Ikg3fzCm8xZxBuHok+DYKmNHssYM4GQEivFwj5IhENZqdIalBI02Y
	 IdhViWnOslk3p4sq5LxOenr09n3LgvMOv5HSrchQDzdrDKGizBl9wZI25aEYVFosRFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792758091;
	h=DMARC-Filter:DKIM-Signature:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Subject:Cc:To:
	 From:X-Mailer:References:In-Reply-To;
	bh=mk2u/ZGaowZeKPAg+cn8K563+dbCXDW1DvbT3fsdTkQ=;
	b=r9OTUJXbI13XxSzqIstC81maQ1EkHfRkWIUweAFFXe7Tb/5SPJWZiHzqexndn3kjJlzq
	 me6CEzSd6YhI09lDoFS0/DHvVvIRexXM3cqKhcsxPH6mSB/775o1WM/o/kmnxz1dj8Z8u
	 GS+WxSfh3tAb5xj/yrdCOEOCp631Lqxr3UqZtLwAmuHNAr0DC9Oa2BrplU7Dgib7tG+Hp
	 grO2KIFpM2mzooPeyyO+agbsGXhvBRo8iVqlmbwSEqI+a5GuL7xB5oGSUzCyBX2S9Unyv
	 E5jdURZzzRKGp3W+KnkRyqV3//iyt66MNfFP6iJfmkZSMLQmu1QNHT/IAy89RTyU5Mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lfurio.us;
	spf=pass smtp.mailfrom=lfurio.us;
	dkim=pass header.d=lfurio.us header.i=@lfurio.us header.a=rsa-sha256 header.s=default header.b=HADmxrY1;
	arc=none smtp.remote-ip=157.230.60.252
Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C38606A31A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 12:21:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57C38606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lfurio.us header.i=@lfurio.us header.a=rsa-sha256 header.s=default header.b=HADmxrY1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1792758082; bh=OmHwsRvXMM7Jx3hcdmguDqJIpJU9NBetwoBSIhAywJ4=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=HADmxrY1SFuWbf6TXrCrHBr1rt7gLzuGaPGBeIbsBMxKffrTqxEEBAh/a7oQr7PUt
	 RQZsO7H5ZqGhfwPtGhCxwepuAcPunkE+g3YcO1o2o7tjU+WUPwHlWWMeaBD1Ef48Cf
	 gYn4JzmWekY6ioOQ48fUYtBgVD/dFbAsH6WB0pT0=
Received: by mail.normalmode.org (Postfix) with ESMTPSA id AFD9B62AB0;
	Fri, 23 Oct 2026 12:21:22 +0000 (UTC)
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
Date: Fri, 23 Oct 2026 08:21:11 -0400
Message-Id: <DMC7P4CPEV2X.25XRRSBEZCFPH@lfurio.us>
Subject: Re: [PATCH v2] init: show absolute path of (re)initialized
 repository
Cc: <git@vger.kernel.org>, "Harald Nordgren" <haraldnordgren@gmail.com>,
 "Junio C Hamano" <gitster@pobox.com>
To: "Patrick Steinhardt" <ps@pks.im>
From: "Matt Hunter" <m@lfurio.us>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20261020053932.1274210-1-m@lfurio.us>
 <20261022120749.3567828-1-m@lfurio.us> <atr-Juww5KZN-ugM@pks.im>
In-Reply-To: <atr-Juww5KZN-ugM@pks.im>

On Fri Oct 23, 2026 at 2:26 AM EDT, Patrick Steinhardt wrote:
> On Thu, Oct 22, 2026 at 08:06:32AM -0400, Matt Hunter wrote:
>> =20
>> +test_expect_success 'init shows absolute path to gitdir' '
>> +	expect=3D"$(pwd)/init-path" &&
>
> I don't think this extra variable buys us anything, so I'd just drop it.
>
>> +	git init init-path >actual &&
>> +	test_grep "$expect" actual
>> +'
>
> I would have tested for the whole message, which is short enough to be
> reasonable, I'd say.

I considered this.  I decided on this simpler version since there are
4 possible messages that could appear at the end of git init.  Do we
want separate tests/assertions to check all outputs

    "Reinitialized existing shared Git repository in %s%s"
    "Reinitialized existing Git repository in %s%s"
    "Initialized empty shared Git repository in %s%s"
    "Initialized empty Git repository in %s%s"

are as expected?

Furthermore, the final path element is configurable as well, though
should just be ".git" in the case of these tests.  I figured, since the
actual breakage was about the appearance of the path, then I would just
test _that aspect_ of the output in this test.

How do we feel about this assertion

    echo "Initialized empty Git repository in $(pwd)/init-path/.git/" >expe=
ct
    test_cmp expect actual

which tests the whole message of just the default case?  The unnecessary
variable you point out above is repurposed into a needed tmp file.
