Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B2B10944
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 17:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="n03OoM3f"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6020C1B78E9;
	Thu, 28 Dec 2023 12:04:55 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Nm8OoptUoALEySTzN6G5W9hA7uYbQzGv1uwGq+
	JWyQU=; b=n03OoM3fpqd1hX8tAeQjdHsqJnkFhTHYx6cy60sdb2ngjxVgwgiWkY
	wg2AERWtHJs71RgiaGcqc7njNI4O5Las7lIgWrGx21gpJnBq7N7e3KQi5Xle8kLe
	4LbJgVria3y5Rhws3zRmrSrs0FLQQeC2Dj31m1q3O+r+O+GWvGm7Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 462541B78E8;
	Thu, 28 Dec 2023 12:04:55 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9704E1B78E6;
	Thu, 28 Dec 2023 12:04:54 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 8/8] reftable/merged: transfer ownership of records
 when iterating
In-Reply-To: <25a3919e583a9d13403b8add92260529e19e08fb.1703743174.git.ps@pks.im>
	(Patrick Steinhardt's message of "Thu, 28 Dec 2023 07:28:09 +0100")
References: <cover.1703063544.git.ps@pks.im> <cover.1703743174.git.ps@pks.im>
	<25a3919e583a9d13403b8add92260529e19e08fb.1703743174.git.ps@pks.im>
Date: Thu, 28 Dec 2023 09:04:53 -0800
Message-ID: <xmqqtto2gswa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 38CE3C4C-A5A3-11EE-AD34-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> When iterating over recods with the merged iterator we put the records

"records"?

I commented on a few patches in this iteration that I found a bit
harder to follow than necessary; aside from these small nits,
everything in the series looked quite well explained and executed.

Thanks.

