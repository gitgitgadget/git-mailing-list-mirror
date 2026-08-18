Received: from mr6.vodafonemail.de (mr6.vodafonemail.de [145.253.228.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFF83955FA
	for <git@vger.kernel.org>; Tue, 18 Aug 2026 08:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=145.253.228.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787043309; cv=none; b=C4TgS04hbkOBjyI1ENGTZMBTHtvG/bWbN34Mc3j28CUbPy+qyLZlGVDyaPBtBs3tiE7B4UYvdqicjqvWEPKHJvAza7QHF5G7GUd1y9GkdVojzKh+JFyLgBY0KMyi1NgWIlR55V4x8s9I6UZkBSe3wFyh04CidnToz3YHwTz4NKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787043309; c=relaxed/simple;
	bh=fXOPB6NRjl1drbM1jBrdGolWT4F/iHh4aZTKB9HreWk=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=sVuZD4XaNZmPTGG8XDga3SlXkKO2C/E4XDoKjJG2KZPqKkUJmEeRqizNN4bLaIYJSfnsU5cJe3Enr/CLicjvp3qK+lNrof5sLQQEjJ8y2m9fVOeU5GsrTTlpGK6uTc/eWa/yWQ2HF7pQQ+wVDfBeXLNO74g9Sw3/KPKx/wHHuEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arcor.de; spf=pass smtp.mailfrom=arcor.de; dkim=pass (1024-bit key) header.d=arcor.de header.i=@arcor.de header.b=ekZt3BiB; arc=none smtp.client-ip=145.253.228.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arcor.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arcor.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arcor.de header.i=@arcor.de header.b="ekZt3BiB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arcor.de;
	s=vfde-mb-mr2-23sep; t=1787042862;
	bh=i+TkrRgT2TiAsAMXy9v/B8QlPnxxH3UsZNAksaLm344=;
	h=Message-ID:Date:User-Agent:To:Content-Language:From:Subject:
	 Autocrypt:Content-Type:From;
	b=ekZt3BiB14ZVDpISD/s6imXihPiX1+wChQzy/9FqB3GkAQV7qxOjexjap7lbiO9KZ
	 l4w6MPs7qqf8cEaq3yjDqWfZT6M2g5gnqnfpMOrFrb82Mvksa5L5cIrFeuQV3jbW+r
	 nuRt8Q5ahjmYh4Y23SqGccdVtgHg9lRWZV8PmUrU=
Received: from smtp.vodafone.de (unknown [10.5.0.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by mr6.vodafonemail.de (Postfix) with ESMTPS id 4hPNct6Kwmz3sVhh
	for <git@vger.kernel.org>; Tue, 18 Aug 2026 08:47:42 +0000 (UTC)
Received: from [192.168.178.41] (p54b14770.dip0.t-ipconnect.de [84.177.71.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.vodafone.de (Postfix) with ESMTPSA id 4hPNcl2hJTz99Ml;
	Tue, 18 Aug 2026 08:47:32 +0000 (UTC)
Message-ID: <5f58630c-2490-4a38-9e77-75da906f429e@arcor.de>
Date: Tue, 18 Aug 2026 10:47:25 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: git@vger.kernel.org
Content-Language: en-US
From: Ernst Reissner <rei3ner@arcor.de>
Subject: Feature request
Autocrypt: addr=rei3ner@arcor.de; keydata=
 xsBNBF6Jtc4BCADNTYh6dRdI72yJas62kKaKTII7Us1T/GgJ49QU+9bcJwcvqc3Gn2ev9k5E
 OkanY5CNZ5txSs8HPHY6mtos0/lca+pay1aqQlon3DYmsPjoeDgjNyA9yhrk/jWsEk6RJJSo
 YYj96yNiWAcrTm0w07pqreZ9TY38WgtQGFRP+lSKdMW7Fbt8ax/BsTteR0vab/DsAHcwdZ6z
 4jlJwjSHPy2ccAdVGoYmvHWn/14Q2m3iNtN6uCIC2h1bSf80ADV3RWdZcCTcMDxialYBXQ+K
 z/lXnW/Fy2jvzqR/1Yg8MleKf2Bq5/8q1gcSM/p+6ABA1Um2yj7iFpwjdxgwgYSGT/iVABEB
 AAHNIUVybnN0IFJlaXNzbmVyIDxyZWkzbmVyQGFyY29yLmRlPsLAjgQTAQgAOBYhBKxbz5y9
 AfqOczpDRBB+MV0K2XvHBQJioQwmAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEBB+
 MV0K2XvHIxcH/jFQKFO9ZxR+gdjeMk2Rhf9c4H6eKZnTQT4YrEKvapvSgLDZzMnv7cnRMoSZ
 PVNPoz06iFsX6seoiP5Yupbi6xZMnhf8REahDrDcN8uLRLqjor7TmH0KUHCzdlLrvQm2pDLW
 da3oPwtjH2841PIzSDJFLP1/DEynsnIp5tgnSW/cpc2U0HkJGtOudfW0kyxbfF3TiPqGioww
 /vw+HNnIBwIXzMX3n2y9bOfolbTE66eN6D70aW9D0Xc6eirnGY3FbOrVFiPWqFrlgFTeXDJN
 T/TSsKnCz0Cd8SP+K+tp1s9l78yqwm1bbY+2RGVPeYejjj2+Au2WOq4XqZG3vNdHZNHOwE0E
 Xom1zgEIAL2G76VvfTtHyclOJczcHfbR0Im47SE9lRGXa46fWKq8RLePzXHvQdjP1yziYzh6
 oXPc7JxpCtk31be+D7vm990R5TQMAAevvyjlFB4rdPStRlOBiUpdMUQI+bZLK3WLkq0IdjlU
 bGKJTw+zu8NXw4Z8S8RFU7l5jpZ9CdX1IHIMP+QN3oN+pMgvMZ+9N3pBgsbk+tGBoLdV51cq
 cRkAAsDITkP+SmUQx3CzLxeCyOf5ZJvaO38nFHYciNbxzGd4UqIe4YXIjR9SGTb3Q6dGphlU
 1Xgl83F9wl/KoFfOaDCUM60Jc1IyOHA0I1vCYocm5czCEdeQx+yYvY6zXHObE/cAEQEAAcLA
 dgQYAQgAIBYhBKxbz5y9AfqOczpDRBB+MV0K2XvHBQJioQwmAhsMAAoJEBB+MV0K2XvHuBAH
 /j4LzPo5wSpfTxa+x+7lb2uWC3xYtPMRS4m7pxbY4mqlkVQLdK3kgkNsPZ4bJuQtS66lMiXJ
 XSXS9oGxvXYKzCsJc5DTOI/PcZUxrhGagBiXo/jI9cWGLjpNheSZBDnbxLnfm4K+YyvQuJ0J
 v1kR5mp1ALlwaOl93wSVFPzTmGzJAtJQKquptA0Ma3k3joY9hWa6/PnrgIZhJfEjod3074F2
 vce5bx5jAIwO7XrtmchUk1flHj4tnaEibLdbmVvtiTBrf3VGIjl7YcewQMfRvRvK5NncoCAM
 pFiHoW5qTrVi4Gr4J/atQEKalkN+xnVYAX5ChWfapN8q2LTny+kdehs=
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-purgate-server: smtpa05
X-purgate-type: clean
X-purgate: clean
X-purgate-size: 317
X-purgate-ID: 155817::1787042858-95A3E230-8FBF2AA9/0/0

Hello all,

Gittyup s possibility to index files linewise turned out to be very useful.

Me and some of my colleagues at work would adore very much that feature 
in git itself.

I did not find a place where all feature requests are listed. so 
apologies if this is nothing new.


Best regards,

Ernst

