Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8194B2E0904
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 21:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770846878; cv=none; b=g24hpJbz6Zd2GuboWxF2G9WYaLDdbGR2sTUNjY4+9aJ/YtticqXO+IRPG7BFC6cd91PKpQJBx+xS05z7gpROH0mhmrC85PqvjBK+4choVnKLjGFrmFOfy24GZ49I4iXQqc8V0vgoOsG2/zEnbxdqHXpTi+/+xf5DkYiOLymovIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770846878; c=relaxed/simple;
	bh=VsX+IV3/uRSjyKk55SQU3qJl3Jqf2VsZh8QXnPnhg88=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AcLJpAil/7WJ+rUJ2h59F8dHQPbDmswtXEsEu0Xf4ek0PQfjAKe+HovtEP54n7OY0ye592TPCtfuB4G8+gC0T9WJlWLuRET9tZomU1Y8r3AB4lJJKcbQ3UjKs+3hZK8XCvnUxWce9RN1TWvFGlNgRSS313k6pZVUPh3tINJJ1e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=JZhhcoHk; arc=none smtp.client-ip=79.135.106.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="JZhhcoHk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1770846874; x=1771106074;
	bh=ydYYPM9d3/+pcb0vw548DhEpZPlQHODA1pYXiM9gjf0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=JZhhcoHk+WmjDIkCWJrgURyGsGf93AGSk8k89TlxUMj7TdKbMn12TLaSDcpOrP75z
	 l7LlacqWDdTFkJxIP+8u3OLMiNQzqE3YEb0x7Bbd8XK1dL+OvedI0OPF05q7xdysF3
	 xEd7fyrtp2+9Tbjb+a3B7L/jNipXO3UvHjGjs+Wa4G89OylUuK5ukx5GIZZG0i2HsL
	 4TWuW3fb6biNkIaozHkZ6P9oGzzS+RraaP8j075WhbLFVjqYPKKCtMY4AUAf9u6tGD
	 4Sl+5PY9wlGTkK5733ZZ/L8gfWMnENUjuyPdR1EapYRxivogtZbBZqmflxN89v858G
	 1LzxjRaJ+grQA==
Date: Wed, 11 Feb 2026 21:54:28 +0000
To: Junio C Hamano <gitster@pobox.com>
From: Chandra <Chandrakr@pm.me>
Cc: Chandra Kethi-Reddy via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] add: support pre-add hook
Message-ID: <oxAq83GHpc_Iuijrz10UxkyWknKQ0E3AilBFvKqNJg1OpO4ldNr5NUIsit3gSMjjO8dqG_t0FB4uAgYyrmLN4VGyx_ZeZOWh5qogrAiDWVc=@pm.me>
In-Reply-To: <xmqqfr77rn1t.fsf@gitster.g>
References: <pull.2045.git.1770737573475.gitgitgadget@gmail.com> <pull.2045.v2.git.1770822312474.gitgitgadget@gmail.com> <xmqqseb7rre9.fsf@gitster.g> <2kX5wTQeOz3VPzUT6QiH_KyB9RMMtf8L3I8N6WtVWHaVQ1ZguBTaqAqFcFgOGpCqv-RJyALKlsENx-g7E3DMx3TzCfZoaRtPEpoDyx6d9kg=@pm.me> <xmqqfr77rn1t.fsf@gitster.g>
Feedback-ID: 10057713:user:proton
X-Pm-Message-ID: 7a63473eb0b0432d19ff38647bb269964cb09ba4
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

In the git-commit documentation, pre-commit is always verbatim. For consist=
ency, pre-add typeset as verbatim makes sense.


Chandra Kethi-Reddy

Sent from Proton Mail for iOS.

-------- Original Message --------
On Thursday, 02/12/26 at 02:56 Junio C Hamano <gitster@pobox.com> wrote:
Chandra <Chandrakr@pm.me> writes:

>> the word pre-add ... would not look good
>
> Originally, I wanted to call these pre-staging hooks.

I was not talking about the choice of words.  If pre-commit
interferes before a commit is made in 'git commit', pre-add is a
natural phrase to use to interfere 'git add'.

It was a comment only on how it is typeset in the documentation,
e.g., should it be `pre-add` (for verbatim), 'pre-add', _pre_add_,
etc.


