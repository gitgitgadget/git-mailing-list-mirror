Received: from avasout-peh-004.plus.net (avasout-peh-004.plus.net [212.159.14.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA43827A92E
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 22:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759444900; cv=none; b=tsmIzsiH3SWjpcDglJyzJBwaxUbayTzMxqIeKKimfQxP1XSf1Vpcffv1TqtTX2yXgOph9FRZIkz3ZVhDZhI1gwNVkHMqZRtCRzf6AGmV96dSu2lHofdpq2+/2Eg2VVxj0Mk/4pU3136VmCfVWigh+M8U+UU+6mWdfdPR5kiSXS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759444900; c=relaxed/simple;
	bh=CsEJ7i9pdlZ/jWpCX7VNLogw1mRAGuPlKFdVi2x0914=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h3lLSYtT51ENNvtPBhJ6Q0JGaKKaEDQrcnt/CnUtMbgJSHRhJzNVKacipZS0/Kekj0FYGt3it/HhcHKKVUiwfVopVXDHxkoFWdWM5QK9PfxJlCImWbbuRfSiQl1eSNpkRdruMzdmGowi4oGHlr0Yim+iCO5IZcFB5MB8bX3mgSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=jDdPCkLD; arc=none smtp.client-ip=212.159.14.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="jDdPCkLD"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id 4RwRvyd9uuTGq4RwSv8F1C; Thu, 02 Oct 2025 23:38:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1759444708; bh=GiHFVZvuob+RM+GpNgrmzJ1bsFep3S3KhJ5zwn5Jthw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=jDdPCkLDOgSbRB1lMbx8HQAUaF4/DTUKcHoiNCGBnEK9zTFnXPk8yeoBcfLXK6hg/
	 f736N7nMqeAaWRjOz4MCo1mMDXZfo6ob3DjxaDb6WNW97Sg/pxVylKHmjvwssj8/1b
	 ugVcK4g39OZbVqTH+AO8eiV/4mHfq8QZ20lqrj6IAb8Evaw8n4VQY4JXL+vp3Ypznw
	 8ys83N+l8URL3N0ea3BrT2j3vMJLy/B9equLjUGB6tEvA213psqeTaKxdeoiEuWYiX
	 sDe6/8Dpt4F33cScMZNrfXho1nhg6S5/ozpI7wTnc7e/WbuJUl9h+c4twSVUwqYQqk
	 7NQ3T69bxrkVg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=A8/PPLWG c=1 sm=1 tr=0 ts=68defee4
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=EBOSESyhAAAA:8 a=O0-fusOIRW93a0NXmtEA:9
 a=QEXdDO2ut3YA:10 a=UzISIztuOb4A:10 a=QYH75iMubAgA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <1a72434f-7935-4d0c-868f-03bd24601d4d@ramsayjones.plus.com>
Date: Thu, 2 Oct 2025 23:38:27 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] technical docs in make build
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>,
 Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <https://lore.kernel.org/git/bcb3b3a3-bb13-4808-9363-442b5f9be05f@ramsayjones.plus.com/>
 <20251002221233.541844-1-ramsay@ramsayjones.plus.com>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <20251002221233.541844-1-ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfAyzDJg+nBDRvtyYVg9U+zFzoPpRGGJEPzs0nUywToTEKTfI8ThZ7o6Qp5albTCQV59+Fhd6tLcva8JwWeWXtB4REW1nsTxMoP0sS+shp+dQsQByUbBj
 gIf//HxKKY+H8RmEQjVObeli/mULjQxxioU/0JRlB+Ijs0Wgc24Y9Wbg1FJDgJaTdvKKaevz7cgRbnStJulPfHccH0xFapZKOOQ=



On 02/10/2025 11:12 pm, Ramsay Jones wrote:
> OK, so I have recently developed an intense dislike of both asciidoc
> and asciidoctor. :)
> 

Heh, sorry about this, but I messed up the threading (again). This time, for
some unknown reason I pasted the 'lore.kernel.org' URL for the v1 cover letter,
rather than the message-ID:

    <bcb3b3a3-bb13-4808-9363-442b5f9be05f@ramsayjones.plus.com>

I shouldn't be allowed to operate 'git send-email' after dark! :)

ATB,
Ramsay Jones




