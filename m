Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795454086;
	b=vAKGRmej8L4XtA/7n4KevKcL1PEWwfihFaSTw4INUGjW9eVCkkfhP4kSb8OHj7heE+ra
	 Etdq6jw+52AzpvEDhaQ6Jcy35WCbSasIZtmOZYf6RnMQZjAfddwLzJBLbi1QuxVeu6LJ+
	 kAuGZ5k9xF93dSuvLdLqidvwyHeXrKUH0TsQcgetwy8qQ+CU3aEdg5DuXOd1duWrL0bWf
	 Ml0fbjQXKzNyAj6dANMGmg/WEXmkq3WfZnczEz7HEGWFzt2tkRQ4T8OZtXby3bqbLTMj1
	 I3NehPCKpIu0IbeDT2fGN6p18YdEIo1dCKrm4SyIh9d7HvbrZSganBkinSio+eZ4DLg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795454086;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-ZohoMailClient;
	bh=a7PHr1g0kcu4zq2IUQ0m5U+8yyi0nD6nbmgpt59mW/g=;
	b=3VWHcJM8MWQ/umo438YMDYy/zFoqfjAGjE1+a4T2g5AKRhk+lbC8R5kOT1w/SVaXpBZs
	 qxc6flvxUxPppeq5tqo4De0FtzAPcSG8g/JosoJkOBc8H2DS4FLTgjGFUuhWS1t2Xirqh
	 GyhXhY3pCaMqR3Y5vD3QSbOxaTnBw1ICZ2GJFXq3SMc04zFf/luA6ofirnlPpK8KEpsG+
	 Nk2D8mRVLjp3FXgIKMff80f0OZ8+zSM4eXeMYz+POU1PGcElLib8UQyz83V5ivbJiyPxg
	 YvdHMGA3rwQgQ0I5vm7eA0VwCE2cDPaesoZl6XfDf7TI3D3GRB1yAihMcCT11veHz7g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=laveeshbansal.com;
	spf=pass smtp.mailfrom=laveeshbansal.com;
	dkim=pass header.d=laveeshbansal.com header.i=@laveeshbansal.com header.a=rsa-sha256 header.s=zoho header.b=QDL6a1pF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com [165.173.180.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92601606A31F
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 17:14:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92601606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=laveeshbansal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=laveeshbansal.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=laveeshbansal.com header.i=@laveeshbansal.com header.a=rsa-sha256 header.s=zoho header.b=QDL6a1pF
ARC-Seal: i=1; a=rsa-sha256; t=1795453152; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SxQibDRLQF0k6JQZ8NN58YT69x0dKi7JZq3Wd9tbiO7wYIqB9HWzZu4dfvD0zHtAY5pI3fsMgb5kafry7sSUS96kec3lp29WNVZReyN2NhfskobqrfQra2zLty9lrlYx05t/gtd3mI2Uso3y/OHt9SuhwveBhmgN4tdReksOUMM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795453152; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=a7PHr1g0kcu4zq2IUQ0m5U+8yyi0nD6nbmgpt59mW/g=; 
	b=NTypmr9zJQffIKneBGDjveHqjkbRFly37GhlUU2B7ScfpZ0KfqLrq5EQPHBnnMjwAWZjOFJsKH9aWv1r2MNhI85hrBmHOg51u4lAZIyxxQbPDrka9633gKjdZ7KK0o2ecLe2/iMF0B1JwRJ1GBSav19c6Q2bR18rtDSLCjZmvaM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=laveeshbansal.com;
	spf=pass  smtp.mailfrom=laveeshb@laveeshbansal.com;
	dmarc=pass header.from=<laveeshb@laveeshbansal.com>
DKIM-Signature: a=rsa-sha256; b=QDL6a1pFVljeZH5ypu2IBM2EvdB/FflcY+xseGoJCqEzY0uUpXcJ0T10Y87/vfYBd1QBOJXesfzGHkxLQiOuoOI8iy11pW1jo6jcpg5r8fh+aBd8wAe/RAMJhEDSDmO63RiBZv1euO28BeNXFEN5TxkLjmDTE5YvuIPERw9yhO0=; c=relaxed/relaxed; s=zoho; d=laveeshbansal.com; v=1; bh=a7PHr1g0kcu4zq2IUQ0m5U+8yyi0nD6nbmgpt59mW/g=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795453150593882.9888702137875;
	Mon, 23 Nov 2026 08:59:10 -0800 (PST)
From: Laveesh Bansal <laveeshb@laveeshbansal.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>,
	Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] rev-parse, shortlog: accept --glob with a separate pattern
Date: Mon, 23 Nov 2026 08:59:03 -0800
Message-ID: <20261123165903.58880-1-laveeshb@laveeshbansal.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261109052402.33604-1-laveeshb@laveeshbansal.com>
References: <20261109052402.33604-1-laveeshb@laveeshbansal.com>
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

Hi,

A gentle ping on this patch. It has been about two weeks since I sent
it, and I wanted to check that it had not slipped through. It still
applies to current master (f7de814569) without conflicts, and t6018
passes with it.

In short: "git log" accepts "--glob <pattern>" as two words, but "git
rev-parse" and "git shortlog" only understand "--glob=<pattern>". The
patch makes them accept both forms, which turns the four known-breakage
tests in t6018 into regular ones.

If this looks reasonable, I will send --exclude and --exclude-hidden as
a follow-up.

Thanks,
Laveesh
