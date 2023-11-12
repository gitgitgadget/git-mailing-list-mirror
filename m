Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECD315B6
	for <git@vger.kernel.org>; Sun, 12 Nov 2023 01:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Hi+B1Ifm"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976372D64
	for <git@vger.kernel.org>; Sat, 11 Nov 2023 17:00:04 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id BD8401D818;
	Sat, 11 Nov 2023 20:00:02 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=wTCjLKRpXkEq8aq8pDtx0VJxZWtBiheKWyQ318
	CBVPs=; b=Hi+B1IfmPXG/tISfjDysBJiBvmhrKOeC0KS+mD4cV3pYyivbEIrOkg
	qrjAmkIc8YAy9/urhsRYAmapWZvBTu0alsvB0WiSbE/AEO8zU/qu2c2cVrICKhWe
	DzGnbx0Opqixe4RvUvW2+IZUGBEHqjBZflwbkdRSUVkuGLr7kMTvU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 403561D813;
	Sat, 11 Nov 2023 20:00:02 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 30B9D1D7EC;
	Sat, 11 Nov 2023 19:59:58 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] RelNotes: minor wording fixes in 2.43.0 release notes
In-Reply-To: <pull.1611.git.1699675340400.gitgitgadget@gmail.com> (Elijah
	Newren via GitGitGadget's message of "Sat, 11 Nov 2023 04:02:20
	+0000")
References: <pull.1611.git.1699675340400.gitgitgadget@gmail.com>
Date: Sun, 12 Nov 2023 09:59:56 +0900
Message-ID: <xmqqleb3rdkj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CCD8DD56-80F6-11EE-80C6-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>     RelNotes: minor wording fixes in 2.43.0 release notes

Thanks, will directly apply on 'master'.
