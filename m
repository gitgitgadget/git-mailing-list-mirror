Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795398275;
	b=v3HAqVA9wpr73OFNjcpDyn5EsCBQ4Dl+nDlhLfefM48VJb5uDh/wv5BeVnU7b8cpPiT3
	 yBOmUS0cVCnmluKqCr/ngfMok8rAL+sH2gSovDRmUwZUqVRAg+f+9iJNwXiFiQtF6Clwa
	 DIAw0Cg0BmbSfh4HcjRFtV4wq59+DGelV4ihjj3/Sqy0VDQAbfhe4i9GQStea6k37cGNt
	 lWCnCNJlL/C2TeIYUVkKTK6Yr1+37oKBaNmPHQHmBVwZp5WJgYyoGEA0X6sP/vgMIWQu4
	 iEC5zi2pOrxXCAw4FGveitAw4rnD6nS6w+Of8tmp1XneMskJv8GwuvGg7XFYVNCRqqw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795398275;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-ZohoMailClient;
	bh=URSNkFTmFpqTl9SkBjlNAcWWLgC4nnAjknt+pbZ1qMM=;
	b=eVbio8lJ3sDIVBYhnvIapZNjA8U01Fvr3/KRUWeU+zfWl/iyyJ7UdCUX1mngJbW2SYeF
	 xtzEGCsu4vCvTEkcU0jj6+Sf0tvSfZoYTtcjkVpQ4gQIXPlsTGDJRcUGepDJDN5q4aIRk
	 WVvSrPUPxqKZzvG8OFYNyHS0JZE4C6YW1QXoca5Vk+C0rO1CZKmXtOIYkdxz8V6YL36wm
	 tKTeqjJPr/46JXRiJ99lfQUxHzNeoOm90DZtg2xMelpkoHxhyerM1ZityvsvnIoEs1Kbt
	 qbxoUf1faroOW9xRKcsFCCmd7TWOc4NDd7kZ2XC+53zJb3zFhLI5H9al8f9fyIfxgCg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=laveeshbansal.com;
	spf=pass smtp.mailfrom=laveeshbansal.com;
	dkim=pass header.d=laveeshbansal.com header.i=@laveeshbansal.com header.a=rsa-sha256 header.s=zoho header.b=lnXdW7S4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com [165.173.180.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008EA606A31A
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 01:44:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 008EA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=laveeshbansal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=laveeshbansal.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=laveeshbansal.com header.i=@laveeshbansal.com header.a=rsa-sha256 header.s=zoho header.b=lnXdW7S4
ARC-Seal: i=1; a=rsa-sha256; t=1795398271; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BCuZk7mTq5V1HER4tozrCZXZbVu/uS3yqx+gglTt58VvM8+MT7eOpIc5IVylswgZudc9WITTtGInRKRn4bc77bK1yMJnGGOs0Ty2bgVs/1MDXaoAL/yt7NfSgrbq41o1RxRHZG4iLzvkpdevlrGOyNsQBcwinkS22quLXV5Uyhw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795398271; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=URSNkFTmFpqTl9SkBjlNAcWWLgC4nnAjknt+pbZ1qMM=; 
	b=jg6Dk8YEsOrSt/z+Jxlfd6G0Yt60Tr4ZEUT9V1fJ4QKqTC4lVHhDGmb5C7nnTRE3fIjPiwkKplM9J7KxmkYQ3UHRKZ7L/aezsBXs5jk9URmLD+JZek3stZIV4Htg9OkhoZT2i5v6KjJww1jQQld/kyo9N9EtzDjhr1xgdmnNmEA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=laveeshbansal.com;
	spf=pass  smtp.mailfrom=laveeshb@laveeshbansal.com;
	dmarc=pass header.from=<laveeshb@laveeshbansal.com>
DKIM-Signature: a=rsa-sha256; b=lnXdW7S4R0itoXqaaf1VeGPvWYq3RJeSho9/7xnWzYbPbxWs5yzGstq0FIYn+43D8XInaFGlO5y8vvqR3PAaeJGpGJzPBJeA6nwYALdqG0l8bGk8cc6LGky7soTJN2fdNm684EoatBkeSWqtQdjuoe44iI3e0KFvYCD+zD0HybI=; c=relaxed/relaxed; s=zoho; d=laveeshbansal.com; v=1; bh=URSNkFTmFpqTl9SkBjlNAcWWLgC4nnAjknt+pbZ1qMM=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 17953982694811007.6201473243045;
	Sun, 22 Nov 2026 17:44:29 -0800 (PST)
From: Laveesh Bansal <laveeshb@laveeshbansal.com>
To: Wasswa Edson <edsonwasswa54@gmail.com>
Cc: git@vger.kernel.org,
	Tanga Joris <tangajoris@gmail.com>
Subject: Re: [PATCH v2 0/3] credential: parse subcommands with OPT_SUBCOMMAND
Date: Sun, 22 Nov 2026 17:44:12 -0800
Message-ID: <20261123014412.35076-1-laveeshb@laveeshbansal.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261114184752.1417-1-edsonwasswa54@gmail.com>
References: <20261114184752.1417-1-edsonwasswa54@gmail.com>
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

Looks good to me, for all three patches. t0300, t0450 and t9902 pass
for me.

Reviewed-by: Laveesh Bansal <laveeshb@laveeshbansal.com>
