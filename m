Received: from avasout-peh-002.plus.net (avasout-peh-002.plus.net [212.159.14.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFC53D6494
	for <git@vger.kernel.org>; Fri, 24 Apr 2026 13:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777038170; cv=none; b=Xpgz3c6HGiXrzwaWi/Yra+X76XXHeXlmCAHp8zTj4oab7f9dxFElv7ykG1jaDzdcOwlqv+K0clnaktMi4dg1bUFB6WNHn42dy7Uoc1nl5SPscRXDtibJGiN1WNZfZxhhwVImkkOesoJxyp5nONcRkdngPRmYT3fZSLj0LIvucww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777038170; c=relaxed/simple;
	bh=ruTKLfL8H5XMbjs0FRPPvkpeoGMYg5iSuqSvu7N8qRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iJoKt1Aex3egQm+q3xg+iUuoMB7QG5faSwbQQAmY43cEaWQbRd5Y5hrK2uWbxsV9JVgIDNGHCnafLiMNUpHvPqHGBVNL0WLN0KKIWspKlxhcjhI2FENdC8T5+XL4dzKQ2us+RSEc4RVEryJOhFy6fALHsyfvQ1naZA93xqsh7H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=QXyV3qWG; arc=none smtp.client-ip=212.159.14.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="QXyV3qWG"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id GGnrwLub2e3PcGGnswdzDc; Fri, 24 Apr 2026 14:42:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1777038164; bh=a9ZaJfWzmzTsaNAzGQa1MQzpo5xzzgmcc8VklVc6ffo=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=QXyV3qWGNFxN5eH4H/E20Nuq2o+Wtjqjb1zB2vhBRqGWWR4NEA1mmNyP+XWaj+Y0r
	 bYCcSEPGaxjSnQMMqxsdWjbHf+pxIbq9bXxLcelgOT0QCGqTihGJC+RUUlHHy89f9j
	 OY5d1zEEFwnl1I/iVyGJADd/m3RFUw6vpzjK8yYa9pTir2ae576x1hhKK8nb9jIe6h
	 lyqadvOMZ+OhTN9+VWfCnIyyoxeSs+K4/x2rB58HHQZu+XK9C8+96Nyjk4GESVPuWz
	 Ihhjlls2hRIQqIjFLa/DWuz6Dbgmjl0Pib9ziZXRbd/ygDaCxHDkAmyhAxAEecAuTf
	 ajJxFA3rnMkWA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=FMy4xPos c=1 sm=1 tr=0 ts=69eb7354
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=zd2uoN0lAAAA:8 a=dWPJbuHlvdT9mBR47oEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <cb3bcb25-ed95-40ec-a924-c9924a025c87@ramsayjones.plus.com>
Date: Fri, 24 Apr 2026 14:42:42 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Problem with git send-email and --reply-to
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 git@vger.kernel.org
References: <26f3a5b2-1656-482a-9349-ca3592b8bba1@amd.com>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <26f3a5b2-1656-482a-9349-ca3592b8bba1@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfBhdxa1RtM+0B7cw/GzCO4GXV5hFg8eFTlSHmvsODMdKReQkfn9yry2wvrAIKuK+0t7+7w1B+GPPVYVTFO8BsIThewkBTaHHsxIJ6ktcZIoR3GcBnRDa
 Ek1Opw3fm4JupuQjRRYyco8hhp4NAXpbUgXI9t21sUbKXeyHuQTZTjdsUfajui3NnAy+nqxbxkIh2JF1RWTvhmVz/ofFTj0qlRY=



On 24/04/2026 2:13 pm, Christian König wrote:
> Hello everybody,
> 
> either I've found a bug or there is something absolutely not obvious going on here with git send-email.
> 
> I want to use the --reply-to option with git send-email to make sure that people reply to my AMD mail address and not my gmail address used for sending mails.
> 
> When I use the option on the command line it works fine, but when I put that into my .gitconfig it doesn't seem to have any effect.
> 
> Any idea what could be wrong here?
> 
> .gitconfig looks like this:
> 
> [user]
>     name = Christian König
>     email = christian.koenig@amd.com
> [sendemail]
>     reply-to = christian.koenig@amd.com

I don't think this is a valid config variable. It is not mentioned in the man page.
In the source, it is noted as '# Variables we fill in automatically, or via prompting:'
in addition to being part of the command-line '%options' map. So, ...

Sorry not to be of more help.

ATB,
Ramsay Jones



