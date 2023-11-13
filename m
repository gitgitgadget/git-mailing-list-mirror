Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE53441B
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 01:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KkTRUkoL"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869661BF7
	for <git@vger.kernel.org>; Sun, 12 Nov 2023 17:21:58 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EE36D1CD418;
	Sun, 12 Nov 2023 20:21:57 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=3PEXStm3kRyCaJtGIkb66RzYN/TaSOFt43j2G/
	tjayg=; b=KkTRUkoLMb9tsbaRt2urgwRsFW9NEJQgoRYTRsUtWimq4ODAeYFPkD
	ZAWMxHCzCAYXegz1+7OJN5Ir6JikXEcUVoutq0W5dooJBORaln9nyu/lWy/QSu7b
	p5Cihwk0qrfGFk9sRr8G3nsNg20D0sQozYh3lBPgYHsHPhx5F910M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DDBAE1CD417;
	Sun, 12 Nov 2023 20:21:57 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4B2511CD415;
	Sun, 12 Nov 2023 20:21:57 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Andy Koppe <andy.koppe@gmail.com>
Cc: git@vger.kernel.org,  newren@gmail.com
Subject: Re: [PATCH v4 4/4] rebase: rewrite --(no-)autosquash documentation
In-Reply-To: <20231111132720.78877-6-andy.koppe@gmail.com> (Andy Koppe's
	message of "Sat, 11 Nov 2023 13:27:19 +0000")
References: <20231105000808.10171-1-andy.koppe@gmail.com>
	<20231111132720.78877-1-andy.koppe@gmail.com>
	<20231111132720.78877-6-andy.koppe@gmail.com>
Date: Mon, 13 Nov 2023 10:21:56 +0900
Message-ID: <xmqqv8a6la6j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 09833004-81C3-11EE-8888-25B3960A682E-77302942!pb-smtp2.pobox.com

Andy Koppe <andy.koppe@gmail.com> writes:

> +In the rebase todo list, the actions of squash, fixup and amend commits are
> +changed from `pick` to `squash`, `fixup` or `fixup -C`, respectively, and they
> +are moved right after the commit they modify.  The `--interactive` option can
> +be used to review and edit the todo list before proceeding.

OK, this is good---exactly what I was looking for while reviewing
the "lose -i from the description" step earlier in the series.

Nicely done.
