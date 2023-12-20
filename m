Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A6148795
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 20:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QNydm1ne"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 118D32F728;
	Wed, 20 Dec 2023 15:01:57 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=lq3bf3SE4cB216rggkKGHx9vMXfs/aClB3S0Y9
	tdhd8=; b=QNydm1nepaZfITZ8Dfxc3wSuj6vUCflFk7gstWhXg/+39cRcJcP/7/
	Jg9RTKKfSvylfWmnLSR74Yc8a7cbIGPKBvgw1BbhdWld5lfZC9pE4s6iFxk1iUjq
	Ic9QObDvppCEaFH7tlqNyox+qUeuCJKB/E/tII9sdsTR97xivN2t0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 09E462F727;
	Wed, 20 Dec 2023 15:01:57 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8A5712F726;
	Wed, 20 Dec 2023 15:01:53 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: Re: [PATCH 2/2] orphan/unborn: fix use of 'orphan' in end-user
 facing messages
In-Reply-To: <xmqq4jhb977x.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	24 Nov 2023 12:10:42 +0900")
References: <xmqqbkbj97a9.fsf@gitster.g> <xmqq4jhb977x.fsf@gitster.g>
Date: Wed, 20 Dec 2023 12:01:51 -0800
Message-ID: <xmqqa5q4skwg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9EE2C5F2-9F72-11EE-89E2-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

The two-patch series, whose second part is the message I am
responding to, did not see much reaction, but since it came
during an end-user puzzlement and was written to make the docs less
puzzling, I am tempted to merge it down to 'next'.

Thanks.

