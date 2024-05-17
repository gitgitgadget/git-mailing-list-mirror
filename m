Received: from tortuga.telka.sk (tortuga.telka.sk [185.14.234.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A0C13E040
	for <git@vger.kernel.org>; Fri, 17 May 2024 19:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.14.234.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715972566; cv=none; b=C+XoCPKTeHZwMInu95H+C1/bAhxMVnEkXQzamkY+sVb2Gbua0pvltwIWngZdk8Mg7T41405cBTjR03INv9flEIl6DHAnX0iV4Ek1SfvqPVTzYDf5rhrKe1hAxUM1Ys5+pPbZTLY45EkuXNb8xiGXNeLP6CBTZmSgaoLLwJ2h5j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715972566; c=relaxed/simple;
	bh=NmJB0ijvytC2CJx4KfRxJ5UxfLViP6IG3RJmHaSW880=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OoreRhVU5Y/hWEozAADi6SwOxuPosH/+FVlIn8giZKiBL0yFxCyCpZIj78go5XEE7n1p2SPLBzoGSHqy+UsNfTow9sbcPvHqwub+DbyorX/33uokfqHxl5ubKXKD6veA27N48feE8Zyv8OebQqwRjvuDmevAWTYxVZ7iR2SuqAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telka.sk; spf=pass smtp.mailfrom=telka.sk; arc=none smtp.client-ip=185.14.234.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telka.sk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telka.sk
Received: (qmail 615 invoked from network); 17 May 2024 19:02:41 -0000
Received: from telcontar.in.telka.sk (HELO telcontar) (marcel@10.0.0.10)
  by tortuga.telka.sk with ESMTPSA (DHE-RSA-AES256-GCM-SHA384 encrypted); 17 May 2024 19:02:41 -0000
Date: Fri, 17 May 2024 21:02:40 +0200
From: Marcel Telka <marcel@telka.sk>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] Switch grep from non-portable BRE to portable ERE
Message-ID: <Zkep0JWyh_7KlTy4@telcontar>
References: <ZkePejx-eRNrspZ2@telcontar>
 <xmqq7cfsiaff.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7cfsiaff.fsf@gitster.g>

On Fri, May 17, 2024 at 11:02:28AM -0700, Junio C Hamano wrote:
> Marcel Telka <marcel@telka.sk> writes:
> > Subject: Re: [PATCH] Switch grep from non-portable BRE to portable ERE
> >
> > This makes the grep usage fully POSIX compliant.
> 
> May want to mention that using backslash to invoke ERE feature in
> BRE is a GNU extension?

v2 is flying...

-- 
+-------------------------------------------+
| Marcel Telka   e-mail:   marcel@telka.sk  |
|                homepage: http://telka.sk/ |
+-------------------------------------------+
