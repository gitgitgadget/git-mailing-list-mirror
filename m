Received: from pio-pvt-msa2.bahnhof.se (pio-pvt-msa2.bahnhof.se [79.136.2.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5933845A5
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 15:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.136.2.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772551221; cv=none; b=gpOkiEDYuDr/NqoLqy48oYd5fzVpENJw8XsYKE4JB1qrfIqBK5pjaySCoKf7+0wuNzPHCZCi2XV39D7eU81osqPGIENI6myT6r6S8j3Rc35iiXGpzhoL4ERUASrf2XmZoRiroMingIDoUaV0VUHRcwevO5EpYSuqyEjgyVoXHOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772551221; c=relaxed/simple;
	bh=EMLGbukU8laqeifbc5Fr7h80GfLoZh5gM/C/vQPKWzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XDyZd6P9MLIlLQKqH1zvDH9voPozzyR/xPohGUOGvMJxisHzhrqbJuFLbMKYNAiEY0IskfW7mN6iFsf/6OIkevBc133KLfS8x+ex3tng0LK2oEVk/cKl4UR4cvwX7eyPcNNINhxBQIpQtPINPz0olnjy28E9CC7z5d3xhPOUsH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page; spf=pass smtp.mailfrom=jontes.page; dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b=cbvdENIO; arc=none smtp.client-ip=79.136.2.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jontes.page
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b="cbvdENIO"
Received: from localhost (localhost [127.0.0.1])
	by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id B5D513FC10;
	Tue,  3 Mar 2026 16:13:46 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Authentication-Results: pio-pvt-msa2.bahnhof.se (amavisd-new);
	dkim=pass (2048-bit key) header.d=jontes.page
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
	by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hg1lJzUtZY9R; Tue,  3 Mar 2026 16:13:45 +0100 (CET)
Received: 
	by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 964D73FAFF;
	Tue,  3 Mar 2026 16:13:45 +0100 (CET)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0650CB23CD;
	Tue,  3 Mar 2026 16:12:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jontes.page; s=dkim;
	t=1772550737; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=EMLGbukU8laqeifbc5Fr7h80GfLoZh5gM/C/vQPKWzo=;
	b=cbvdENIOitTSBWhaqKqfXlnJMs1F5IggCnmHQczQP1rCKu0KMajGf7IvhlyXaTCWc6YRYd
	C0mdg9NyEEIeeKE9Vy7q7Z19XugsSzz0U4HhdsSbXabGMtbUUtUAC1zV925dHXxb/OhLkH
	mhcXW5WxQX6KF6gbyZ+csxhle/7n6hAnDPYyxTHDd2xXnI/9T87Rqt7ACNZE3GCV4pPoql
	JkLpFsqb3M/gvRgJcSjFlGNp4BHIrCfFQNV2lEwH5GmDoAybPctxhCRjbx+ApZC63TVRqA
	90+IbCatNMIJZgYUX+YNiWJMWduZtvr9wyhqb9OXRRI8BPaZ1jIrNJrzpPyhfw==
Message-ID: <c16d5045-d557-4336-b4dc-962034faa65b@jontes.page>
Date: Tue, 3 Mar 2026 16:13:44 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] doc: fix list continuation in alias subsection
 example!
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
 "D . Ben Knoble" <benknoble@gmail.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
 <20260226205339.1535482-1-jonatan@jontes.page>
 <20260226205339.1535482-2-jonatan@jontes.page>
 <7dc9d03d-61e1-4bd9-8998-0423214d1ffe@app.fastmail.com>
Content-Language: en-US
From: Jonatan Holmgren <jonatan@jontes.page>
In-Reply-To: <7dc9d03d-61e1-4bd9-8998-0423214d1ffe@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

> Missing list continuation.

Can't believe I missed that! Good catch.

Thanks!
