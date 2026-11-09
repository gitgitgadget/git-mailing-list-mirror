Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794265946;
	b=iHcsvrw2IgttdS7a4we1Elh/C5hLBZbPJQTczui76gLJEs8RG3rl+dH2LkicNfCFnPOr
	 k/YcJwGtRv55Gr452K8c+HIm2VG+3VApbkvhftrZczg9vHj7z6kGazo566d6kEYkpOWqE
	 Fhl/y4Bfho5OIgzTRNqmAOqd+qEVTD7EY0qQ44WVRZMNxBu8AnceotBv2bVS2yzR5dDQf
	 JAxjflU7Gph71nRQgbDdHrm7l0F/bK+VPwJ8WiMsqtT79Q3TgYe8drA7PTJ7TiNEvG4nY
	 7kR19J2yR1jq7uKb01pDK9+iaGGv+7q4Arx3ggp4aMQCYNayo6Wf3MyQVKAZcf7l/Bw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794265946;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-ZohoMailClient;
	bh=76A17PJAR5WemzV6ByU5uLvvfSUfgySp2Dkmif8Dzz8=;
	b=r7dOTE9AakMDbe/3Q/AnY8QlH5l49+NFz7ExILUiRrc+I6aNdYjVBRh8IbmJ2L1iAAdi
	 5cwVrHmfQytXXQGJh7liJK6e8sc40P6I7yq7+KvqmTdM9LoGyOb7jDlpVtt1WH4/WGb3h
	 lDAq4URJ3Zc9qAaCzCPfQ37bfzdRuPy63o1DU0vWkITc2FyhvQ1g5kP1jZIqk33BfzXBH
	 vJMr40gQLFa5HmlF1DOBShD7SRiJChnAluyvrqbYeUpfxSBJwmLE0HTYdiqVgSuTV7UaA
	 St6KLrX8wL9FlfBxx7pD19Z2cHRWggHtcL+iKIKKnpJWo0Gi7VDwsWzJ61T8ITPf1rg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=laveeshbansal.com;
	spf=pass smtp.mailfrom=laveeshbansal.com;
	dkim=pass header.d=laveeshbansal.com header.i=@laveeshbansal.com header.a=rsa-sha256 header.s=zoho header.b=fa+m5Ptc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com [165.173.182.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1945606A321
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 23:12:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1945606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=laveeshbansal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=laveeshbansal.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=laveeshbansal.com header.i=@laveeshbansal.com header.a=rsa-sha256 header.s=zoho header.b=fa+m5Ptc
ARC-Seal: i=1; a=rsa-sha256; t=1794265935; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TuzPcXUET0vCOiPYJYDf8sWpqEzgcmbiZstulVgFJEMlAkWVXjVn8v78hPZnCde2rdcJyFbri1rVFDsG04zHZkQgydldZj3UNDXnGRHjcNwGQOdbZ89bVnOJOtCxAOow3lTePZ5d1V1RsQZbj+3LKoSKda+YF57ojaX1tyTmKrk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794265935; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=76A17PJAR5WemzV6ByU5uLvvfSUfgySp2Dkmif8Dzz8=; 
	b=Nw/KyGPYJte7dhZDoXMex2vAjtb8gwO7YMeCsczmYBgBdazKJqy1r8tHFyEVDuq7w4mwal3lL+Qkrazv+wXx1LEjLbxA2RrVgafzQAFMqcR0yrIEGJ41Eef0IxJoEci0foBKuh4n5AkEXKifcYZveZNVVE+GDxj7iqL0iB9aN54=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=laveeshbansal.com;
	spf=pass  smtp.mailfrom=laveeshb@laveeshbansal.com;
	dmarc=pass header.from=<laveeshb@laveeshbansal.com>
DKIM-Signature: a=rsa-sha256; b=fa+m5PtcUZYArn36yVfC/XM0ABoH6k8vIQQXFznwLHxjSy1Viw9srK6O2mR1SL8JzYGavEzbVKQ0ExrhBN2PCtIpa7o8/NYmPJrZqv7Ql3DWvxoQQicpZUqD4rujrnQa4PZc/lFdNUXNnqXS+hpE+m/3ASjNQgC+dULm9wMvcGQ=; c=relaxed/relaxed; s=zoho; d=laveeshbansal.com; v=1; bh=76A17PJAR5WemzV6ByU5uLvvfSUfgySp2Dkmif8Dzz8=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794265934790275.1664732335097;
	Mon, 9 Nov 2026 15:12:14 -0800 (PST)
From: Laveesh Bansal <laveeshb@laveeshbansal.com>
To: Roger Koranteng <rogerkorantenng@gmail.com>
Cc: git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t1010: add basic tests for mktree --batch
Date: Mon,  9 Nov 2026 15:12:00 -0800
Message-ID: <20261109231200.55724-1-laveeshb@laveeshbansal.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <pull.2270.git.1792497283164.gitgitgadget@gmail.com>
References: <pull.2270.git.1792497283164.gitgitgadget@gmail.com>
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

Roger Koranteng <rogerkorantenng@gmail.com> writes:

> The only "mktree --batch" test in t1010 is the one checking that it
> survives a concurrent repack. Nothing covers basic batch mode, which
> is how the leak fixed in 6272f3bd17 (mktree: plug per-tree leak in
> --batch mode, 2026-08-29) went unnoticed.
>
> Add a few tests for it. Two trees in one batch should get the same
> [...]

Thanks for adding these.  t1010 passes for me with the patch, also
under SANITIZE=leak.  With 6272f3bd17 reverted, tests 10, 11, 12 and 14
each fail when run on their own, so they do catch that leak.

> One test feeds two blank lines in a row and expects an empty tree in
> between. That is what mktree does today, but the documentation says
> trees are separated by "a single blank line", so I am not sure it is
> intended. The test records the current behaviour.

I would keep this test.  The question about the documentation fits
better below the "---" than in the commit message.

> +test_expect_success 'mktree --batch stops at a tree with a missing object' '
> [...]
> +	test_must_fail git mktree --batch <input >actual &&
> +	test_cmp tree actual

Capturing stderr and checking for the "is unavailable" message would
make sure it died for the expected reason:

	test_must_fail git mktree --batch <input >actual 2>err &&
	test_cmp tree actual &&
	test_grep "object $missing is unavailable" err

Tested-by: Laveesh Bansal <laveeshb@laveeshbansal.com>
