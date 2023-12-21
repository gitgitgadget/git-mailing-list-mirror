Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC3F77644
	for <git@vger.kernel.org>; Thu, 21 Dec 2023 21:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yeDb8s9a"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id B4D253892C;
	Thu, 21 Dec 2023 16:57:24 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=O/QCYXMO1GLFumLwyzKTgTAjHj3PXHQZF6GlDr
	rBpdQ=; b=yeDb8s9aT/dRgnEJXO99nBc72eXf482uiE21DnwRIH106D0EpSADTu
	19VZY55n9G3ViF4jHhwumcQqqrfR+KCI848IMFkHX9Ubg2ejOEGW2qEsUlfKDMjx
	n2QqdFsjhUvYC5BvdR8wYNUHdx3E/WGNuvfsMtvY95w4HkRfP9P8U=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id ACECE3892B;
	Thu, 21 Dec 2023 16:57:24 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 58B583892A;
	Thu, 21 Dec 2023 16:57:21 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Soref <jsoref@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  =?utf-8?Q?Ren?=
 =?utf-8?Q?=C3=A9?= Scharfe
 <l.s.r@web.de>,  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 2/9] CodingGuidelines: write punctuation marks
In-Reply-To: <CACZqfqAtT_M8T3AxbgZrkgi3GtQ=JZLu4wvh3O0C9dFvCU3rWg@mail.gmail.com>
	(Josh Soref's message of "Thu, 21 Dec 2023 16:46:08 -0500")
References: <pull.1623.git.1702975319.gitgitgadget@gmail.com>
	<pull.1623.v2.git.1703176865.gitgitgadget@gmail.com>
	<c0db8336e519cb43767effbe842dc8b97f914a4b.1703176866.git.gitgitgadget@gmail.com>
	<xmqqplyzl1e8.fsf@gitster.g>
	<CACZqfqAtT_M8T3AxbgZrkgi3GtQ=JZLu4wvh3O0C9dFvCU3rWg@mail.gmail.com>
Date: Thu, 21 Dec 2023 13:57:19 -0800
Message-ID: <xmqqr0jfjk1s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 EA96CB4A-A04B-11EE-A698-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Josh Soref <jsoref@gmail.com> writes:

> Junio C Hamano wrote:
>> Nobody seems to have commented on this step in the previous round,
>> but I do not understand what you mean by ...
>>
>> > From: Josh Soref <jsoref@gmail.com>
>> > - Match style in Release Notes
>>
>> ... at all.  The patch text is fine, though.
>
> https://github.com/gitgitgadget/git/blob/692be87cbba55e8488f805d236f2ad50483bd7d5/Documentation/RelNotes/2.43.0.txt#L221

You mean just a single mention of the phrase?  If so, you should
pinpoint it, e.g. "The release notes for Git 2.43 calls them
'punctuation marks', so let's use that here, too" or something like
that.

Unless you are sure that all the issues of Release Notes have and
will consistently say "punctuation marks" and never say
"punctuations", that is.
