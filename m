Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D39D17BAE
	for <git@vger.kernel.org>; Sun, 24 Mar 2024 16:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711296912; cv=none; b=nc6U0YhOYHbCKImHtuxt3+tdIGQBWJu375tvSfZUJjH43jn73TkgNO8B0R9vJOov26YzCoNFHY5aSiYaTp4FQ604qwZhtaqvDzdJEpsXO8ShvA/DQuCoMN5MAFX8FSoZeZ0SqBrRC2DvUibU1ofnu196o9vSaRZzaqIa52uowYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711296912; c=relaxed/simple;
	bh=o0od89pQMBiDuDw8I5KU4s6YPAtmuixUChYmGsUO1f0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZrgK9Yy/rZViyjFFpO4kJ1CpnpEp/QQXjbm4zeSsFcktDAzlf9nFWshd83GArDPRxa5K4yPfmEO6GMygpOlIyPzgcNHUkXWQsAqla5Gb/L8Mrxdm57CvdMcJnsaWTfstpjhIO3SORIh5jKbzzl1Iktsmw21ELLA0G0ZrekBEJ2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=KHQDXISC; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KHQDXISC"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 511B21D792;
	Sun, 24 Mar 2024 12:15:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=o0od89pQMBiD
	uDw8I5KU4s6YPAtmuixUChYmGsUO1f0=; b=KHQDXISCtkbDO0m32hvrUsW/MmSR
	bgkmrTgeiciZ2bQnJVyvQDUZfpJ/1S35dqd0X0zT8gMgQnVr6rriKDvRvItbz8EU
	gcsqcX8DTTGPMZ/7F2MgHP7467osSsZ5nBj16OFr1hUUz/d2aOqFssG/jM6Pt6o6
	Ij5iqMlHOOFWV0s=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 48B191D790;
	Sun, 24 Mar 2024 12:15:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EF9FE1D78F;
	Sun, 24 Mar 2024 12:15:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <avila.jn@gmail.com>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org
Subject: Re: [PATCH] doc/gitremote-helpers: fix more missing single-quotes
In-Reply-To: <1812061.VLH7GnMWUR@cayenne> (=?utf-8?Q?=22Jean-No=C3=ABl?=
 AVILA"'s message of
	"Sun, 24 Mar 2024 16:41:00 +0100")
References: <20240320091748.GA2444639@coredump.intra.peff.net>
	<22254967.EfDdHjke4D@cayenne> <xmqqmsqov0at.fsf@gitster.g>
	<1812061.VLH7GnMWUR@cayenne>
Date: Sun, 24 Mar 2024 09:15:04 -0700
Message-ID: <xmqqv85bsj1z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 AD60B810-E9F9-11EE-90ED-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Jean-No=C3=ABl AVILA <avila.jn@gmail.com> writes:

> I will change the CodingGuidelines in another patch series to add more=20
> litteral formats in the synopsis and in the terms of description lists,=
 so as=20
> to converge toward the generally accepted format of manpages.

OK.  Thanks.
