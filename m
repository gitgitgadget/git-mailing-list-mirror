Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F831514D6
	for <git@vger.kernel.org>; Mon, 22 Apr 2024 15:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713801260; cv=none; b=OAOOwqQn1cl8f474a04AiJz3Dm+nth0g9BJt2432Q4jPpRa9hYo3oHOmW4EhFQzcTzP+MzuvGnW02jj5FsUuJtKLprNfstQ7H25kOiq0qWznC4X+ysImwjZldTVeECRYBbsviTfgePFZuc/JtNW/JJQUwlAh0Df7p4VU1YzP42Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713801260; c=relaxed/simple;
	bh=G+5ikpEeAzin/VcLdZjoigc/cPpx+aOFbErRAVn5qWw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tzRCLPG6mHspyvgoS8z5jvG3QBqJIPf6uNmO12oAnHxSzWdBdKd52n6f+fSu455sbSxyrGcgA4ZR5NL4fkMjmwfKsCZ/z4razBKp1XILO56BNVHMJaXDYIAJ1UIRTRnyK7O3G7WGBSB07pNcuZDl/lsaJRbeJ6XNHInIR9jkCr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=wi+U5dab; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wi+U5dab"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BA2F91F7530;
	Mon, 22 Apr 2024 11:54:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=G+5ikpEeAzin/VcLdZjoigc/cPpx+aOFbErRAV
	n5qWw=; b=wi+U5dabgh3ctTYKpK4V49XIEejYC1PCNU1P/huUz2EGzk9+L/ynJP
	w4UTn9BzvWgokUiX6jW9jUul48VWyYbGF9GGqG3QPCoQueKwWjkTmXnoN461Vy9S
	Zg0B8GwDugziRZ5z2/2cWibzXxdKXMeKkSTtYStxbF/s8fuyp5O78=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B183D1F752F;
	Mon, 22 Apr 2024 11:54:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 09A5E1F752E;
	Mon, 22 Apr 2024 11:54:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/2] docs: improvements for Git v2.45 changelog
In-Reply-To: <cover.1713767605.git.ps@pks.im> (Patrick Steinhardt's message of
	"Mon, 22 Apr 2024 08:34:59 +0200")
References: <cover.1713767605.git.ps@pks.im>
Date: Mon, 22 Apr 2024 08:54:15 -0700
Message-ID: <xmqqr0exxujc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 92EDE93E-00C0-11EF-BC3A-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this short series contains some small improvements for the Git v2.45
> changelog.

Thanks.
