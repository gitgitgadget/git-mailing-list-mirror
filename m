Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B948E24204
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 23:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wcs9fyDa"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B49F9
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 16:31:51 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 82C7E1C2630;
	Mon, 23 Oct 2023 19:31:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=epErR0DlBHvZR1MK2/R5KEvMh3s7GN14eUtX5Z
	Q5jzk=; b=wcs9fyDaEHmHrYzft6cNOuPAhN9mSh4Bm/AouSHhwRN6geRNyoSrM2
	rpCoUm5HCtmsLTzv67Xeqsm2xW4Ke8guOYFwiRGfhhdlvYVj96LecnV2JLm1/Azw
	s6JG9n1u8i47Hf9R9+TkFsa5Fw/cbTKn1FjInfdettHjw1Kruag7s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 78C161C262F;
	Mon, 23 Oct 2023 19:31:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DD8971C262D;
	Mon, 23 Oct 2023 19:31:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  "Eric W.
 Biederman" <ebiederm@gmail.com>,  Jeff King <peff@peff.net>,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH v5 0/5] merge-ort: implement support for packing objects
 together
In-Reply-To: <cover.1698101088.git.me@ttaylorr.com> (Taylor Blau's message of
	"Mon, 23 Oct 2023 18:44:49 -0400")
References: <cover.1697736516.git.me@ttaylorr.com>
	<cover.1698101088.git.me@ttaylorr.com>
Date: Mon, 23 Oct 2023 16:31:48 -0700
Message-ID: <xmqqo7go7w63.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 56EF1E24-71FC-11EE-9E40-25B3960A682E-77302942!pb-smtp2.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> But I
> think that this approach ended up being less heavy-weight than I had
> originally imagined, so I think that this version is a worthwhile
> improvement over v4.

;-).

This version is a good place to stop, a bit short of going full OO.
Nicely done.

