Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795290856;
	b=YKAMFYEkhSkMxEC+f1VXvp224P6NFf7sGUVjY+Xz37U2p8Txv9Sh0Pv+spkQsjHTT+aT
	 eXaYl5cMjhw9LSAl0XpM6PeBXOZQoJ5198Gdv4LMmWjIaYO32WdF1eRB2U8BU7Y45s9gu
	 3yxumagO34sXjjNNqlzhttdIDyWJwDcrpyPaP6sVfTEGruhX839ESdR2ClzYrtgGb9rBq
	 zYknONJW2Kc4aL2KoM3tn4MM63o03yHccm/Vu/gzfK6JRHXfiVgNxSCKnHsKtlI0iOSkL
	 b5ryu6WzVY5YP+drMjJCLRmcYMY++bGSpbd6fFIufNuaWC+mFtqRxM/3sQm3/cJ+wRw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795290856;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-ZohoMailClient;
	bh=Vb9bBYKz2LW556RY+lE6tMUM9UaGaXQyp8uYL5yLEag=;
	b=4JAt9y5MHSvLGJj79SIPGEFo3se2aSEHOwoH/lIajOsT/f7LQWmX5MHTJc1v3yOvFWPb
	 tyD/D/fyk4GCZhLTGp+VKjA5Km6x6U3wlDtPaBtZ1U3z651NA/ts/UKyPz8MQhzdfbUAj
	 P5yauzbh0B/CC+YPrXqVGceSHrCfYltp63keG3CtVZh/yD5uvSQ9ETYgAswdi9R9Fh6q5
	 nGReoOVRAKzTwFKhIrS1PGOF5MQen/Qr2hGWnkHmktdNZgix+nqWh/V01lcl2T0xlRKT9
	 6FFmJ90O23cABVo0AUwdQ2l0IytVwVjU+0WVn4X83JbFVeVAPGzpertp2OuYhDoHItQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=laveeshbansal.com;
	spf=pass smtp.mailfrom=laveeshbansal.com;
	dkim=pass header.d=laveeshbansal.com header.i=@laveeshbansal.com header.a=rsa-sha256 header.s=zoho header.b=N7dTSSyy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com [165.173.182.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8B2606A320
	for <git@vger.kernel.org>; Sat, 21 Nov 2026 19:54:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D8B2606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=laveeshbansal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=laveeshbansal.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=laveeshbansal.com header.i=@laveeshbansal.com header.a=rsa-sha256 header.s=zoho header.b=N7dTSSyy
ARC-Seal: i=1; a=rsa-sha256; t=1795290847; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GlzD7EUHRTtLv50juVE6d43vuze62Hra/hLhAVg7tuNE8pr+QwhPZtYC1JgxHVRaErORVA2BFB7I1jJZeLTxKIgYsRt6y1ZMwk0L2D83rCHX/hU7w//FIqecfG/uBeVk3IwKD3C10wudHN/VJWACz9VccJsbr4SF8aSlWGfaJ90=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795290847; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Vb9bBYKz2LW556RY+lE6tMUM9UaGaXQyp8uYL5yLEag=; 
	b=FNcWzW4WYZ5a3EVZI1GyRjb+RBYWb5FQ0DPDfebgCrsJftvJwX/woS9Bnp+DDiwXKKvE9Q5T3aCwDz/OHk5kvNrGPU9TakI4ek+tVgYzDRt90EybiIpyb4BdxBOpxTRPxnPvq9LBThZ1M2fX3n5DHdtjEI8yzwUhFhGPfihBTS4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=laveeshbansal.com;
	spf=pass  smtp.mailfrom=laveeshb@laveeshbansal.com;
	dmarc=pass header.from=<laveeshb@laveeshbansal.com>
DKIM-Signature: a=rsa-sha256; b=N7dTSSyyQnMAaLF4fNVWxwggBcfPz4F5VYYNVdIi+vzyuJFHjzdXlEKpmTs9blYaPx7Vw0s5imku1EIoVGUhPpObJKc0DHswgLJCYJAvu02tKCxxuMknnoHCjb1MHx7r9KxBPwT5t2kstWqBlgnEhq+wxcENGDjncGJrC4M1LS8=; c=relaxed/relaxed; s=zoho; d=laveeshbansal.com; v=1; bh=Vb9bBYKz2LW556RY+lE6tMUM9UaGaXQyp8uYL5yLEag=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795290844298592.6070657387306;
	Sat, 21 Nov 2026 11:54:04 -0800 (PST)
From: Laveesh Bansal <laveeshb@laveeshbansal.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>
Subject: Re: [PATCH v2 2/2] builtin/reflog: expire each reflog only once
Date: Sat, 21 Nov 2026 11:54:00 -0800
Message-ID: <20261121195400.20517-1-laveeshb@laveeshbansal.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <avRiv5WpCZQCbRnZ@pks.im>
References: <avRiv5WpCZQCbRnZ@pks.im>
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

> Isn't this note here important information to point out in the commit
> message? It sounds like a bug to me that we behave differently
> depending on how many times a refname is passed.

Yes.  v3 moves it into the commit message.

> Hmm. This here retain the current ordering. But is there a reason why
> we have to maintain it?

The order can matter.  With --updateref, expiring a branch can move it,
and "HEAD" is checked against every ref tip, so expiring "HEAD" before
or after that branch can give different results.  Sorting would change
the order, so v3 keeps it and uses a strset, which is one lookup per
name.

> Arguably, if the above is a bug, we should also have a test for it
> here.

v3 adds one for --updateref.
