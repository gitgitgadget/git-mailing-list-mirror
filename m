Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CD810A01
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 02:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711075476; cv=none; b=lkmOuLYHdJEMOKNf+LM0hChcbEWL5nOAjrQl17rtNJWlyC13zS+O9ixKI7mRYIjTU5RtSqr7QTAZUrRf7rx+MYmc+UEFjsvGzRMAYHY+dSFHQ7itIMM3X29/58kqAu6NVbzGn4pRvUoXK33lZZfbdF9PjUVF52Vq7hWBgF1tvQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711075476; c=relaxed/simple;
	bh=N+fW06OD2Y2FGOx3djlESW32TB4DGi5OFbXyzRhp+Eo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dpdiloLdoK8S4qcgAWyeqdxhPeuzH16J/sAP1w8N+8TwBOq5wr+oG4WtYdqK03PaNA3KwoZ/06434JdCTzBCK1vQdwtuRVaR/rtIVS5Cs1AnHdorsMycyF3GU/O/D3Sg3HjIiyqYrfR0JHYeplEK2J6z1a3lxiTTaMp8UOTBQ5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=RPghwSWi; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RPghwSWi"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2C2DB1EF974;
	Thu, 21 Mar 2024 22:44:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=N+fW06OD2Y2FGOx3djlESW32TB4DGi5OFbXyzR
	hp+Eo=; b=RPghwSWiSesdjdBCupwPU/AwxFUVH3/VgYwvx1ko6dXyMt2eJZIGOW
	QCQUbMfdG4D0ElYxA6K4cL8DX7tW29dFt9C9lUJOO/wJTY1nmGFBlGiAe48q8k/d
	+HsZTiRB7DkKi+VLfVYj0Uac8YPVkAJ03q+2sZp5YrP0l1tjGYB9M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 22AAC1EF973;
	Thu, 21 Mar 2024 22:44:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6A7D51EF972;
	Thu, 21 Mar 2024 22:44:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Brian Lyles" <brianmlyles@gmail.com>
Cc: <git@vger.kernel.org>
Subject: Re: A note from the maintainer
In-Reply-To: <17bef592f076ab87.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
	(Brian Lyles's message of "Fri, 22 Mar 2024 02:35:19 +0000")
References: <17bef592f076ab87.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
Date: Thu, 21 Mar 2024 19:44:26 -0700
Message-ID: <xmqqr0g33rzp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 19B7C734-E7F6-11EE-9091-25B3960A682E-77302942!pb-smtp2.pobox.com

"Brian Lyles" <brianmlyles@gmail.com> writes:

> I think that makes the intended meaning much clearer. Minor spelling
> correction: s/mearly/merely/

Thanks.
