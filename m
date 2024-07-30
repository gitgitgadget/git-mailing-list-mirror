Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD541AA3C3
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 20:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722372919; cv=none; b=eeKYwz+8hTaRaLWFkOI47EVcXXhBs0dEJcF9NnQqOfCpaY5u/p7LEZKJDQBLfjRMtFtu/BZYbLWSlJXBq4gak3CvS6phiVCqu8owfGVt0oEXRtYDpTyYd26L65hAPoabxPKwCmEV14+I5wbXAdaNx74PYdLPLk444Rs76vljYUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722372919; c=relaxed/simple;
	bh=Es2d1dHbtgK65brXQGrRyXhIGOYah2fS5zqCOn5NbXw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ItHYZYDt+WxnjqyYwYzwpxANgTKl9wILC5d7HNPmmJqJnVoAQ9w8CMD9lWkg0K4QOZzEdXEr79HRmJbAwvOqlBEhTs3ykwRS35h219JlicbLNzEDgnpO2EjEwxtYCsMclbZH8QJ4R6BL/txCyyyOPE+OPbqC3nz6AsVLfMd6DVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=hnYjB0XA; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hnYjB0XA"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C59D33104F;
	Tue, 30 Jul 2024 16:55:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Es2d1dHbtgK65brXQGrRyXhIGOYah2fS5zqCOn
	5NbXw=; b=hnYjB0XA5HD68Z0k3M9iR9rvIgHXqOZky9c3NWa+gqvnMsJW1n26jM
	bA0DkCcNl5rtuQP0RUYLLu7dYckM03gdDAWgihtHBA5M+Gp+JCmZwsPgu5YddGax
	CwptWOhEgDSHXrv2+4fEctH/I70Xt+TaLw3vu2wc4LLEN3HOuEBoM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BD0CE3104E;
	Tue, 30 Jul 2024 16:55:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 26E0F3104D;
	Tue, 30 Jul 2024 16:55:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>,  Phillip
 Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 0/5] Documentation: some coding guideline updates
In-Reply-To: <cover.1722323818.git.ps@pks.im> (Patrick Steinhardt's message of
	"Tue, 30 Jul 2024 09:24:29 +0200")
References: <cover.1721818488.git.ps@pks.im> <cover.1722323818.git.ps@pks.im>
Date: Tue, 30 Jul 2024 13:55:13 -0700
Message-ID: <xmqq34nqbnwu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 054DA24C-4EB6-11EF-B609-BAC1940A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> this is the second version of my patch series that aims to improve our
> coding guidelines such that we arrive at a more consistent coding style.
> ...
> I think I captured everything that came out of the discussion, but
> please let me know in case I misinterpreted or forgot anything.

Nothing jumps out at me as wrong/missing in this version.

Will queue.  Thanks.
