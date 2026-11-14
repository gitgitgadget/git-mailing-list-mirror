Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.61.206.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794694163;
	b=fx+UOXm2o8ANqnTTAUy4eURmhzDplpS1EGsLKtX3qwjAH7pxXR2s24eM+CqOgHsc51fg
	 kuAMEgtwKUj6+L5BgYcrF7+iZF9MpCo6xxh0reLQbR/EkPl22pjOVFKPqnEqZ1PlGITry
	 2BDdE7Ul5iR5sKlyiHCjPeCfv+vXSUnkcD3ZtSK0W2e09K/xbuQviLHFS1ZHefXT7Rg2Z
	 4X5APfx+smg5ftq97SYOuzfgZO1FmZ9vIOkY2dKXI4ASk5vKSEbZfHjJtxlq8GuP8VLvE
	 oXa5FGqdbKqJxWLiydrsKT3OP9CaEY2MbnFLx56GtFp09T6j9NTege3eAFFHpmEWK2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794694163;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type;
	bh=pKUKfCzuhrG/8m6TQRuNrRpembJFZjn/jStgAhVmyMA=;
	b=f05TGv1EXgfI/eeySmME1Bckh63ryJDLXV0/GTp+K4mJuHU5ePOq50uJBgv9kk4vziFa
	 tdJJ1DijjvyB3rlaT9L7eGxtv/JN8eR+HoJoNrzlHe4brtsFMBOC9ztwS71YMRwlbcQUq
	 E4LzpJ5Bqv0FE3LbG/h43vKktkGxD3pukbCWB8sQXtO5WKqTtC8/Odm4V16yInDNJSNws
	 6vtdFUgPBwByw9YHVLOgRq6izHv2TKjYVc8BHHfRgvCgeF7beEjQ+ID1Rgj+AZWgoFP0v
	 PR8NI9obwj17uOcH7PCgJR5UOzeglg7RhQ6lGBa3dCQ1jucsqoGZMWbM7zJlE63xXoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gouders.net;
	spf=pass smtp.mailfrom=gouders.net;
	dkim=pass header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=oK8xZk37;
	arc=none smtp.remote-ip=202.61.206.94
Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F80E606A323
	for <git@vger.kernel.org>; Sat, 14 Nov 2026 22:09:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F80E606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=oK8xZk37
Received: from localhost (ip-109-41-49-131.web.vodafone.de [109.41.49.131])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.2/8.17.1.9) with ESMTPSA id 6AEM9FJ51613321
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sat, 14 Nov 2026 23:09:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1794694156; bh=sdHuhqs3j7JiaLOX86ptiknP26/xs9Ob8KXiMJdpeT8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=oK8xZk37vUlUeTT8AR/tUTUv56ZBSFJAbR2wZRXZTGUf9MLEE9XwdoKtOJ4XprXk5
	 YCKhTURN+XnO8na6h+aec+TtyrpZQvxtLMAseB5gzk++ioiIw6LLDxGLTOPbvDwh+f
	 4tSvXZTnQesus1quZeYQV7JvnpdMQkRlqJfysOLY=
From: Dirk Gouders <dirk@gouders.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/1] doc/gitcli: minor fixes
In-Reply-To: <xmqqik1znkn8.fsf@gitster.g>
References: <20261114201632.103400-1-dirk@gouders.net>
	<xmqqik1znkn8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Sat, 14 Nov 2026 23:09:15 +0100
Message-ID: <ghik1z6p6c.fsf@gouders.net>
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

On Sat, Nov 14 2026, Junio C Hamano wrote:

> Dirk Gouders <dirk@gouders.net> writes:
>
>> -This manual describes the convention used throughout Git CLI.
>> +This manual describes the conventions used throughout Git CLI.
>
> OK.
>
>> @@ -28,7 +28,7 @@ arguments.  Here are the rules:
>>     `v1.0` and `v2.0` are revisions and `arch/x86` and `include/asm-x86`
>>     are paths.
>>  
>> - * When an argument can be misunderstood as either a revision or a path,
>> + * When arguments can be misunderstood as either a revision or a path,
>>     they can be disambiguated by placing `--` between them.
>
> I would rather have left the subject as-is, and then rewrote the
> conclusion part to "it can be disambiguated by placing `--` before
> or arter it".  Once you start talking about multiple arguments, you
> would have to also reorder them so that all revs come first, then
> '--', and then all paths. 

Thank you for the quick review.

Yes, there were two possible fixes for this second detail.
I will send a v2 according to your suggestion.

Regards,

Dirk

>> @@ -76,8 +76,8 @@ you will.
>>  Here are the rules regarding the "flags" that you should follow when you are
>>  scripting Git:
>>  
>> - * Splitting short options to separate words (prefer `git foo -a -b`
>> -   to `git foo -ab`, the latter may not even work).
>> + * Split short options to separate words: prefer `git foo -a -b`
>> +   to `git foo -ab` (the latter may not even work).
>
> OK.
>
> Thanks.
