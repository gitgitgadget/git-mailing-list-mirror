Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.232.247.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793020432;
	b=34y1bhGbNv4i7j5nY27lF2sdGZTPyJYrWNbihhg9Xe2xvSTYbIdO+NzuZ37yxtIIqFB1
	 AoVzf6tr++d3rEIivUubiOa8pz4+MvUJGYY5OWafMFsGxuT13BcNYHbyqUlRA8QuZJp2h
	 D0YBz4eNP9zJyA/mRSpEBIQ16btbCiJF4bMC9oCQvbHPrtRF55QQWpPzEwI3BzTXqAh7S
	 y8bzvJXthNzXBldfnyCnXtU+AQe4Gx621w4pdd2oL05sfQFzjI/vF3lWBZ13hUvBikyO/
	 elOHg9Toh3J9yTAvCbxxvu3h/E79ukJTUG6ygEFM7/FefDJPu2uYm2Af7z4NHn3RXoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793020432;
	h=DMARC-Filter:Received:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:In-Reply-To:References:User-Agent:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy:X-FEAS-BEC-Info:
	 X-FEAS-Client-IP:X-FE-Last-Public-Client-IP:X-FE-Policy-ID:
	 X-FE-Hostname:DKIM-Signature;
	bh=U92KI5e1XZYW3t204om7+vy2yNmNBZM76Fh/130sNu8=;
	b=k7Ij6O8vR47zoRpliYzhKiTu9LF62V+5C9IZqcJ/jck4r6E+0hBxe8u79JD2PELkO72c
	 KArMyExAk9hi0nFaf4p9sh88hvPmnZdd3UntIYPzRASlepuBE9t4XdT7lhaq1sI8D1luD
	 MnHORZwoFFPPx/woGawJHuTnYXsCM1QqeY6+77Yy3PzOGGiTF8MgUiqCF4n3f18xBJXeE
	 3BnQD1Sqsp/yAcs+zYzekc1OFxgYcJjTNX8vtL87ioPz8J7q1aQVkFQxyJ9QrnnQz64U2
	 3kcsAaJaDl5Fm6Q/M644F7J8hd7yzvywnsPIgUz++glWhLAHCm8Vtn+rLm1HZH8ydJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=utu.fi;
	spf=pass smtp.mailfrom=utu.fi;
	dkim=pass header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b="Z+/yWz61";
	arc=none smtp.remote-ip=130.232.247.4
Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA62606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 13:13:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BA62606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=Z+/yWz61
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 69QDDeHk020343-69QDDeHm020343
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 26 Oct 2026 15:13:40 +0200
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1xLKWC-007kxz-8l;
	Mon, 26 Oct 2026 15:13:40 +0200
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 26 Oct
 2026 15:13:40 +0200
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 4e0c6e85;
	Mon, 26 Oct 2026 13:13:39 +0000 (UTC)
Date: Mon, 26 Oct 2026 15:13:39 +0200
From: Tuomas Ahola <taahol@utu.fi>
To: Julia Evans <julia@jvns.ca>
CC: Julia Evans <gitgitgadget@gmail.com>, <git@vger.kernel.org>, Kristoffer
 Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2 0/2] [doc] Remove gittutorial-2
Message-ID: <20261026131339.aky08%taahol@utu.fi>
In-Reply-To: <85254bd4-19a1-4ce5-b61a-dd3057389c36@app.fastmail.com>
References: <pull.2241.git.1790627122.gitgitgadget@gmail.com>
 <pull.2241.v2.git.1791231610.gitgitgadget@gmail.com>
 <20261006055002.M9X9O%taahol@utu.fi>
 <26a10538-525f-4160-8719-b82968c39261@app.fastmail.com>
 <20261026110008.Rixj1%taahol@utu.fi>
 <85254bd4-19a1-4ce5-b61a-dd3057389c36@app.fastmail.com>
User-Agent: s-nail v14.9.22
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: ex19-10.utu.fi (130.232.247.50) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhZW0gCHQQBCSgCHgYbRgsJSFhI
 WkhZXEhZW1hGWltaRlpYX0ZcX0hQSFhIWEhcSFhIWEhYSFlRSA8BHCgeDw0aRgMNGgYNBEYHGg9IWEhaWkgPARwPARwPCQwPDRwoDwUJAQRGCwcFSFhIWVtIAh0EAQko
 Ah4GG0YLCUhYSFtaSAMaARscBw4ODRoACR0PGwoJAwMoDgkbHAUJAQRGCwcFSFg=
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type;
 bh=U92KI5e1XZYW3t204om7+vy2yNmNBZM76Fh/130sNu8=;
 b=Z+/yWz61NPfzBWU3/xiyOdJK/gBzaw8+koqVWY6QWcq/ecRaieYGXpgS4lLZe9FHJGlEKzzE9TXj
	KYvOpIWQ+R/9CPXsWquwZagymqHmXoNKEngTi4KxFcYMbpL2bQwRlgig6SfEk0b1vFhcbTJL0IwY
	I7Rn6u8gqmaJMzalqXzBALQa+/+4T9sbv0JLMrIYUvSU5RtgGLukqoPKa+LmcE7VklZsPtyt9jxj
	r2wVmEStcu+/kGDDG3DH/rdzA8ojaDW5pLtZFsWnLuut54L0EGQRcdOnbWMjQ1JWLVPfaLISvvnq
	pak4h9iwEEiv9bneQWCWjeSQpbV4LV2X+CRTpg==

"Julia Evans" <julia@jvns.ca> wrote:

> >> 
> >> Agreed that we shouldn't advertise an obsolete tutorial. 
> >> I'll remove it from `command-list.txt` on my branch and submit a v3.
> >

That is still a good plan.

> 
> Oh, after I wrote that I realized that gittutorial-2 is actually already removed
> from. command-list.txt on my branch. 
> 
> Or at least that's what I see when I look at the version of this branch in
> Junio's repo. So I'm not totally sure what the next step is here.
> 
> $ git show junio/je/doc-remove-gittutorial-2:command-list.txt | grep tutorial
> gitcore-tutorial                        guide
> gittutorial                             guide
> 

Are you sure your remote-tracking branch isn't stale?  It seems Junio removed
je/doc-remove-gittutorial-2 some time ago.[1]

Links:
  1. https://github.com/gitster/git/activity?ref=je/doc-remove-gittutorial-2
