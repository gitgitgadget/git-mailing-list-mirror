Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F6F28DDE
	for <git@vger.kernel.org>; Thu,  4 Jan 2024 18:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nDNuG2FK"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3CC2E1E6BE4;
	Thu,  4 Jan 2024 13:35:58 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=txaASWVYFHtmDiZsCfafMewxx76Og325zMaSk+
	7wLBc=; b=nDNuG2FKTs8C88I45cfyRooLg1Z+Kj8BxKBjJOSj6GHCxS6zXy20m0
	yzP+p+LNgUfHFSEU1iqr3sCFschzJCIo68eu6Su2W5Ob/yEWcia32cu4EH6eenfx
	iQk8sFmcKapQM9nQLWNH17nCO9EpnDbK8QdRcsNY3udsqgNDtgixc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 341561E6BE3;
	Thu,  4 Jan 2024 13:35:58 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 969FC1E6BE2;
	Thu,  4 Jan 2024 13:35:57 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Chandra Pratap via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Chandra Pratap <chandrapratap376@gmail.com>,
  Chandra Pratap <chandrapratap3519@gmail.com>
Subject: Re: [PATCH v3] write-or-die: make GIT_FLUSH a Boolean environment
 variable
In-Reply-To: <pull.1628.v3.git.1704363617842.gitgitgadget@gmail.com> (Chandra
	Pratap via GitGitGadget's message of "Thu, 04 Jan 2024 10:20:17
	+0000")
References: <pull.1628.v2.git.1704268708720.gitgitgadget@gmail.com>
	<pull.1628.v3.git.1704363617842.gitgitgadget@gmail.com>
Date: Thu, 04 Jan 2024 10:35:56 -0800
Message-ID: <xmqqh6jt6j5f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 19E5F102-AB30-11EE-BAF0-25B3960A682E-77302942!pb-smtp2.pobox.com

"Chandra Pratap via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Chandra Pratap <chandrapratap3519@gmail.com>
>
> Among Git's environment variable, the ones marked as "Boolean"
> accept values in a way similar to Boolean configuration variables,

With "Among" you probably mean that there are many and some of them
are "marked as 'Boolean'", so I'd do "variable" -> "variables" while
queuing.

Other than that, looks great.  Will queue.  Thanks.
