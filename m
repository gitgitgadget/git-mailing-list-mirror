Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794240821;
	b=cMdJLnaKMIAtlfgOpcp9/x2weoV7PAkZwSdAVcIAycYUgVEDGi33cpLKKfBBIlUsXvcb
	 ujo4FRa/T/AvSUVj0B2nuXY7EqsDzr08dvy5UK6F856zHLwhFTDE/KMiMPG8mladDnckz
	 otBxVlf5aivgHgVRxA80V9563JClU4BAoc7NbsS6pLQ0wVk3m1ejgx6BTLNCF7Mv1CmOO
	 jq57fa3anetDWfXSV9aI0MrrSqUFyJ+mA6yp6J3t3Qya4A/0zRNyO36h2pGdMFORuLcDI
	 1LqfHt0adccY6IgZ3f1XMTe8gSzdBrw/xoQr9uFQVS5xnXhjl5i3LHiZ6qL9FtO2uKw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794240821;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-ZohoMailClient;
	bh=gZHMUtCqWFVTYQrUdfHWqAARRtreL2hCsTsvxiuGOM4=;
	b=2Cm7RqF5EFEa4G5cDOE70ELMh/S4Siar75rTG1Rl9+mhpqkrgALSnhbnvBq6hy/JJX0c
	 neFPjxxZQV1xR9ngr74YiOORHlfqc4CsU7NNMCUbb3070+VipQmAkrU7KDF/Iw8N+87f9
	 ezcP+4XvQ1IgM3YIKmUc5B4I3+mThjrSO8Lww30JMuN4YGDO77CMD+RT05lKBNxmXRH4O
	 2RMmSwBO9mGNOabKpk3vPw7fhZ3rc71TDoKznuTPOxiqj2LkUYyY8AuBj/HHC+3updQtG
	 6PFNUINc947ffq9cmlrwwMqTL2HPg3hOZbXUPHGpdlB4nI+8/57vSlD1ZGFrNX9B0eQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=laveeshbansal.com;
	spf=pass smtp.mailfrom=laveeshbansal.com;
	dkim=pass header.d=laveeshbansal.com header.i=@laveeshbansal.com header.a=rsa-sha256 header.s=zoho header.b=GRt9aMwm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com [165.173.182.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2878C606A31C
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 16:13:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2878C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=laveeshbansal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=laveeshbansal.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=laveeshbansal.com header.i=@laveeshbansal.com header.a=rsa-sha256 header.s=zoho header.b=GRt9aMwm
ARC-Seal: i=1; a=rsa-sha256; t=1794240812; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=O9Y9BSrgJgzP9N+AhlQ3NoAI7wUPO8IPHcWIH5kdl/rtjkpx/LRjutoTdq87xap9uxfb5T4/JaJPtlEnxVrM/ehoRSi+28fRKaDj6jRDr1oCNcWrw4z/VHToymjd+EZtFPewrHSFV3CoTCM9kBGmVfiS5LOhNr/iCNbLP0+cjMw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794240812; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=gZHMUtCqWFVTYQrUdfHWqAARRtreL2hCsTsvxiuGOM4=; 
	b=SJoeNAXR9K84u37/c89TpU67fSOzlMZca9zNkdLzCdzZaB5EbC2NXd2hugM9Lk/GPAe1obuUTk0yMcNLKKXwuLBMwbwTscSGdLjPoONbrYAi0QtvRS4xiDAug9I5o4op1Zlk+S42zRnL4ItiU1Pg4wPSIvLyqqlulSRUC5ono4Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=laveeshbansal.com;
	spf=pass  smtp.mailfrom=laveeshb@laveeshbansal.com;
	dmarc=pass header.from=<laveeshb@laveeshbansal.com>
DKIM-Signature: a=rsa-sha256; b=GRt9aMwmwN8c84axUTtbNP7MEXWDUCWAl6r7f+NfDaEgFeqhoZ/wtqNwW/jk4Id3orXZ/ZUriLkT6qAZ0T7QdCzto+eXYOjRx1SMrYnkw/JnV6J+GI04qMDsPxcadulWbTBdDYSXtl6lvUmzqEUEWd0/AOVz9seX2DaD3L+B5fY=; c=relaxed/relaxed; s=zoho; d=laveeshbansal.com; v=1; bh=gZHMUtCqWFVTYQrUdfHWqAARRtreL2hCsTsvxiuGOM4=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794240811830909.0099808848487;
	Mon, 9 Nov 2026 08:13:31 -0800 (PST)
From: Laveesh Bansal <laveeshb@laveeshbansal.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>
Subject: Re: [PATCH] builtin/reflog: expire --all and named refs in one loop
Date: Mon,  9 Nov 2026 08:13:13 -0800
Message-ID: <20261109161313.54630-1-laveeshb@laveeshbansal.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <avGU-Wjkd821PLc0@pks.im>
References: <avGU-Wjkd821PLc0@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Patrick Steinhardt <ps@pks.im> writes:

> One thing I wonder though: now that we first gather reflog names, can't
> we also easily deduplicate them? For example if the same reflog name was
> given multiple times on the command line, or in case the reflog is
> included both via a command line argument and via "--all".

I want this patch to change no behavior, and deduplicating would change
the output: with "--verbose", a name given twice lists its entries
twice today, and sorting would reorder them.  It could be done in the
loop, by skipping a name already seen, but that is a separate change.

> Okay, we only apply per-reflog options in the case where the reflog name
> was explicitly specified by the user, becaues only in that case do we
> call `repo_dwim_log()`.

reflog_expire_options_set_refname() is called for every entry in the
loop, as it was in both loops before, so the per-reflog options apply
to the --all entries too.  Only repo_dwim_log() is conditional: the
names from --all come straight from the ref store and need no lookup.

I'll reword the commit message as you suggest and send a v2 once others
have had a chance to comment.
