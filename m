Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A043D904D
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 15:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773070096; cv=pass; b=NhxUvGcNwDheMnpY9rAPay7deCATEffLgJoOX/1EmvgEa6jJ6sFR3amzsEQx4pOFRKRcIIjdGSNEYHxoa8xnRawXKK58EenzLP2audZKT0ANT+DgVgD20gSW5+U2q1omPCLDePJKmllVdyEQfGv0vQUy0yrp0KNi3f7kQiDpA5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773070096; c=relaxed/simple;
	bh=n/HSGyaM+Bp9rHQIH3X9wvcOWFCj2OofL5MbeHZxVqI=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=NYdrjwaqMlhhd/C6N7FzeqXGxEuQb92bP+Auz79vczde6iriawcsutMaPXwsfIu18XGCRUbPAaD7E08VMhJqMJDpisoA7a1kkx/GxGUqsUnDdjAmk7ifMk6vwKGSKfYW76zt9RQsk/krzv3e+vBsNBV1T5G8LJgQG9q18ykog3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soss.website; spf=pass smtp.mailfrom=soss.website; dkim=pass (1024-bit key) header.d=soss.website header.i=skye@soss.website header.b=GhBiElix; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soss.website
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soss.website
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=soss.website header.i=skye@soss.website header.b="GhBiElix"
ARC-Seal: i=1; a=rsa-sha256; t=1773070093; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=crghpg2Yby4SpXPBEn0r+pPXTRhqzAeqAnDhZCwWnOamM8ODI+S1NSCbhDG6BMV4KgkYr+GTNBAkldjc3lwD3W3e7ZlAhrAstqQ/aU9xA4laVzjQS44iooIcJnkjkiskSind/Z8SD73yqlldwxwdIoxO2Z9/j2nRpc9sIUWUL1k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773070093; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=n/HSGyaM+Bp9rHQIH3X9wvcOWFCj2OofL5MbeHZxVqI=; 
	b=MI4Ps6mUHRzZkPV/YxLmLqG10M1Ea3CX5Jxa5XjJalgFW99dE+k8jzb12wMAxNqm+BEIRYnpzXuZn+o+KaL4c6aUwJUc2y+QY7MdUmG8vjG14ZLI6dEixix2Vlsi0yfCCM38LMUbqcM1R93lXSjLuAyto+XCy/p6lK4DhA2lRbQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=soss.website;
	spf=pass  smtp.mailfrom=skye@soss.website;
	dmarc=pass header.from=<skye@soss.website>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773070093;
	s=zmail; d=soss.website; i=skye@soss.website;
	h=Date:Date:From:From:To:To:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=n/HSGyaM+Bp9rHQIH3X9wvcOWFCj2OofL5MbeHZxVqI=;
	b=GhBiElixzxHbYbfFttVv1+EOCdx9puXo732zJnZOT+8znslQDe7I3H0BUKYP2x8X
	HIuq9trdKyKVMIowaeOaIhbcohjuB+HkUP7V7cOw8K0LArWJq9k/AIlrypTlvhy2sqK
	IHIw+CAXAcnk0by2ZgK2X4vFZA9HDCMohBCdrv9s=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1773070092512858.5499778220028; Mon, 9 Mar 2026 08:28:12 -0700 (PDT)
Date: Mon, 09 Mar 2026 10:28:12 -0500
From: Skye Soss <skye@soss.website>
To: "git" <git@vger.kernel.org>
Message-ID: <19cd33688a6.751eda7b902789.7603636968050846540@soss.website>
In-Reply-To: 
References: 
Subject: Untrusted Caching Proxy
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

Git can use http or ssh proxies to access remotes. This can be useful for c=
ompanies that have their own private repository mirrors. But because this f=
orm of proxy rewrites the url, the client must completely trust the proxy.

I propose a configuration that would work differently: a client would still=
 connect to the real remote for metadata, but before downloading data would=
 attempt to query a read-only cache. Any downloaded data will be validated =
to prevent spoofing, and if the cache does not make the data available the =
client will fall-back to the remote.

The intended use case is for a simple per-site cache, similar to apt=E2=80=
=99s DNS-SD caching (but opt-in). This is to easily enable =E2=80=9Cgood in=
ternet citizenship=E2=80=9D by allowing networks to cache cloned repositori=
es without needing the trust model of remote rewriting. While git was never=
 designed to be used as a CDN it unfortunately is very common.

Is this a feasible feature for git? Or are there aspects of the git interna=
ls that make this complicated.

