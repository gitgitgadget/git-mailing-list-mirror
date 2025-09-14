Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B303B2DC790
	for <git@vger.kernel.org>; Sun, 14 Sep 2025 12:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757854108; cv=none; b=u99Jijb2ItWL6IqyTYekWoA4tg1eq6YauZ1k1mJZLTvOVhG0e9bqf/3r/XGQ3rjg34FglgZzDH0/fP2jZWNVBqbqQktB+P8Y5DAWa15R2mY0ZPRVsbljI88oF+YldGtMst5wGIgxryXRv2TVLlhyxGiDr/o9XQVtNSYwXi/7JHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757854108; c=relaxed/simple;
	bh=cm2+HJKSAm6lA05MCVLU8KUBrRfJjeb764HXSKv6msA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tB7PiZAbgonqi+i63A4oFCPq+CUmazKmWaATzJE9VHagYA/DoBr0/H322zIffliFzxq9CMsNTtDiY1963AUeOdOTdMxOOCmQenu5VRL5ejL1vu1tN+fRnCh9tIvUoflUTdvpp+KdqHAsqbBnpVRNDIfQ9ajAZc0cdyEczVz0Uvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=HBCKnGkX; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="HBCKnGkX"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 7D276240028
	for <git@vger.kernel.org>; Sun, 14 Sep 2025 14:48:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1757854098; bh=zD34AjPYGaAsoP/zpujCD5ije5volfwve5fUsXyB/Kw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:From;
	b=HBCKnGkXSYbFY8uuzgexJzqZ4VaUQ4E7VVlDAx6vf+0DOcoCqaGCaM52k2r8EE+uV
	 V3su6djHZXZw9wIfUEvWU1uef4Yj8ImjwnEkGykMsVjMgPqSRnYP+86pAHMmcDu8lM
	 la6KB3gaLhU7z9cki9TRU7VGPJbmchcSm+NF2j/W3qT6i+PT9p5ni2IfHjUW+jiBBf
	 xty/UBJX6naR/4mEByx94X9gY8Kgp8fQAuKc3vBSvBqDv7/WuotcL1cjZZlX+yjVKx
	 64iNI1ltjfOuqcmomo9pZuzeFU6nf3t1Jb5iTl/KiSvjc8J9UUOQEFdBUplw0gSWgw
	 L4Zi4jA2dVJNg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4cPnyV0wGvz6v18
	for <git@vger.kernel.org>; Sun, 14 Sep 2025 14:48:18 +0200 (CEST)
Date: Sun, 14 Sep 2025 12:48:18 +0000
From: Bjoern Bastian <bjoernbastian@posteo.de>
To: git@vger.kernel.org
Subject: Usage of git whatchanged
Message-ID: <aMa5kSQVlhVX7Iii@eismeer>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello,

I still use 'git whatchanged' that has been available for a long time
and though being longer than 'git log --raw' is much quicker to type,
as 'git wh' is already sufficient for syntax completion. Obviously,
for this reason I won't use it with the '--i-still-use-this' option.

Best regards,
Björn Bastian

-- 
Physicist
Wilhelm Ostwald Institute for Physical Chemistry, Leizig, Germany
