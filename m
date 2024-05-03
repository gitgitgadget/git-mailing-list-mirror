Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F1F481B9
	for <git@vger.kernel.org>; Fri,  3 May 2024 17:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714757133; cv=none; b=mc+47LZBSjguvbzDIeWGtTyVSTqcAUWt3f6Xk092F+PXq36uaGnmss/sqnNjij1ChfsgEtKa5LKqqL+xOIYwUYf0jr0zbiYH5nTIYvGPCPJkuilOun3v1879a1iKASFJ8TWPx68lxti4HzzJe2yHQKYdVAT6MrIbGJ+0NDDzPHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714757133; c=relaxed/simple;
	bh=lNrdHCLbJfd8W/s308fZoXfzV3eTHrBRhgr9JycUpCc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bIpoe8ys9BhlZvIaKFi68RChL5P/qW6pc5zTknfrcC7nE10lTUEhcAd1qNWi3ZIckSkRC9PeFgCMBAeU5JOmnF4sngrZuBpjTsPonesr2ol8iNpcaS8+JeB0PcUY2HBOlAH/ngBKepHGzch4RqUWqaqyLV9IB6qS4MqYLRu/gTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=C5/3H+nQ; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="C5/3H+nQ"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BBE9C2A8A2;
	Fri,  3 May 2024 13:25:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=lNrdHCLbJfd8W/s308fZoXfzV3eTHrBRhgr9Jy
	cUpCc=; b=C5/3H+nQtywOJ1NwhFzZjCGE1nC897gcJ22uDjGhLhqYnRT9Nkcg4o
	4kz/nwdmBlNAecBIpDXORhPsueBfJEh24y3gY3O/KiY6+XeO1Gyjatc61qy+HX48
	uiZwV/2Nm4E4dXgtrh5Mpka8sGczS6LsNVG6ik5V+7XG/O5h7i3Ys=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B3B8E2A8A1;
	Fri,  3 May 2024 13:25:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F128C2A8A0;
	Fri,  3 May 2024 13:25:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: James Liu <james@jamesliu.io>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v4 0/3] advice: add "all" option to disable all hints
In-Reply-To: <20240503071706.78109-1-james@jamesliu.io> (James Liu's message
	of "Fri, 3 May 2024 17:17:03 +1000")
References: <20240430014724.83813-1-james@jamesliu.io>
	<20240503071706.78109-1-james@jamesliu.io>
Date: Fri, 03 May 2024 10:25:28 -0700
Message-ID: <xmqqedai959z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 239A7E8E-0972-11EF-990B-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

> Subject: Re: [PATCH v4 0/3] advice: add "all" option to disable all hints

Huh?  Do we have "all" option that disable everything?

