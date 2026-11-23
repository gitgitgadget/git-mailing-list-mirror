Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795459599;
	b=b4eUWrzKbbAs5FnVy/yZbjVg7SvYfKcKq4+cVWAxCgdsCiZt9pWwEoDSd1r6yKbQ2+jR
	 j1XSPnR+uB7h7v6Z8/XFggMY1eOSs31AtVscZh+YVS6btQSc8/XR4LyjNgg8zIf/kXi1H
	 Fcs9hdhtXMTv7B4P8W5WAza3b2T9SWI2V1h5vmn1zutPUrV25lJoC+8hT2Qmtmf0hV1Ze
	 MRzhkLyIPko/2SGSjNbuHNjqcJwqbG/SwMO3l8DJCsB+sfFUKz9UFjRGs0OouefTSHAId
	 pIzn0zXU8NHi1iq6QeVSjqkJXN4TH2fQWPK6VRPS1px+zBqMlf3EskJbZ6xpj2H2Agw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795459599;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-ZohoMailClient;
	bh=FS+EFujho3unqeenABFWaHwmjOe1P47OFe+RTOrSGnk=;
	b=uy8kWdEbes/HJB5corGa+bnsq5XaLB77FulxYOA70Q2JxcBycXaonRUqzZ+jJCCh7FlI
	 /3jvaHd12SKuO9cy1Wh7U5HgWow31C7ruNnrEsBKvRraA+lr3tqi0SGaq6gLtntKwMcZA
	 58SVeauRg++Sj5MlIqznAzR/61cWnQhG09tNNKrTGes2bQzZwjPSPtQMOjHZSsjyPg8Hd
	 4zhCzUemxYWlMTQLjYvQnNKIEUGkLefqA7PR8sNuqaBa9yM5AH/WpMcfCfwIiO9UPyO4C
	 W70XUgCbES91w7AsgQYsyzCjtZ6wUcd7BH+o39RqGFdNMEsi+32mYfjfSMv5JbLPvtQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=laveeshbansal.com;
	spf=pass smtp.mailfrom=laveeshbansal.com;
	dkim=pass header.d=laveeshbansal.com header.i=@laveeshbansal.com header.a=rsa-sha256 header.s=zoho header.b=klQz7cGA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com [165.173.180.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB775606A32A
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 18:46:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB775606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=laveeshbansal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=laveeshbansal.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=laveeshbansal.com header.i=@laveeshbansal.com header.a=rsa-sha256 header.s=zoho header.b=klQz7cGA
ARC-Seal: i=1; a=rsa-sha256; t=1795459593; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GPQpNR7YuTSCraQiPCweqHcJzeJgNGWG2S5VwMK2W4o7JG29CvnyP4mI9YlBZ4AqiPBkl/X6PLUNWzYF2sh8tz/EdKE23zncfY+Z0knBank8cKtPfDJ7UTLsgbq0yWCiOQUfwJGyQrBXsLZ/1q+dC7ObmZBBZWu3P38WwKTHqGk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795459593; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=FS+EFujho3unqeenABFWaHwmjOe1P47OFe+RTOrSGnk=; 
	b=bIrNzplPNXH0TZpP2d2P9kuCPDjHz9GaDugFyAn7LVlrrA0yVgZFTpI3oNLqqSo9rw+Ev9e+2WF/gGTvXpdRKkzFo92uUp13d6yGMPEUAQ5vH04XwvZiOHkZZSd3WO1vCiMcBC8pJye0GhSULS6Enebj77hdnMUXVCAibL5WcYw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=laveeshbansal.com;
	spf=pass  smtp.mailfrom=laveeshb@laveeshbansal.com;
	dmarc=pass header.from=<laveeshb@laveeshbansal.com>
DKIM-Signature: a=rsa-sha256; b=klQz7cGAtcZNYXmphPxQtWDTOoB18bFgx+ZGKUtnE5OnHVL1BWDs75TT2sV39E94Vp9hfQ7kethCe4WXRnysY+8NnwMw8V7tpdhvOUiJ4JTB2/KVkXIZmG0/CGdF2APfnX7kXNOxVePt8T18G3zn4DchCZlGBPdDgfVrniPJ3RQ=; c=relaxed/relaxed; s=zoho; d=laveeshbansal.com; v=1; bh=FS+EFujho3unqeenABFWaHwmjOe1P47OFe+RTOrSGnk=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795459589398576.7632704882112;
	Mon, 23 Nov 2026 10:46:29 -0800 (PST)
From: Laveesh Bansal <laveeshb@laveeshbansal.com>
To: Aniket Gupta <aniketgupta3001@gmail.com>
Cc: git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [GSoC PATCH] fsck: report the real object count in the connectivity message
Date: Mon, 23 Nov 2026 10:46:23 -0800
Message-ID: <20261123184623.64131-1-laveeshb@laveeshbansal.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261112130749.51747-1-aniketgupta3001@gmail.com>
References: <20261112130749.51747-1-aniketgupta3001@gmail.com>
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

Aniket Gupta <aniketgupta3001@gmail.com> writes:

> Maybe we can use something like "report the number of objects in the
> connectivity message".

That title works for me. In the partial clone the extra three are
blobs the trees refer to, so "number of objects" describes what is
counted without saying they were checked. The commit message already
says "number of objects in the hash", so I don't think anything else
needs to change.

Reviewed-by: Laveesh Bansal <laveeshb@laveeshbansal.com>
