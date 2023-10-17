Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2892F517
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 22:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PzeJULsJ"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DE9D3
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 15:16:11 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id F39D61A7C5A;
	Tue, 17 Oct 2023 18:16:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=lTIsw0MapI0+ZGjcL8f/qzki1Q3glCdjVZQi3Q
	Q4YD0=; b=PzeJULsJJr2fowHaJrLdughZt1O1sArlnLrPj82dtO69UAMi7Tx3FP
	Cd/Tuc10A8tg6gPHxR6aK4qJ64r3KMESoN9hfdksenhDzdFfpo0IWUL/XNnG8J/0
	zUDdsMjqiBs8hZA3Moz02XNyzLSpscjv5IzvZ3b/NPhzJwmgQrDic=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EACB51A7C54;
	Tue, 17 Oct 2023 18:16:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 512151A7C50;
	Tue, 17 Oct 2023 18:16:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Naomi Ibe <naomi.ibeh69@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] [OUTREACHY] builtin/add.c: clean up die() messages
In-Reply-To: <20231017221323.352-1-naomi.ibeh69@gmail.com> (Naomi Ibe's
	message of "Tue, 17 Oct 2023 23:13:23 +0100")
References: <20231017221323.352-1-naomi.ibeh69@gmail.com>
Date: Tue, 17 Oct 2023 15:16:06 -0700
Message-ID: <xmqqttqox5cp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C57712C8-6D3A-11EE-8798-25B3960A682E-77302942!pb-smtp2.pobox.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Naomi Ibe <naomi.ibeh69@gmail.com> writes:

> As described in the CodingGuidelines document, a single line
> message given to die() and its friends should not capitalize its
> first word, and should not add full-stop at the end.
>
> Signed-off-by: Naomi Ibe <naomi.ibeh69@gmail.com>
> ---
>  builtin/add.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Looks good.  Will queue.  Thanks.
