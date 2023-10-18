Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0800F15AFB
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 23:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lpGqP+e0"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BAAA10F
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 16:40:40 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 9055A226A2;
	Wed, 18 Oct 2023 19:40:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=tsnOI0+lOUOKoxUAXdrm6XvqXxq2rwp3myvd+C
	2+iL8=; b=lpGqP+e0DtWmuyv8+BKz8kk+uOq5RqGmeYr6g2a8nAeJsDCWXlsSD7
	50MRvuOr/W2Oq4cOz3KnTyMaB5Q2FQJA3b0T3QOV9NZv2Taocc9FaSry3t7lubgw
	BW1pGKJenNRbLC22w/FXeUEXPixoY+aIRztF7QYRumUTdTOAyPFQs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 88FD9226A1;
	Wed, 18 Oct 2023 19:40:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0CA81226A0;
	Wed, 18 Oct 2023 19:40:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 00/11] t: reduce direct disk access to data structures
In-Reply-To: <ZS9vp9dnoVVUsMIt@tanuki> (Patrick Steinhardt's message of "Wed,
	18 Oct 2023 07:39:51 +0200")
References: <cover.1697607222.git.ps@pks.im> <ZS9vp9dnoVVUsMIt@tanuki>
Date: Wed, 18 Oct 2023 16:40:35 -0700
Message-ID: <xmqqlebzzeh8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BD11AD70-6E0F-11EE-B5F9-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> As usual, I forgot to mention that this applies on top of current
> master, which is at a9ecda2788 (The eighteenth batch, 2023-10-13) at the
> time of writing. I look forward to the day where I remember to include
> this information in the cover letter...

I heard rumors that we have a --base option that records such a
piece of information in the format-patch output (I haven't used it
myself).  Would it have helped, or perhaps it still needs some
usability tweak?
