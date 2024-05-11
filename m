Received: from 3gy.de (3gy.de [202.61.255.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FE34437C
	for <git@vger.kernel.org>; Sat, 11 May 2024 13:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.255.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715433557; cv=none; b=R3hNyCXA6nRYvw7D9AJscb5i7SAp8gaj2IebhCLE2zWyTFX4iDT66oc+k4FimY4v55Hr/FrBwyQ9Q/2wfBqOTF1H7iVXh7/VfilWVZbubZHHkPKBhKrce7r5E4Rl1pDk7cJPNqni8dk/J3XsPYg8Expcy8FX4ctcpTuwJHK5n+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715433557; c=relaxed/simple;
	bh=44MqClqpYwyWDoKV0nfyKHsLJb63UF+rwQub09y2W1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sVONU/sILlKxwblHIKS7iEcJ/lR+8BNUI424lqKmMDFJvR2zNHU/moWg1CBPb//N5XqklsbqdZimW5Pi4xmOCSs6HEnKpfY4cBje7QfkBjkeTPclBeTObaSKeiFlwPMPFt1zx/b2Qur/ii+gpymh9uEd25KRNobSVTJP98vQ8Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=syscid.com; spf=pass smtp.mailfrom=syscid.com; dkim=pass (2048-bit key) header.d=syscid.com header.i=@syscid.com header.b=XGMc5YbR; arc=none smtp.client-ip=202.61.255.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=syscid.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=syscid.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=syscid.com header.i=@syscid.com header.b="XGMc5YbR"
Received: from [IPV6:2a02:1748:f7df:9c80:c412:abff:fef2:22ae] (unknown [IPv6:2a02:1748:f7df:9c80:c412:abff:fef2:22ae])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
	(No client certificate requested)
	(Authenticated sender: georg@syscid.com)
	by 3gy.de (FREEDOM) with ESMTPSA id A3B5333EAD90;
	Sat, 11 May 2024 15:12:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syscid.com; s=light;
	t=1715433150; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references:autocrypt;
	bh=3eVUoOuFdSumjuiB14YzBmOImY/4aXkMVPTA35lJKGA=;
	b=XGMc5YbRvEicWcPZAt2nqGtm/5z+RJ+C/ZiFgbrOdDT95aiXMlT1gOS14l/8ZAlA9bh5up
	Xk3KXVoxGlYCJKMvmPh9J7aKO04nuZ6W899zsX4PkwagDbp+t728hLC0Gv+txJFDWRCmwE
	yKz9We9wVNxGLyL1d+q1IW3PE+LjFuAzSKhauwfOyhDjit3wpdFvaUTPhLFh4NX+b3QJpp
	Slu0teALWJJWf/9CwKVphAn3t7ac8BpEeRO41SCjl9GJn/gMXrTvwtPwAH2yC+GMWxU1Ro
	kVCkE2V3uxzqhKsnIUPoH2+iwFS0ixAY/dt22g2SM9N8lqbH05ye+F+txjLTVg==
Message-ID: <7c11e562-8476-4b0f-aadd-14695065b80e@syscid.com>
Date: Sat, 11 May 2024 15:12:26 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: git shortlog --committer=name is documented, alas not implemented
Content-Language: en-US
To: Gerald Pfeifer <gerald@pfeifer.com>, git@vger.kernel.org
References: <77e42d15-fcaf-5c1b-3a00-f1f1e3cedfc4@pfeifer.com>
From: Georg Pfuetzenreuter <georg@syscid.com>
Autocrypt: addr=georg@syscid.com; keydata=
 xjMEYP4ABBYJKwYBBAHaRw8BAQdAGRcet1cOGT+IejiQ4pe4FLnoQjFlftdc7RQcy1GXYAvN
 J0dlb3JnIFBmdWV0emVucmV1dGVyIDxnZW9yZ0BzeXNjaWQuY29tPsKRBBMWCAA5FiEEP8y5
 xN1VTzTg6AyMPa/ybD555YgFAmD+AAQFCQWjmoACGwMFCwkIBwIGFQgJCgsCBRYCAwEAAAoJ
 ED2v8mw+eeWIUJAA/1la/PBCwI2SCzryFSkO9GBVkmr+T0bNDLRgRGpFH2/DAP9brlOfg3jd
 ypCRS4E2i/angkiZtrm7308U4JOcA9ODA844BGD+AAQSCisGAQQBl1UBBQEBB0BdKJwL2WgH
 sH4xx+ZhWkw4kF6pRpJmG79K8cvhpS8wCAMBCAfCfgQYFggAJhYhBD/MucTdVU804OgMjD2v
 8mw+eeWIBQJg/gAEBQkFo5qAAhsMAAoJED2v8mw+eeWIdjcA/R7NYDoA23hdax6XPKrjeM9H
 4N2JhY/CO8+qHVtClUjUAP9erXFrEtTmuB1fXOjruD3EPbO6tj75gk8QZbeHFxTnDA==
In-Reply-To: <77e42d15-fcaf-5c1b-3a00-f1f1e3cedfc4@pfeifer.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 5/11/24 14:34, Gerald Pfeifer wrote:
> `man git shortlog` (from git 2.45.0) has the following:
> 
>     --author=<pattern>, --committer=<pattern>
>         Limit the commits output to ones with author/committer header lines
>         that match the specified pattern (regular expression). With more
>         than one --author=<pattern>, commits whose author matches any of
>         the given patterns are chosen (similarly for multiple
>         --committer=<pattern>).
> 
> Now `git shortlog --author=gerald` works as expected.
> 
> However `git shortlog --committer=gerald` results in an error:
> 
>    error: option `committer' takes no value
> 
> This is either a doc bug or an implementation issue?
> 
> 
> Also, how does one list all commits by a certain committer (as opposed
> to author) then?
> 
> 
> Thanks,
> Gerald
> 

I think this is not implemented for shortlog, and the man page is 
confusing. The --author=<pattern>/--committer=<pattern> section in 
git-shortlog(1) (Documentation/git-shortlog.txt) is just included from 
git-rev-list(1) (Documentation/rev-list-options.txt), but only the 
--committer argument documented in the "parent" git-shortlog.txt is valid.
