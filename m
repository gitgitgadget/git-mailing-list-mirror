Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA957466
	for <git@vger.kernel.org>; Sat, 11 Nov 2023 07:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=idiomdrottning.org header.i=@idiomdrottning.org header.b="0c0/K+KF"
Received: from halsen.idiomdrottning.org (halsen.idiomdrottning.org [74.207.231.133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC858111
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 23:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=idiomdrottning.org;
	s=idiomdrottningorg; t=1699688895;
	bh=IukzJhO1+nuigpaAh7Zmg/u8v3wCMCf7uIoEVVdrVBs=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=0c0/K+KFpoqbI6n099pQTfkTI1c5M9OkgtLwliyeQwWzHZHVXWISwVBGdQ0UHEOAi
	 lKmAZ3IQEfNYI5RGd/A74O3FM+ARyR1alBVhZQDB57D44U8xNFYqJ/fxHCa3rFk0bv
	 1Vr2VebrIaD+uSXgpbAF/prGXeJv+EFDLhNrhSB+JHFn3zr6f9Ddkg2NhcdHtbpvO6
	 kC1G6c8BJTyZgzM8jWdCBgEtmbwPQJORoYbe2VUaQpSKU1GLC8dfX98FMj5wymWRXP
	 LWKQ+09xLSaL+4ExE9eKYInivXhlKxNC9ZpROSLPq/mDs/vj9afg9rUX9X7G77eLvM
	 E8Vrrr8o4BSXA==
Received: from localhost (31-211-247-254.customers.ownit.se [31.211.247.254])
	by halsen.idiomdrottning.org (Postfix) with ESMTPSA id ACFC520431;
	Sat, 11 Nov 2023 08:48:14 +0100 (CET)
From: Sandra Snan <sandra.snan@idiomdrottning.org>
To: git@vger.kernel.org
Subject: Re: first-class conflicts?
In-Reply-To: <xmqqh6ltrs6t.fsf@gitster.g>
References: <87cywmintp.fsf@ellen.idiomdrottning.org>
 <002901da1101$7d39a420$77acec60$@nexbridge.com>
 <Gr..Y5kkszDx87g@idiomdrottning.org> <ZUmJyFs7z7wdmLVK@mit.edu>
 <xmqqh6ltrs6t.fsf@gitster.g>
Autocrypt: addr=sandra.snan@idiomdrottning.org; prefer-encrypt=mutual; keydata=
 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
Date: Sat, 11 Nov 2023 08:48:13 +0100
Message-ID: <87wmuohgsi.fsf@ellen.idiomdrottning.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed

Junio C Hamano <gitster@pobox.com> writes:
> Correct but with a caveat: it is too easy for lazy folks to 
> circumvent the safety by mistake with "commit -a". 

Lazy and ignorant like myself because I didn't know -a was that
dangerous. Thank you both!
