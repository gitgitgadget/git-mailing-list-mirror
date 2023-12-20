Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960BD46558
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 16:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="h561lFgD"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4152F2E127;
	Wed, 20 Dec 2023 11:31:55 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=yTw7qzBLBujapFT3EKKWO0ny69Cmbbn96WiYZ4
	jFzOc=; b=h561lFgDYCvuVmT2O+9Fgwi1chs/91eiThiKz693MyGgto2knRXmi2
	Djdo8cEnV5XqSPH3U2zdeH1JyHenEcDLqnuVkFGWYHahJc58+BTAmFjuAbfGHgiB
	fUcyKklHZWP/VBagobVwhXDzYoV4VDgSWb6YFyLSwyTRuzyDI9cBk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 387072E126;
	Wed, 20 Dec 2023 11:31:55 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 29A0E2E123;
	Wed, 20 Dec 2023 11:31:50 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Josh Soref via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Josh Soref
 <jsoref@gmail.com>
Subject: Re: [PATCH 4/8] SubmittingPatches: update extra tags list
In-Reply-To: <35fc350d-018a-49cf-a28e-e5ce21fe7dec@gmail.com> (Phillip Wood's
	message of "Wed, 20 Dec 2023 15:18:20 +0000")
References: <pull.1623.git.1702975319.gitgitgadget@gmail.com>
	<e5c7f29af439c48f59b2f35af93a7972e66a5b6b.1702975320.git.gitgitgadget@gmail.com>
	<35fc350d-018a-49cf-a28e-e5ce21fe7dec@gmail.com>
Date: Wed, 20 Dec 2023 08:31:48 -0800
Message-ID: <xmqqh6kcu96z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 46AD36AA-9F55-11EE-8079-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> What's the difference between "Improved-by:" and "Helped-by:"? In
> general I'd prefer for us not to encourage new trailers where we
> already have a suitable one in use.

I agree with the direction to limit the trailer tokens to common
ones, as the repertoire we have sufficiently covers the needs
already, and strongly discourage folks to waste their time trying to
be "original".

It might be useful to run stats of trailers that were used in the
past, say, 3 years and that may give us a good guide to decide which
ones to limit ourselves to.

Thanks for reviewing.

