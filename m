Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794688689;
	b=eJke9XB75Fjqtm/4o2LO57FwTiU/X7Horj/ncGUd0abg3YL3SEuU6dTbkGgSqjK/wGZr
	 jaIXDj0Pp9uAxepRzX3fm+H5PBmAmqy0WKbA/MojSzLnwf84dMEHSj7FUwbwu/44MlIQQ
	 3kAn9MRVwicDx+rVOXbMuAldBaqluB4/kF4xSV9zhpxFEpuRsobm/4L03o4bhMkZpmDRx
	 X0DJv+LG5UC7ufC6V8fo/4cybe0QhrWX5nEMezyk71oGnMd3RIKCcAvUsZXJKRhMRfWn+
	 ahlwaEkXBc1SEkvbU+XFlcXygOGX+nlIXsz90OySfmcu8npcYe8vUQXbTcZNRonHCrw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794688689;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-ZohoMailClient;
	bh=1KN34S2PZK6vDcNvZW6BabXSdwGTk5Qh/mpeBthr6pA=;
	b=HPcwkDwl5UoRi2wi3h9i0cDtEOtwS64K04DrmG65NLBtoTcrldR5zGQiDoZZEFs2Lfix
	 JWdn3D8ValONGGJGM0/kqPecTs/x6zHEn5HPQfGWvnnvXCeTgfHkP6lF0iHXoKix9jfo7
	 OoR8Dj+zYROc9C/x4ITRfCB2ORaDaH9viFLqCixu+OohrQNOvVpcnb++1ALr3UaW5kXwD
	 rs7Qn003IaXNSyhn1JhkRz+FB1B2lzJ4u8HsIqbws8FmRJfRWekfp8jRBcUVKUz+Ed2tJ
	 J5Wj44rSsH9Rvq6R0iJFDAgQYacRoJnskVSnKnWChajnwD01SLLpX2CAe2ABOOGOX8A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=laveeshbansal.com;
	spf=pass smtp.mailfrom=laveeshbansal.com;
	dkim=pass header.d=laveeshbansal.com header.i=@laveeshbansal.com header.a=rsa-sha256 header.s=zoho header.b=AFjkC4kr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com [165.173.180.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CFF606A323
	for <git@vger.kernel.org>; Sat, 14 Nov 2026 20:38:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52CFF606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=laveeshbansal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=laveeshbansal.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=laveeshbansal.com header.i=@laveeshbansal.com header.a=rsa-sha256 header.s=zoho header.b=AFjkC4kr
ARC-Seal: i=1; a=rsa-sha256; t=1794688683; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TTSupaVRkwn8S3gT83UBTbWzk3Ei4t7TlA5/sCQeckVHLS8BlokJifHQceF6FbSgW0amQE6D2rLHy51zVJiRCuuuN+hHmCG1OM4k4lcJV1XEiOx04yPGFXYXTseUYrTeZUKMwDViMVBxUI/vA9wOZ3Nu37TqKW+6qbL9yLSd9zU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794688683; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=1KN34S2PZK6vDcNvZW6BabXSdwGTk5Qh/mpeBthr6pA=; 
	b=T5mDSa3EX7xnrUP0e5RMlC+B7O2ptUjFkN2VYAdoms+hdodsjzkyHbI47jgFLwdS6u/s7cnngMvOc/Dle8EJUUqv150kfgoAWcheTHFi9xsTG2ui6+Jig+fyMp8usSmceLbOFVV4eC9B3Eim6Ngp6mOIZAS/Okx7394jr0W0858=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=laveeshbansal.com;
	spf=pass  smtp.mailfrom=laveeshb@laveeshbansal.com;
	dmarc=pass header.from=<laveeshb@laveeshbansal.com>
DKIM-Signature: a=rsa-sha256; b=AFjkC4krsgRrUguwU0+D9tFK2/3xIhnbAn+nU1rGuCDOk7bgCBSwtTD+ON6mKdI3QdpXV4xA8IedLQZEyo9x9aIRN3CCXkYR4VQMAi7j48qOudbN5soUIDEgkDbA5S3MSf7UycMqcTjWBHNI9X+86swdwCpai4PLjro1ql9YSjM=; c=relaxed/relaxed; s=zoho; d=laveeshbansal.com; v=1; bh=1KN34S2PZK6vDcNvZW6BabXSdwGTk5Qh/mpeBthr6pA=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794688681386111.186623609467;
	Sat, 14 Nov 2026 12:38:01 -0800 (PST)
From: Laveesh Bansal <laveeshb@laveeshbansal.com>
To: Dorine Tipo <dorine.a.tipo@gmail.com>
Cc: git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	kaartic.sivaraam@gmail.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	usmanakinyemi202@gmail.com
Subject: Re: [Outreachy PATCH v2 1/2] t0410: use rev-parse to get the subtree OID
Date: Sat, 14 Nov 2026 12:37:18 -0800
Message-ID: <20261114203718.38000-1-laveeshb@laveeshbansal.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261020160127.29096-2-dorine.a.tipo@gmail.com>
References: <20261020160127.29096-2-dorine.a.tipo@gmail.com>
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

Looks good to me. t0410 passes for me, also with sha256.

Reviewed-by: Laveesh Bansal <laveeshb@laveeshbansal.com>
