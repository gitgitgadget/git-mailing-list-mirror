Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01856F4E5
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 00:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Fj7gC7/b"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9D4CA1B433D;
	Tue, 19 Dec 2023 19:48:41 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=dRJaODACqb7Mr1Opl+r5yXNdbp2I+PDaWjY17/
	R52QI=; b=Fj7gC7/bq2h4Z0P9+9ByLuOofllazm8wz9YQSRxQEdT2kHz3aJahg8
	Tm8FQGCOhs+6j2DEknjAGi1NlcDAVRYMORGv7SCw3DzaX275hP1j6qMpzZynIU2z
	K81l4DHFYMBvyG6LJLYoJS8wfylsj3RMDxkMT3MaX1fYeSBLL4ls0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 94F4C1B433C;
	Tue, 19 Dec 2023 19:48:41 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6C6821B433B;
	Tue, 19 Dec 2023 19:48:38 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Stan Hu <stanhu@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Christian Couder
 <christian.couder@gmail.com>
Subject: Re: [PATCH v3 0/2] completion: refactor and support reftables backend
In-Reply-To: <cover.1703022850.git.stanhu@gmail.com> (Stan Hu's message of
	"Tue, 19 Dec 2023 14:14:16 -0800")
References: <20231130202404.89791-1-stanhu@gmail.com>
	<cover.1703022850.git.stanhu@gmail.com>
Date: Tue, 19 Dec 2023 16:48:37 -0800
Message-ID: <xmqqsf3xu2ai.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8360DCAC-9ED1-11EE-905B-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Stan Hu <stanhu@gmail.com> writes:

> This patch series addresses the review feedback:
>
> 1. Renames the '__git_ref_exists' helper to '__git_pseudoref_exists' in
>    the first refactor patch.
>
> Stan Hu (2):
>   completion: refactor existence checks for pseudorefs
>   completion: support pseudoref existence checks for reftables
>
>  contrib/completion/git-completion.bash | 43 +++++++++++++++++++++++---
>  1 file changed, 38 insertions(+), 5 deletions(-)

Thanks.  Will queue.
