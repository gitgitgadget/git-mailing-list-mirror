Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794688771;
	b=cQ8xvYsIWIfCLAxNUrw+ACF/1DEhR2dKLyvxeFMlPV2ZUavFUXlQkJbbrqUApvozt7/T
	 tyOQKfpJExaiqoLsLyvfAcjZhD5sM3d7yrDwfmKuShwj6j/Z22IE+GTrh/cXop1dxb3De
	 BW69PhtTGBZFRwCpXK3K9bfT63az3veXBIKnTOYcp2FDkawFDYPjl/RCJsz4uixtNe4W8
	 aJFH+r7idHI3dUBVs9823vHzTzqKi5266vtL3HVzqMNv7NmdpIhWg1THCWju9aS9OrtEJ
	 HZW+2ES1EXmxX0STeYDni3DUgjvIpgbgxtXyqPdt3TrZyDdZ2uGc6P4fe6A8lOEcb0Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794688771;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-ZohoMailClient;
	bh=j+5aW3Y0kv7NtFtj69pD2YblzK9Sv6pbT/ApuC7qsiM=;
	b=RNEKcqvzOwurFiqAuxSyVSHJZxsoGbNttKSmleCAHkCBnIJzzqKcc8aybxMEQwOtmblT
	 I6FeODF056aU8stGEO69Zkl2oqlQ7rKnvm4EQakhqMxJ2rwDoU6ptUj3rkSXmlNI3QA5q
	 KgW8muweL2PjeqJIgy2Igaf350d6juVACEx1PnI6ndV0GngxrMzfhHmFwse6lhKs2T69Z
	 rH3CIPO7kyNaKMpjLEhsYzevqPttweDduYGpUzWnUBaKUyRQfJy4inJd9vhaLI3YcEh7K
	 Z5zHpDkFuqjYL3D2vQOkr2AwJ8Ekv2R/S+qsd+XiB1A/vzJwhMr12R/H3ZADaKn/cmQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=laveeshbansal.com;
	spf=pass smtp.mailfrom=laveeshbansal.com;
	dkim=pass header.d=laveeshbansal.com header.i=@laveeshbansal.com header.a=rsa-sha256 header.s=zoho header.b=Kyl8TO1f;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com [165.173.182.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7556B606A329
	for <git@vger.kernel.org>; Sat, 14 Nov 2026 20:39:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7556B606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=laveeshbansal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=laveeshbansal.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=laveeshbansal.com header.i=@laveeshbansal.com header.a=rsa-sha256 header.s=zoho header.b=Kyl8TO1f
ARC-Seal: i=1; a=rsa-sha256; t=1794688765; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=eW3485XZkNixXndzsH0hWOYs2r6rqxQTgZ/v6d8j7FvkM5GGy+waW3/z2DfWK3YMSluXpRAsYUnTmgJ/CQ7IkmxfDmxR5gYPQCXjHMC77hZclbU46NfyHste4eb4tf31MHv/ETXCfK3JYCBcSdzSnPRdomdj4iGOUZxp/TCMMss=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794688765; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=j+5aW3Y0kv7NtFtj69pD2YblzK9Sv6pbT/ApuC7qsiM=; 
	b=NQ8xCH/4BGJsTKOjw0m0pyTu8Mn2t/mjc1t3T9LsZ90tTFYjzjqCtQ2VEx8i7XfkrL9QiKYSMpsInpMEVXUsg/FSTj9TWCQ7VuDv2EI3dYlmUpsyb5Go4d4jalW1YkG/pGZbAS4i2wyjPXKetxGDQ1o0sZ8LzVrqUYItIjx/dNM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=laveeshbansal.com;
	spf=pass  smtp.mailfrom=laveeshb@laveeshbansal.com;
	dmarc=pass header.from=<laveeshb@laveeshbansal.com>
DKIM-Signature: a=rsa-sha256; b=Kyl8TO1fcX6gx4o4uNU4UVbpl8h7+JM7Pdm/XsnoE9rad2euAtk9WIIH3QCjCND3qqXjA4DjaICPB+fhvS6aqu4zDfabJ34d7kkYIgPdgDqEIV9xjZays8+ND8FoW3VuxHCkUBX3nR/fRdJp46SrZrLs85aOYjRo2hbN0qWRlSU=; c=relaxed/relaxed; s=zoho; d=laveeshbansal.com; v=1; bh=j+5aW3Y0kv7NtFtj69pD2YblzK9Sv6pbT/ApuC7qsiM=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794688763051207.0008788862607;
	Sat, 14 Nov 2026 12:39:23 -0800 (PST)
From: Laveesh Bansal <laveeshb@laveeshbansal.com>
To: Dorine Tipo <dorine.a.tipo@gmail.com>
Cc: git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	kaartic.sivaraam@gmail.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	usmanakinyemi202@gmail.com
Subject: Re: [Outreachy PATCH v2 2/2] t0410: keep git's exit code in test_grep calls
Date: Sat, 14 Nov 2026 12:38:54 -0800
Message-ID: <20261114203854.38111-1-laveeshb@laveeshbansal.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261020160127.29096-3-dorine.a.tipo@gmail.com>
References: <20261020160127.29096-3-dorine.a.tipo@gmail.com>
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

Looks good to me. t0410 passes for me too.

Reviewed-by: Laveesh Bansal <laveeshb@laveeshbansal.com>
