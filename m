Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792955791;
	b=RbdVcQNO6K/BMQ9CFMwOQACBwAVj8oev4MZX+rMZ8oIB0QhbHQVxv1giN+XjvDXL26x6
	 Y68rQyGWkXSvbO9r+96c4E/M/elY0y4ptXDQQCJs6y5s4Ikfs7E6ysX4Q3WvwqtVdp1aC
	 r0uz5cQfcyYisPIUy5270qWhSd+YjxdOhY4BSA6HUPFWm9IHFrWiT4jrKNpRl/tLdhxAE
	 ByDrp5CjSA/aFyUxb4MsOAgpIIFEyMdu1kqZGOz98uWQADq7FPhYhfY2yNO45xprZ1+gP
	 xEHRLfWU5sNArFz8l+ueSLZv/ceCg0Ja4yhIj1oQHjqFmtWMCW/GWlhaj93XEaxSuDQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792955791;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-ZohoMailClient;
	bh=4VnXdYh+sPsWCrQpfYhjRksm/v/shJoI5g6ecB/8z8w=;
	b=kI3oSNPDmJmoqPurbKP+wNFxEn2xeV1WW/55GAyPORGIYuG3P+6JvDLcKr5YOgT/dJ6c
	 FlmmLC5JfSQtvXuxLsJRJDRhajiPKNhrjgQVr7riLr7v+2fXCOqXo813v2JKTEYVKO6Tl
	 Isjte0x2p+cYidR0BOvdL5kBKGiqumvrwHZfpuGW6YDo2xlXcicgpbvkjjWLhHMZMJ07E
	 GtQkcmh6SnikvK1B+o89GK3Jc0g/iUN2VxzNBvlFih4bRL+1fqW0YlIyscctEXs6uYgDP
	 N5LrGgAi9VGFaaQr8wW0RBawJm4QdP5YNFlONQ/donB/wmI2hcB0GQ5uk5Q4tTmCFOg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=laveeshbansal.com;
	spf=pass smtp.mailfrom=laveeshbansal.com;
	dkim=pass header.d=laveeshbansal.com header.i=laveeshb@laveeshbansal.com header.a=rsa-sha256 header.s=zoho header.b=fO69EcPE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com [165.173.180.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E75A606A320
	for <git@vger.kernel.org>; Sun, 25 Oct 2026 19:16:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E75A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=laveeshbansal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=laveeshbansal.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=laveeshbansal.com header.i=laveeshb@laveeshbansal.com header.a=rsa-sha256 header.s=zoho header.b=fO69EcPE
ARC-Seal: i=1; a=rsa-sha256; t=1792955773; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kxxcF5e715F8L/umu0n3037bb5DaRUamWOcYQiWOdfUTl0jjQqPUQ5wSvSWqcwVYN/njL51amq5nmfof+aD3jDNHIoWuKcGuUCtyo8D2gYueWF1K9rlqg0gXxGDnvPhLZdWOcXB2K7KvmJ3tCf4SO0F3yLCjdnqGmeAX4k63vKA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1792955773; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=4VnXdYh+sPsWCrQpfYhjRksm/v/shJoI5g6ecB/8z8w=; 
	b=k82uMYzkukwR39Vlw8VvlYd9OU+POHiyGzmBGEpEuXLCOU1p94o482M3UbdMFwBuOV4UzlZj+eCKNYWutGRE6Kmc1eGZhDLWz1xPsqhNQTtKDr9wxah1+zD04CrLvFnqvCJvdO8QJx6Gb9wZm4L5pg1KkgJbRHFuDaLBo9n8zPI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=laveeshbansal.com;
	spf=pass  smtp.mailfrom=laveeshb@laveeshbansal.com;
	dmarc=pass header.from=<laveeshb@laveeshbansal.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792955773;
	s=zoho; d=laveeshbansal.com; i=laveeshb@laveeshbansal.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=4VnXdYh+sPsWCrQpfYhjRksm/v/shJoI5g6ecB/8z8w=;
	b=fO69EcPEDGwUJ3KhRilQuTs9ddv0Fj4PhMioouUh5kV2uTRJKDtYyEN5ABaf/yyi
	93SJUllqG5iOkOo30TWrFVEh9Cz72zAo1fycXMki6HXbmMDDW/0b/2T7s4EugDc21bt
	Zuki22aBdpR1U8wPpSmXqB0WUdqQSvLAS/tgURK8=
Received: by smtp.zohomail.com with SMTPS id 1792955772003397.88395139995464;
	Sun, 25 Oct 2026 12:16:12 -0700 (PDT)
From: Laveesh Bansal <laveeshb@laveeshbansal.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Sven Weiland <sven.weiland@tngtech.com>
Subject: Re: [PATCH] builtin/reflog: say "would prune" for named refs with --dry-run
Date: Sun, 25 Oct 2026 12:15:59 -0700
Message-ID: <20261025191559.79141-1-laveeshb@laveeshbansal.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <xmqqqzhdy7pi.fsf@gitster.g>
References: <xmqqqzhdy7pi.fsf@gitster.g>
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

Junio C Hamano <gitster@pobox.com> writes:

> That will help prevent a similar bug from ever happening again, as
> there would be only a single place that sets up how the expiration
> is called, instead of two we currently have.

Agreed, and I think the consolidation is doable.

I suggest keeping this patch as it is, since it fixes the reported
bug. I'll look into what you describe as a separate patch after this
one, and the tests added here would stay useful for that patch too.
