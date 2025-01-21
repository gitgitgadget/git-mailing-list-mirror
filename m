Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037042E406
	for <git@vger.kernel.org>; Tue, 21 Jan 2025 13:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737465230; cv=none; b=UCZctt8EtNsniBv4WYLyQiEuQE61oKdl7poGk7yC8g2Gz0ffowo6CS7ZuAc7rZ1B050xW3CHMauaWmderPrJ4GzN/MxoRwmC3S1msiYLibl1926OrQYOGE9rEccdczGU6ibGoFKlhTcQg5mN0mhd6moElWbjWHms3n+BIRvTUVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737465230; c=relaxed/simple;
	bh=ZQHX4pcVBS5KcCZhNIX2a26KM0XoVJTb/NdvQ4vscFU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p33a2PW92/JggwSANW1U8A006NIE/DP7uf9xeUQy937ZIL44/cSqP9HtZhjr79hsvJSOoSryP2nWu88YdnjGr7uMAShKdZzY1+HmVIfrP+WT+2pRjwRm7XNJo3cvhXoGvgvpMOef8lxrR1/E34jpvjaSQyzobawnFhE/YlTC0wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=us+Pvbso; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="us+Pvbso"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1737465221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0vGiNL1vsdAq6tg1N9rk4KFCUulm0IVKt7PHhcDyrPE=;
	b=us+PvbsolGuwIiicimyc6YgdbCyWw/VUsNRPo3G9tPcatEiurPK242g5nIiq+EXv2ZXskr
	lrcgaIeLpz0A1KfzBAOySsmdzAwOmQcfVvMP7zg+KpMUD3IY+c1N2huLwb3EoKgJDB/S+/
	rJ2MQs3b5/ERnzVo/pqDKiIJCM5wlVE=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Evan Martin <evan.martin@gmail.com>, Eli Schwartz
 <eschwartz@gentoo.org>, Junio C Hamano <gitster@pobox.com>, M Hickford
 <mirth.hickford@gmail.com>
Subject: Re: [PATCH v2 03/11] meson: populate project version via
 GIT-VERSION-GEN
In-Reply-To: <20250114-b4-pks-meson-additions-v2-3-8d7ec676cfd9@pks.im>
References: <20250114-b4-pks-meson-additions-v2-0-8d7ec676cfd9@pks.im>
 <20250114-b4-pks-meson-additions-v2-3-8d7ec676cfd9@pks.im>
Date: Tue, 21 Jan 2025 14:13:28 +0100
Message-ID: <87ldv4ia2v.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> The Git version for Meson is currently wired up manually. It can thus
> grow (and alread has grown) stale quite easily, as having multiple

Small typo: alread -> already


-- 
Toon

