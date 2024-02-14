Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A33128367
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 18:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707935257; cv=none; b=XfcIW0//bHJutQgyUIUVR7n9i2BB6Ikbtj9HmKG/iNU5fzV0Zogb59CCPVR7zeQ9IG7M+icu+c9a7VGAuPZ4V91z/Yy17ziWIrQWBW6pWu8w6uKOwqug2J3CNBuzzRDGciUsNVDKlApSgzoEjyXTNafNfins8ii0KknEuQLtHpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707935257; c=relaxed/simple;
	bh=TKen1XSw0nckBt1OKe8iS9TxcWFnXldSQzmYKrocjwk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T4nJ8VXJjLaF5Nn84Ps/cOh8QZP/M7m894N6sS3csUZ3j+grS4gJ9H44A/pD2CgrbfijzJNXeZfKTHUbaNUt6XVSqQlVJXXgkIVPJ0w5n2iHnFY9F7dKmA8NmksNOmGUwBhptR422vjkZC8PPGUSdUHKY69DI1OIjISRQoibStY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=JfoL1X2A; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JfoL1X2A"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 051551F3BA;
	Wed, 14 Feb 2024 13:27:35 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=TKen1XSw0nckBt1OKe8iS9TxcWFnXldSQzmYKr
	ocjwk=; b=JfoL1X2A9/PlgBUFg9XmXEaTgBuhLbE2zffyK2CTUifugLS1NcctRt
	6UC0DFaRexfkhd7NGo4T3MFSAg3OAWVK1xZkhS/I2aGvmuA/FotQ3z+fRdjcQNbe
	SCesrAQXKvNMSUNZEGG6IQxBTttcCBh8NRw3tQmojF4D1EhevuCKw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id F2EA31F3B9;
	Wed, 14 Feb 2024 13:27:34 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 870A31F3B7;
	Wed, 14 Feb 2024 13:27:31 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jiang Xin <worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>,  "dependabot [bot]" <support@github.com>
Subject: Re: [L10N] ci: bump GitHub Actions versions in l10n.yml
In-Reply-To: <20240214043846.4385-1-worldhello.net@gmail.com> (Jiang Xin's
	message of "Wed, 14 Feb 2024 12:38:46 +0800")
References: <20240214043846.4385-1-worldhello.net@gmail.com>
Date: Wed, 14 Feb 2024 10:27:30 -0800
Message-ID: <xmqqv86qvr3h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B7321B38-CB66-11EE-8301-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Jiang Xin <worldhello.net@gmail.com> writes:

> is only turned on in the git-l10n repository. I will merge this commit
> in my tree and send it to you this Sunday along with other l10n updates.

Sounds good.  Thanks.
