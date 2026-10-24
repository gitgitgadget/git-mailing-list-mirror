Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.252.183.203
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792819949;
	b=Jf3bXz82UzL1BGF0cBOEvNUgdIG+FeIikwP7JWzOX66ADMh7XX1asqpJ1bWcOgO/EMKG
	 ofvneXfUfu6URaXyXWiPO1Z07pA97rl1wtx0JSd+Evu3ssWVWxaUaE6Qud9zlMshEKPnc
	 5UWNFlTaSqdjTA8BhjtyTvGngsQ7ZOEyJT40UxatXwIJxtlM3QOFusYlGP4dHF2Mn4HKl
	 neH51yj/REtRoloew4il3fTUEX+rKVExkPsHeSvWm2prmtaYKBNBXRobUt1H7cDrdPf2I
	 sGUl2GSA95sD6QUV7aO825faZbGqvUk9kZNFL52gqLLnA31VQbKRAuS3zwf6NWpxdDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792819949;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=9hJ91ZBnBzMIhJbVAMQWdgzavRcVwA+vpQtkUMP48jQ=;
	b=EinfwQprskUKzX7SPFVJmf7490wGWaCjvwhTfgW9lb5QFcUdXfOuHDv0F9SMLx2JDdAy
	 egC1VxIXhIkb38NQb/Kk1nl0FW5ZUjyNt8TF7ny6RggRRWnZly3T3ne5UK3zAnefdrcLn
	 H7QWkPiLyEqcMjsU6twE02J0iaDvKAgEBxedet1XGPLG+iT+MpiInckRLw4s5Or0iRU87
	 I760poVLjWGI39ZMmzjffu4qrqBV7tJRisO0NTOGNAAcLkfeecTrmNlATwKyTSbKoyW6Z
	 FQ8ga/ItOYYFIPkUHk0i2FbKxQFGg8egWkH2hG/m3gjvGDxyYLIFOkqmKtIblDSf+VA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=dev.snart.me;
	spf=pass smtp.mailfrom=dev.snart.me;
	dkim=pass header.d=dev.snart.me header.i=@dev.snart.me header.a=rsa-sha256 header.s=00 header.b=Vx4jHnPi;
	arc=none smtp.remote-ip=54.252.183.203
Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D61B606A32A
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 05:32:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D61B606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=dev.snart.me header.i=@dev.snart.me header.a=rsa-sha256 header.s=00 header.b=Vx4jHnPi
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id 20B3F1D485;
	Sat, 24 Oct 2026 05:32:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 embla.dev.snart.me 20B3F1D485
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dev.snart.me; s=00;
	t=1792819942; bh=9hJ91ZBnBzMIhJbVAMQWdgzavRcVwA+vpQtkUMP48jQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Vx4jHnPizhauo6lKk4z8r7DgOenenO9pXszrtX40e5d9FGElJPfTqFP/YuWkMvRMy
	 cXa94pl7pWHQSiiu0LqnYRx/a2Z/36NiuoyqLgjQ9KttnIxXbUs3X4aI3ASq6S27Yd
	 oY9IzNsLm+u44vZ5uRC221+ZGT9X8+PzpoGk+HOs=
Received: from [192.168.1.18] ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id YTv3KORC3GoVYgAA8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Sat, 24 Oct 2026 05:32:20 +0000
Message-ID: <1f919d03-d1e2-469b-9a28-393aee1e6ff8@dev.snart.me>
Date: Sat, 24 Oct 2026 05:32:17 +0000
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] advice: use global config for default branch name
To: Vsevolod Myalitsin <ub4nal@mail.ru>, git@vger.kernel.org
Cc: gitster@pobox.me, peff@peff.net, ben.knoble@gmail.org
References: <20270829004959.90983-1-ub4nal@mail.ru>
From: David Timber <dxdt@dev.snart.me>
Content-Language: en-US, ko
Autocrypt: addr=dxdt@dev.snart.me; keydata=
 xjMEYmJg1hYJKwYBBAHaRw8BAQdAf5E+ri1XLtjqYbZdHOyc8oS+1/XJ5bSlbx5WHXmVBZzN
 IERhdmlkIFRpbWJlciA8ZHhkdEBkZXYuc25hcnQubWU+wpQEExYKADwWIQQn/Jn96EMUaIoF
 X+T/ldyyrZpWaAUCYmJg1gIbAwULCQgHAgMiAgEGFQoJCAsCBBYCAwECHgcCF4AACgkQ/5Xc
 sq2aVmjJZwD8COjPlUwccrlRvbNQ6f87DWchtYO0o8W2DNRM3RLps0EA/jEhIbRV6AsyC8jr
 30Ut3aJ3/mO/6G4sLj7OvkEEBH0MzjgEYmJg1hIKKwYBBAGXVQEFAQEHQFpgtIgaByv9lIEY
 EmpavMO0pYjtu7TMJynwdnGYkN9LAwEIB8J4BBgWCgAgFiEEJ/yZ/ehDFGiKBV/k/5Xcsq2a
 VmgFAmJiYNYCGwwACgkQ/5Xcsq2aVmhFCwEA0kM9VyYB4bLCM7+SuXUUH+5Ec99Nj4RXxFad
 Key9GuwA/2BZK6bNyrLSfEk2JDRoskqf7OIL0wa6JOD5SrBnMe8E
In-Reply-To: <20270829004959.90983-1-ub4nal@mail.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> Subject: [PATCH v3] advice: use global config for default branch name
> Date: Sun, 29 Aug 2027 03:49:58 +0300
> Message-ID: <20270829004959.90983-1-ub4nal@mail.ru>

Check your system. Sending emails with bogus timestamp is a big no no
especially with modern spam filters because future timestamping is one
of the techniques spammers use.

Davo
