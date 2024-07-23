Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FF415748A
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 16:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721753028; cv=none; b=hwTqwhY+pRpiKfr4QA+3dSWDm8s0IjP1o2cf6nJigdn26lK7W/9ijrEqyVWccLzG3eQmjLc+uGroz0hBjWWXXa267TRqHu/2j57fhW3PydFxY1j6tPwa5G8L8TiwMofzj+UZbLcqrs59dGOWa5pVPThboURWvyV6UWo8Bm5/JGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721753028; c=relaxed/simple;
	bh=XgIBCgxjT8bKHvwq4R3b7WVty8qlN6BlD28Z7y4vWfQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WmEaeceN3/Dn6TEnMW3w97n4oJ1mvF5AMUszfht4KYXJd22IRVTl57n8AEuHmKlH7qbJATSV09zbxOZDbuBLBOiNyKFTgLGn24431x1UfuqZ8JIcbYHNXq9D4P91/gS5oQtxmbuRpyFH1BlbHFAMjRgam+2elsXoCIjVzwON2rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=d5Cy1Ymu; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="d5Cy1Ymu"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 50DA72FFC0;
	Tue, 23 Jul 2024 12:43:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=XgIBCgxjT8bKHvwq4R3b7WVty8qlN6BlD28Z7y
	4vWfQ=; b=d5Cy1YmuYBbtgSA1qUpf/CrrwsgyGYdLFvJ4zG6XJ8NcdX6ZRH7SVd
	T8jIiMZY2PSITgzkhneIiWFwAoCqRPiFwzGr+LKuu71HsTOd0jreLEb+GgmDe/QW
	F+m/MdoB1VQGDx8CvVLjAZ2+pUNb4quwXi/WL5Lb1jU2cGJWL8/8Y=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 4AF452FFBF;
	Tue, 23 Jul 2024 12:43:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BBE9C2FFBB;
	Tue, 23 Jul 2024 12:43:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] Documentation/RelNotes/2.46.0.txt: fix typo
In-Reply-To: <f5d6ded8f6001415802a25ac7728ed43f8905cde.1721685769.git.me@ttaylorr.com>
	(Taylor Blau's message of "Mon, 22 Jul 2024 18:03:09 -0400")
References: <f5d6ded8f6001415802a25ac7728ed43f8905cde.1721685769.git.me@ttaylorr.com>
Date: Tue, 23 Jul 2024 09:43:41 -0700
Message-ID: <xmqqmsm82h4y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B8A4DE04-4912-11EF-9D99-9625FCCAB05B-77302942!pb-smtp21.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> The sentence describing changes to the bundle URI mechanism ends in two
> '..' instead of one '.'.

Thanks.
