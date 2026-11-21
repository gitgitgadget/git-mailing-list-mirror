Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795290820;
	b=BJ4zXB5e2rdjECRtUYvIcf8B/BWnnDcYZrhWsbxzNTwRntIiA9jFpoF/DKcovldYUnLL
	 afS+yY2/X2ejoZX2wXvzKtC0s8EqoAuZ1Pwhv37lNao361P1bkQ2L/cbDM4rU8VWLeI7v
	 LIREgyQeupgnUmzdRBnfrzY3ZIy4m2jEAC8CbksRZOmMGvdNTWqtN1pgNoni4oNBcd+yF
	 QEK3NIUFm+Tj00sRMjL2Zz6h7DbvcEKddR8x6IqILUX9BK6UKpTUUKVvAPlYb4MA+EzQF
	 5oHZmYfzydPFPcExR/GnxBYkZP247cIKhcrL8V736/OobPritiKu1MMP88lO9sHZ2DA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795290820;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-ZohoMailClient;
	bh=oSkgKdPttNpgP/efMYTjmF4rwAYqUYRN9D9nOXifQGI=;
	b=Cbs05axeicDUwW7JL19r1a51IZ6LoumYkiA4yXrqeDjxPgw4Jktjz4FHhrk9u8Hf7ZMd
	 9Fz3AP3dlTfYvuVvH6HOEhAokzy/E8xysZXaQYD/UmF9rJnSef7OcU5MPXBUym1FiY8tp
	 gfpnK2A4n/5r4Swl4qAY9J9/vbvwfeDj9zQ8urAWlu241mRbaO/RXeJGWbf3SZFAo+I1P
	 Oy1JQxaAIkWgkNVl04mI3KW7HtsvoA9sPHkWfIKjIe7lGrWPHa0xweg9Oe6X8gQMKTPsx
	 BTJhsk9D/6hAdBJsiYEVlIxbaTZMV4pOkUZnrnXqSDfqoC+/mZ69CJIRLOx53NuHefA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=laveeshbansal.com;
	spf=pass smtp.mailfrom=laveeshbansal.com;
	dkim=pass header.d=laveeshbansal.com header.i=@laveeshbansal.com header.a=rsa-sha256 header.s=zoho header.b=hc1FYRVL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com [165.173.182.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2666606A320
	for <git@vger.kernel.org>; Sat, 21 Nov 2026 19:53:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2666606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=laveeshbansal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=laveeshbansal.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=laveeshbansal.com header.i=@laveeshbansal.com header.a=rsa-sha256 header.s=zoho header.b=hc1FYRVL
ARC-Seal: i=1; a=rsa-sha256; t=1795290809; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Mg6DoTKK1HE8qu5QcWf5BUoDTv19Lygv4HeqxUh4MBWy9qsp+Yyc7wIEyB6j8FmcjJIE6QJvEdtYHRuZoCgbCk/DYuDqoIX2b33Mm5h7Ha8rU8iYUZdiaMc+XdtrE25GFewx/7nLmlZrhPgVStlPsnRTdMbhuTUUQ8eM1fa5kMg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795290809; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=oSkgKdPttNpgP/efMYTjmF4rwAYqUYRN9D9nOXifQGI=; 
	b=bBZ8OTbDkpAk57xnKJIOPy/QMBH0ZXuxDMnWDCcsOPCl6LjwO2xVh+LZbv2nptp8dI/xbCWy6AD1SmyFXzjtMAHsi8lUi6a6zlwuzvH7u362m8qXxMdyhx1Nj/IE3T8v1wlzoHuHMLoojn1YYXE2qvWVNbPyN7prB5ufMU4CeuA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=laveeshbansal.com;
	spf=pass  smtp.mailfrom=laveeshb@laveeshbansal.com;
	dmarc=pass header.from=<laveeshb@laveeshbansal.com>
DKIM-Signature: a=rsa-sha256; b=hc1FYRVLTKa1ebZSny9JvuV8h6R/6AOEm4RsByxZMduh5t12eCu/nMA7W8T414bCIPAzS5qqmiTaRff2BCTu3PkJ+j0CEibh/lK5rpaoRlMhih8aV91mZtSUDyikZjYXCkJZW5xszwlznINTf6ZqH0UpFGRTs0YAQEgRXivmR+E=; c=relaxed/relaxed; s=zoho; d=laveeshbansal.com; v=1; bh=oSkgKdPttNpgP/efMYTjmF4rwAYqUYRN9D9nOXifQGI=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795290805502170.91843875880147;
	Sat, 21 Nov 2026 11:53:25 -0800 (PST)
From: Laveesh Bansal <laveeshb@laveeshbansal.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>
Subject: [PATCH v3 0/2] builtin/reflog: expire each reflog only once
Date: Sat, 21 Nov 2026 11:53:15 -0800
Message-ID: <cover.1795290319.git.laveeshb@laveeshbansal.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1794324064.git.laveeshb@laveeshbansal.com>
References: <cover.1794324064.git.laveeshb@laveeshbansal.com>
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

This series makes "git reflog expire" expire each reflog only once.  1/2
puts the --all and the named-ref paths in one loop without changing
behavior.  2/2 skips a reflog that was already expired in this run.

Changes since v2, after Patrick's review [1] (1/2 is unchanged):

 - 2/2: describe the --updateref case in the commit message, and add a
   test for it.

 - 2/2: skip reflogs already seen with a strset instead of a sorted
   string_list.  The order in which reflogs are expired stays as it was.

Assisted-by: Claude Sonnet 5.5

[1] https://lore.kernel.org/git/avRiv5WpCZQCbRnZ@pks.im/

Laveesh Bansal (2):
  builtin/reflog: expire --all and named refs in one loop
  builtin/reflog: expire each reflog only once

 builtin/reflog.c  | 56 ++++++++++++++++++++++++++---------------------
 t/t1410-reflog.sh | 37 +++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+), 25 deletions(-)

-- 
2.54.0

