Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A712DF61
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 19:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LH5t3o86"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9461EC6
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 12:41:29 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D73941A68CE;
	Tue, 17 Oct 2023 15:41:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=+Lb/lh0ikbqvw03GZWjlO9+bwWdMM/S5fA7D4h
	oKRaY=; b=LH5t3o86At2L1+fo3KFGbvyVq1RSiZEWuqo8b1+A+jXlxMkoN8fJQ5
	l2X5hUENSuMF5GYtwTF60YXFVbPpsOD1K4zOF402PPogfpAeiCE1vpqth3rZhYx0
	PfMaFlk2/fqtwOHBD+7FgaN081oAEgLeZB78Gf+phF6sCuc1itUL4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CB9F81A68CD;
	Tue, 17 Oct 2023 15:41:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 33E391A68CA;
	Tue, 17 Oct 2023 15:41:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Naomi Ibe <naomi.ibeh69@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] [OUTREACHY] add: standardize die() messages output.
In-Reply-To: <20231017113946.747-1-naomi.ibeh69@gmail.com> (Naomi Ibe's
	message of "Tue, 17 Oct 2023 12:39:45 +0100")
References: <20231017113946.747-1-naomi.ibeh69@gmail.com>
Date: Tue, 17 Oct 2023 12:41:26 -0700
Message-ID: <xmqqfs29hw9l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2A14C2F4-6D25-11EE-B1C8-25B3960A682E-77302942!pb-smtp2.pobox.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Naomi Ibe <naomi.ibeh69@gmail.com> writes:

>  builtin/add.c: clean up die() messages
>
>     As described in the CodingGuidelines document, a single line
>     message given to die() and its friends should not capitalize its
>     first word, and should not add full-stop at the end.
>
> Signed-off-by: Naomi Ibe <naomi.ibeh69@gmail.com>

That's a strange formatting.  I think you meant to make the first
line (i.e. "builtin/add.c:...") as the Subject: of the e-mail, and
the three lines of text as the body, without any indentation.

Will queue with such a fix locally to save time, but please make
sure you know what in your workflow to produce a patch and send it
out caused this strange formatting, so that you can fix it and send
your patches correctly when you need to do so for real.

Thanks.
