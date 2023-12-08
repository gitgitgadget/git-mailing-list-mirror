Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KAFtCi5t"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EF9E9
	for <git@vger.kernel.org>; Fri,  8 Dec 2023 10:06:35 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 839971B6DE;
	Fri,  8 Dec 2023 13:06:32 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=2OO0vEqSk3rdkclIEwilmC4VKqWLKXpYuSiDqC
	u7N1k=; b=KAFtCi5tLxeIEZw6aMPaWhlPMhuPa4oXI27oYXgTEj6t0H0R1BPVf8
	zLPC/formjW12sqZQOEXySQdafMIk/bFC7/jcpyPGg6SajOoZsEH+Jf70i6XxFCQ
	cwPw2Re4BNelGJG62JR764eoR4zfYsMeRVOtB2nb7ErikaFvXoeCQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 7C61C1B6DD;
	Fri,  8 Dec 2023 13:06:32 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.103.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 267931B6DC;
	Fri,  8 Dec 2023 13:06:29 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Stan Hu <stanhu@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 1/1] MyFirstContribution: configure shallow threads for
 git format-patch
In-Reply-To: <e197cbd28135df5523ff5ba1688566edb831f037.1701927372.git.stanhu@gmail.com>
	(Stan Hu's message of "Wed, 6 Dec 2023 21:46:26 -0800")
References: <cover.1701927372.git.stanhu@gmail.com>
	<e197cbd28135df5523ff5ba1688566edb831f037.1701927372.git.stanhu@gmail.com>
Date: Sat, 09 Dec 2023 03:06:27 +0900
Message-ID: <xmqqlea436xo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 82A8ACEE-95F4-11EE-A8A6-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Stan Hu <stanhu@gmail.com> writes:

> +[[configure-shallow-threads]]
> +=== Configuring shallow threads for `git format-patch`
> +
> +It is common practice on the Git mailing list to use "shallow" threads,
> +where every mail is a reply to the first mail of the series. You can
> +configure the default threading style of `git format-patch` via:
> +
> +-----
> +$ git config format.thread shallow
> +----


Hmph, I do not think I have such an option defined, yet I send out
my series as "shallow" threads.  I think the new description is
somewhat misleading as-is.  Isn't it applicable ONLY to those who
let "format-patch" decide the message ID for patches?  If the user
lets "git send-email" assign the message IDs (and hence the thread
structure), the configuration variable would not apply, no?
