Received: from avasout-peh-002.plus.net (avasout-peh-002.plus.net [212.159.14.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61BA29CE6
	for <git@vger.kernel.org>; Wed, 15 Jan 2025 03:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736911604; cv=none; b=rd95dr9RY2m90R7k+ZTKznRASQ0zAynqI37Ux0nsX89MopH8gqIOS9UydCIQ72joAQkW9B/ha1c+t54MdP+18y0MHoLR1gW1uoplnNn5b3xXl3v1+Hk1NWwqE7GODX6ZNEQUbNvxKaayfTUZvu4x2Qcgg/gkx0pjThKp6/SqG8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736911604; c=relaxed/simple;
	bh=xa172ZBvGvmQeHY40XK9vWDigaXBB5A9IFxwTcp7F6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CutqlZadXZCBALqyh2ZJAxNFxa4wpldhu0nEVt6ncmCL0GFhq8zinrYgWyHfNWhzwCA8UJucN4yaL4mwWLlEbo9f5sFZM1oEoPcFEDII0O+HHrKKK0W9QMonziKO5cYMCY9R4d6CwJuNMl0SpBPzkD2kZTVjs3UIdIFy8z5V0G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=GB6dro8l; arc=none smtp.client-ip=212.159.14.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="GB6dro8l"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id Xu35txjlZQyRxXu36tkNCS; Wed, 15 Jan 2025 03:26:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1736911593; bh=xa172ZBvGvmQeHY40XK9vWDigaXBB5A9IFxwTcp7F6Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=GB6dro8lDAFRc4LX9xNv4o090uGrRsgqvie4HrGX7sN9rq8YYehKQjk5DITXs8nls
	 SCBikOtZ37sq3+rYQNlRI1eEzFHrJBXHMbtNBE7ATIseirg9XfLC7bCYSkfcx7p+id
	 5JnvvIsWsU+6tNpQCxgUw5HAYFxXS4K02ER1ev0Z1emHHO9Jl/rzksdKshYS/yt3lX
	 wN3ghXhmFj0D1jX6IJx2k8JMrvPvy8qfynD5+PZFKNyBcNfiTEDlVY12dgrBcvXqW1
	 8wmvcFkx+8JTroBH5l/YKfTXhuiZBbiNjaBSXROgzopHMiH9sERAr/S+7WABTBa/uh
	 Xe/NtmagPvjJQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=XaAqz555 c=1 sm=1 tr=0 ts=67872ae9
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=NahVeR8y-pBmaMAARm4A:9 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <8c3ae215-5d78-4ad6-a068-701499646580@ramsayjones.plus.com>
Date: Wed, 15 Jan 2025 03:26:31 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 'seen' branch identifies as v2.48.0
To: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc: GIT Mailing-list <git@vger.kernel.org>
References: <6c5d0f90-79f0-4fba-8edb-f80d0665873b@ramsayjones.plus.com>
 <xmqqr0566u60.fsf@gitster.g> <Z4YXjCrtjCUjkEql@pks.im>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <Z4YXjCrtjCUjkEql@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfNKf5MhHJLpG6dEbguz9xJir8yL5rbZmXGg3jElC3enh9yx+FEtHhmK/3CQir0I+i1JFD38f3H+4TAIZpGj0jhXnW7l6mbTRydOoMw5C/spTH52iFIMp
 SnOpb/vQ4GV+3TY7C0XPQ+9NFKkN3baZJF+KWnKRKPc8i5VngVLLcnePJ4HeCLVei86x1ZZLz6U/M4H1cqZVc3QjNoMPtuA7AVQ=

Hi Patrick, Junio,

On 14/01/2025 07:51, Patrick Steinhardt wrote:
> On Mon, Jan 13, 2025 at 05:49:59PM -0800, Junio C Hamano wrote:
>> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
[snip]

> Yup, found the issue. The next version of the Meson series will have it
> fixed. Thanks for the report!

I suspect you already know, but I can confirm that tonight's 'seen' branch
builds fine (Linux and Cygwin).

[Sorry for being so late, but I had to wait for about 3 hours for windoze
update to stop making my laptop *totally* unusable! :( ]

Thanks!

ATB,
Ramsay Jones

