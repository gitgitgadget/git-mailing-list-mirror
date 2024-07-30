Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8031A6196
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 16:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722356969; cv=none; b=auLqjbwE+WokghzsU/Ix5yntFVXn1v4m7aR2wxsWQjlTKn3rrga3xEv05HP8gft3ywivP8pbBsj8Fwh93BXkwzVVsjk46YDyjuus13FDXwjuiXkGE4ZalUpeoZremU0B5eLJUPBRt44VWulNsmJbHOmC5OAG2yxSVmL3P9zge/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722356969; c=relaxed/simple;
	bh=xf0NuRj4nanDacKR3VTKsFdQBnvsLnHNAlQeZeZXzlk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R+M2IRoE/KTdu/hhN79IWlDYfHfPbo/v0svTJcq9/AoVLNKLXrwkyDxuxKBakX06e5DhBqOPP2cVmSS+PfTEVf97gT7SV+jyJ5/YMTTcd6sIT9xS7Wo6Eyt8TS05vpN6+d4YDz6OamyOZ1w3Ka3uzQfiX4YbppxZNzRf6HQMMzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=a0nNFRgE; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="a0nNFRgE"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7475B38831;
	Tue, 30 Jul 2024 12:29:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=xf0NuRj4nanDacKR3VTKsFdQBnvsLnHNAlQeZe
	ZXzlk=; b=a0nNFRgEBYtAq/CEtIKt4Dn0Kb9WyplllcM7PeSN+CGUkEIjxdgBI0
	D/R9sGGhCCdXP3neIetMLYg48whzrLGaz47ozqifyjKtaresxSesFFC9d7r0CfCJ
	d0preC6t+NKdX4E6bwnfAjOREp3H46V6m4B7MfTnuPgX6VFr+QLFs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 6CF6A38830;
	Tue, 30 Jul 2024 12:29:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C92253882F;
	Tue, 30 Jul 2024 12:29:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Informer Team <partners@informer.com>
Cc: git@vger.kernel.org
Subject: Re: GIT by github 2.45.2 is listed on Software Informer
In-Reply-To: <739497c1eefa2c4d99e7ee30393a6e21@software.informer.com>
	(Informer Team's message of "Tue, 30 Jul 2024 06:04:42 -0400")
References: <739497c1eefa2c4d99e7ee30393a6e21@software.informer.com>
Date: Tue, 30 Jul 2024 09:29:22 -0700
Message-ID: <xmqqr0baetct.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E190D61E-4E90-11EF-9781-92D9AF168FA5-77302942!pb-smtp20.pobox.com

Please do not spam our list with commercial advertisement.
Thanks.

