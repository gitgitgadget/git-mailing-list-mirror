Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F7F76907
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 16:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708446174; cv=none; b=Tqko96rFLagHvZ5G9TB4Dfe5Kaedu9gs6+W68Iib4rDUyznGzJ8OVc6tazBokcnT3hYrk6uVdHOpInFkxnfUK40xVR1qdlk2lU/pw3QRSiVlZptsKegA/35V9/IMqWfzo5wPBbWQX6ve411y7ZvdY49Zma5W+NaH+7oOrEcyXZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708446174; c=relaxed/simple;
	bh=YbAmTI4dxr5K5SZCfJmQoxSzOSSeeb7U5Lov8rV1dFk=;
	h=From:To:Subject:In-Reply-To:References:CC:Date:Message-ID:
	 MIME-Version:Content-Type; b=p2Q8OCuZBcU0N52FEO2TQQCqh28rNcJ/X6la3hY0+DWAKicHwiF9sQmI/bkNsUp8mn6402IUcUd2vejVgohTx1FaCz/w5Hgig6K74Vkj/RDqCnhjm12AqasE0gf8W6IBlCxGH/FtrcCEdAAjT+yNuodPd/FTmvKviWlJSwkMaG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=MMjsNfYN; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MMjsNfYN"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 394F12C2E7;
	Tue, 20 Feb 2024 11:22:52 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:in-reply-to:references:cc:date:message-id:mime-version
	:content-type; s=sasl; bh=YbAmTI4dxr5K5SZCfJmQoxSzOSSeeb7U5Lov8r
	V1dFk=; b=MMjsNfYN/d+u9k8RbBBmSwTJeOSDb2o6B1uRPvy3dY3PgWdPG8pkl0
	C10eHeiYz08qHR34M5EhtVSPeDkwspQX4NjzVsVKxj1nIA0aEqtFAkChaowOje2Z
	T8zqPSVqpU+OIg323CQQMa3Uu8s5Q4/aVtL1/TozZp4/7F61Nxnbw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 31E032C2E4;
	Tue, 20 Feb 2024 11:22:52 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BFAFB2C2E3;
	Tue, 20 Feb 2024 11:22:48 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Subject: Re: [PATCH] documentation: send-email: use camel case consistently
In-Reply-To: <33abb630c1d089e39ff48f04e586b1c0@manjaro.org> (Dragan Simic's
	message of "Tue, 20 Feb 2024 07:41:29 +0100")
References: <b0577267402f6177d8ba5646e12d7691437e6e8f.1708060779.git.dsimic@manjaro.org>
	<xmqqv86kx8h0.fsf@gitster.g>
	<33abb630c1d089e39ff48f04e586b1c0@manjaro.org>
CC: git@vger.kernel.org
Date: Tue, 20 Feb 2024 08:22:47 -0800
Message-ID: <xmqqo7cbt8a0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4998C7DE-D00C-11EE-AF59-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

> Though, "CC" should remain written as "Cc", because it's the way email
> headers are capitalized, which "Cc" refers to.

E-mail headers are case insensitive, though.  See above ;-).
