Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4875876DA6
	for <git@vger.kernel.org>; Thu, 21 Dec 2023 21:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qNBT3951"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 86D1E385D8;
	Thu, 21 Dec 2023 16:16:09 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=UZUPUos9qnqouAVgDT5AN4JaKJ9qZ27WjDsSUr
	JwQtE=; b=qNBT39518UUL62eXMlwV9iixAe915+3//lvYdjb82fhfAZZ7Xzezpz
	MpxI+WjyE5HaqYKGo14zUzg2PyCY55Gs+VHm6HEpYBOcAJ7KN8Rq5bOAH2y980OY
	nzTLh4/rO7xwBj7jZ+32wrBLhorgpxxkS1NGk0cfvdH0eNWKShKZU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7F6A8385D7;
	Thu, 21 Dec 2023 16:16:09 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0FD04385D6;
	Thu, 21 Dec 2023 16:16:06 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Josh Soref via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  =?utf-8?Q?Ren?=
 =?utf-8?Q?=C3=A9?= Scharfe
 <l.s.r@web.de>,  Phillip Wood <phillip.wood123@gmail.com>,  Josh Soref
 <jsoref@gmail.com>
Subject: Re: [PATCH v2 5/9] SubmittingPatches: update extra tags list
In-Reply-To: <8848572fe2c7432ede85e042bc2558fd8b3e8b1d.1703176866.git.gitgitgadget@gmail.com>
	(Josh Soref via GitGitGadget's message of "Thu, 21 Dec 2023 16:41:01
	+0000")
References: <pull.1623.git.1702975319.gitgitgadget@gmail.com>
	<pull.1623.v2.git.1703176865.gitgitgadget@gmail.com>
	<8848572fe2c7432ede85e042bc2558fd8b3e8b1d.1703176866.git.gitgitgadget@gmail.com>
Date: Thu, 21 Dec 2023 13:16:04 -0800
Message-ID: <xmqq4jgbl0iz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2731BE26-A046-11EE-988C-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"Josh Soref via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +. `Co-authored-by:` is used to indicate that people exchanged drafts
> +   of a patch before submitting it.

I am afraid this misses the essence of what Co-authoring means.
You may have shared your draft as FYI to your colleagues, and they
may have tweaked phrasing and responded with their reviews to help
you improve _your_ work, but that may not make them your Co-authors.

I think the "intent" counts more.  If people closely worked
together, exchanging drafts and agreeing on the final version among
themselves before submitting, with the understanding that they share
the authorship credit/blame, they are Co-authors.

> +. `Helped-by:` is used to credit someone who suggested ideas for
> +  changes without providing the precise changes in patch form.
> +. `Mentored-by:` is used to credit someone with helping develop a
> +  patch as part of a mentorship program (e.g., GSoC or Outreachy).

Nicely differentiated.

