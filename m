Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA22D12FB3E
	for <git@vger.kernel.org>; Fri, 17 May 2024 17:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715967375; cv=none; b=mYzw4pYQf/18x3NjX6WG7lbaIgm0zF01ZJrcLNgxvxZTb1GX1itYmktWSdgpxxwgcBs2YDNjq1mfUTeAfrAw9BZiBQvUKeTimYhuGWJzQ9SEbeCJOrSNcpMQWNUn5Xt0pen724LMn1ySgRkHQPWkDhY/w4Cbu49x+1eVkfNcY9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715967375; c=relaxed/simple;
	bh=rcfx+sV5qCoGOTa7ttDW4b/EnGcWCzTfEWOVzPClcQc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k0052xggnHpmWyQmGPS9woaOedTI3uTfLT+7OWpjyjZ1SOLmWKfO9RLsUojGaxJTgWCfb3UWIq3z3JmIi0P9E9tuKfIuOI4VYEZieHMW1bxestiMsUqpEdNM+6p5kYB+nM+GiIjhUi5BCnanP84M2Saaajjfmt3KbhgVrS7XK+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=demkQzpy; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="demkQzpy"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 66FA92F669;
	Fri, 17 May 2024 13:36:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=rcfx+sV5qCoG
	OTa7ttDW4b/EnGcWCzTfEWOVzPClcQc=; b=demkQzpywZFbphmVavVTgu2zgovK
	ugvyvCuoI3ws79kWCTgmfUTPMwkjDn0v/MfAd6m73KUJnUthA3rIxN0/6IqDv0OP
	4kgrpdlA4ETEUGh7CaVTA7t5Vufo+WjhujW6mcirBglpsU4Glu6QWw14854Iewuf
	HV1dzEqwC6qbFHo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 60BE02F668;
	Fri, 17 May 2024 13:36:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C65D02F667;
	Fri, 17 May 2024 13:36:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl?= Avila <avila.jn@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] SubmittingPatches: advertise git-manpages-l10n project
 a bit
In-Reply-To: <be7006b2-b9a8-468c-ab89-76bbd83dade0@gmail.com>
 (=?utf-8?Q?=22Jean-No=C3=ABl?=
	Avila"'s message of "Fri, 17 May 2024 16:34:23 +0200")
References: <xmqqv83muc12.fsf@gitster.g>
	<be7006b2-b9a8-468c-ab89-76bbd83dade0@gmail.com>
Date: Fri, 17 May 2024 10:36:09 -0700
Message-ID: <xmqqwmnsibna.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 F35938E8-1473-11EF-98F8-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Jean-No=C3=ABl Avila <avila.jn@gmail.com> writes:

> Acked-by: Jean-No=C3=ABl Avila <jn.avila@free.fr>

Thanks.
