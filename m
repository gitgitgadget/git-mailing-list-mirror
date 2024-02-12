Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65671154B1
	for <git@vger.kernel.org>; Mon, 12 Feb 2024 16:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707756387; cv=none; b=pIsKHw0tzUMFVGPB9Tag+YPDzIe4Jj59QjF066lafbYX/pZLKPy+mSDgjGWUsiVpgwHRoCa6IPH3b+grswx1EGpezyg+ac6JY+lPl51UG4xv4ROj5xjPtaYRJ4rYQ4VF4IaZbsK6n+XZETvs2XNO6Rou1OCzMbj/UpbKRfagJAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707756387; c=relaxed/simple;
	bh=Q8iJtVBaedAiVz/nJMFOzytLkclDkq4esTKfKJ6iLcs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N2NzSZ42z8lVNEP82z6bJjetqhr3g6CMZP1VBRF01wlsGgBP5k+GXJjSR56F0TuHNgsqmtGeKABJDmJYVD20L2cJaMqsErlMLidY4rS1v5K3X4RGZQLt4Biq64ww8NUUFQTG20TM8cc0T0ibza4weJVtXTEQtn1kDZve6sgmnH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=YLSOngvJ; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YLSOngvJ"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C1FBC2FDDF;
	Mon, 12 Feb 2024 11:46:25 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Q8iJtVBaedAiVz/nJMFOzytLkclDkq4esTKfKJ
	6iLcs=; b=YLSOngvJTDtgq2zgUTdOjtg9nuMhGQ7U5ylzJvESKQ3nPuPyjW0sUE
	GBaRo7g47k/seMoiLyq3+V4I3VT1YdEs2IRWhO6XfCL6j0XAcBPSg6ouD3HlUIYx
	fQlTNLV1ETIuV3qLGnKq32QC5gijX8yzSafyE40FcwBBIJf40Gq5Q=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id BA87D2FDDE;
	Mon, 12 Feb 2024 11:46:25 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 617092FDDB;
	Mon, 12 Feb 2024 11:46:22 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci: bump remaining outdated Actions versions
In-Reply-To: <xmqqplx29aze.fsf@gitster.g> (Junio C. Hamano's message of "Sun,
	11 Feb 2024 09:17:25 -0800")
References: <pull.1660.git.1707652357696.gitgitgadget@gmail.com>
	<xmqqplx29aze.fsf@gitster.g>
Date: Mon, 12 Feb 2024 08:46:20 -0800
Message-ID: <xmqqv86t7hr7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 40DF19B4-C9C6-11EE-A774-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Curious that, among all other uses of actions/upload-artifact@v3,
> only this one has been using @v1, which may deserve explanation.
> The proposed commit log message pretends that this never existed.

I see that [v2 2/2] addresses this.  Nice.
