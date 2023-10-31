Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6672BDF65
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 06:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MErMdYYJ"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371E791
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 23:07:53 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8CDD71BAB41;
	Tue, 31 Oct 2023 02:07:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=B1JFtmZD8A4wzh6Yy3cFBli1zA3Jwh3l7OKkZ+
	LIsY4=; b=MErMdYYJlsXECc9iuACZg6jDVunufZ8Gqyu0Q9gQkoe+QCt4MJ5ugF
	jHZNTNkcW+IRI4f6lK/L4AvUwTByL1AzDvugu6skhp+YUa+T10+CrGP7924Hchwo
	Y0UevVt51ymc5Fq3asuDvdWCi+Z9iYzv4Mm2HWxlQ1dtV7YJrXyKg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 842781BAB40;
	Tue, 31 Oct 2023 02:07:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B17191BAB3E;
	Tue, 31 Oct 2023 02:07:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ruslan Yakauleu <ruslan.yakauleu@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] merge: --ff-one-only to apply FF if commit is one
In-Reply-To: <9f584927-7506-421e-a363-953eebb0ef90@gmail.com> (Ruslan
	Yakauleu's message of "Tue, 31 Oct 2023 08:48:40 +0300")
References: <pull.1599.git.git.1698224280816.gitgitgadget@gmail.com>
	<ZUALkdSJZ70+KBYq@nand.local> <xmqq1qdb8wzk.fsf@gitster.g>
	<9f584927-7506-421e-a363-953eebb0ef90@gmail.com>
Date: Tue, 31 Oct 2023 15:07:50 +0900
Message-ID: <xmqqwmv32ukp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D2F937A4-77B3-11EE-8CB0-25B3960A682E-77302942!pb-smtp2.pobox.com

Ruslan Yakauleu <ruslan.yakauleu@gmail.com> writes:

> Command of developers can decide which policy use and why.
> If a team decides to avoid extra merges - why not?

I never said "--ff" is a bad option that should not exist, and I am
not sure why I had to be thrown such a rhetorical question at.
