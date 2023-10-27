Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7E31A733
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 13:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UxdC4Ic1"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3ED218F
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 06:04:25 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A50322462B;
	Fri, 27 Oct 2023 09:04:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=i6Vdn8TmN7VfMaApmiIHvJ29tt5pTBq9eKXJXl
	KXv+s=; b=UxdC4Ic1r30fuudx7MtKWkd0Yh6pkhCo2KVJ2g39Yv+W/EDAvX2Lzm
	6yjMNCNUxe8Jk4ugd+mRmAc0vR25zusE6cVonaK26bKs9XivzNjSNoc9DuwfMTR3
	9UZJJUkaS5GSSoy5uYn3dqTfRdvLkiLLAHDkdPvOBq2AHiwHjKqMU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 9D7372462A;
	Fri, 27 Oct 2023 09:04:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6EA3524628;
	Fri, 27 Oct 2023 09:04:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: Jonathan Tan <jonathantanmy@google.com>,  Taylor Blau <me@ttaylorr.com>,
  git@vger.kernel.org,  calvinwan@google.com,  glencbz@gmail.com
Subject: Re: [PATCH v3 0/5] config-parse: create config parsing library
In-Reply-To: <ZTluW0Ha2W4NYaJd@google.com> (Josh Steadmon's message of "Wed,
	25 Oct 2023 12:37:51 -0700")
References: <ZTbK3QTJYXxYj/M6@nand.local>
	<20231024225005.1191555-1-jonathantanmy@google.com>
	<ZTluW0Ha2W4NYaJd@google.com>
Date: Fri, 27 Oct 2023 22:04:19 +0900
Message-ID: <xmqqjzr8p67g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 585B456A-74C9-11EE-98E1-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Josh Steadmon <steadmon@google.com> writes:

> Thanks everyone for the revived discussion here. I think I agree, this
> series is not going in the right direction. Additionally, our internal
> use case for this change has evaporated, so let's just drop the series.
> We can pick it up again later if interest returns.

OK.  Let's scrap it for now.

The "internal use case" behind a proposed feature changing so
quickly is a bit worrying.  What is good for this project should
ideally be good for everybody, not only for satisfying a particular
$CORP needs of the day.  But I think the idea of giving enhanced
visibility into stakeholder companies directions and priorities
Emily (I think?)  floated during the contributors' summit may help
reduce such a risk, hopefully.

Thanks.
