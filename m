Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFC7391827
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 15:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773673778; cv=none; b=RI2lQIUPOGNj/1VGu2S/QGnDV/IcipAnhpsB2uUirUN/7KpB+zVzbBrRWVu/S1RP7AQ3RZyn+7KuB7Jq6ZD63W8gMMxh/oTKNFHaOYS0UaTrS7JnRkmPVsMDRap8eSMrEeK4vx6g4QZIA8cZxvP9Y/mo9SU+hU7i7wB5HMQM258=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773673778; c=relaxed/simple;
	bh=sdP81ZTuvJ2VTpqir/WHAjqbc5feBMhdhD4YpNJgIK8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=a8B8hYhgpUehqdOSpMR038TtFDBDcWEOtIfexOCOAkcT9fL+LXj1e4uaAMnm023G9QAXOa268CHnSWOUJ02GytdeZy2AWF89y44WcKMtMDdgT8fm7o1nJbHPF28y2lM59O1JgKmwBxBepz89jJQ1XNzM+3yJEkCJWtMw0FqFNzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=creativepost.co.uk; spf=pass smtp.mailfrom=creativepost.co.uk; dkim=pass (2048-bit key) header.d=creativepost.co.uk header.i=john@creativepost.co.uk header.b=xRPVZNH9; arc=none smtp.client-ip=212.227.17.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=creativepost.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=creativepost.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=creativepost.co.uk header.i=john@creativepost.co.uk header.b="xRPVZNH9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=creativepost.co.uk;
	s=s1-ionos; t=1773673767; x=1774278567; i=john@creativepost.co.uk;
	bh=yP5j9iwLCrsffo8+pMLtE/g+EX3EfA1/zDw/U42dKE4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=xRPVZNH9KuMiXQu0giBn6kAy24in8tgs8PwfzrY9E4cqmnT/xdecRhtEepwj3IMA
	 Kt090zGbxqbRTSUwpCE21Okj6qF2ZG+lVtmu6u8HLme1ON0go3HqLftFvAk0vI2Pi
	 WxNlZ8cHbLLvXzKiKQLGjvqQgj8sqB+m/Aet/ZiLsoStE25bYRUJXmEov9tpP2WyM
	 XACQdB1EghTu1f7C3UOg/OyaN/I9Ms/+TeIdhXPWXRhlui7cgC+VDIPtDjfZRe2Tr
	 UnZ8wjlYry48MpZNrUhsDvQ7Gpsr1womw5d2NUiDeqrE7DMK2TVSPOsOONb5ydrr6
	 OkjeVngIyAwfRNdbYw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue106
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1N6t3Z-1vXID33PuZ-013MDl; Mon, 16
 Mar 2026 16:09:26 +0100
Message-ID: <a6d27f02-bd40-4901-bb0c-0d3a763b512c@creativepost.co.uk>
Date: Mon, 16 Mar 2026 15:09:26 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: John Emmas <john@creativepost.co.uk>
Subject: Re: git --format anyone ?
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org
References: <457209f3-e998-4223-bdf3-57245bc51926@creativepost.co.uk>
 <ff0e899a-3d8b-4f46-8585-55881546423b@app.fastmail.com>
Content-Language: en-GB
In-Reply-To: <ff0e899a-3d8b-4f46-8585-55881546423b@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TQlMKA7M/++rUQRkDCKJdrV2NGNIKDvarSKmfnjKQPDbtXHqI/V
 OfKNvfdBWkanW9zMofW8YwgppUXXAQ0dIsFFLaR2OkBKI9+rh5iy0OspkrCXZNhzgUpBY/B
 wwSkaDgGA6DTKuaD7KfIoaNEkwOuOHnBHlysrV1DIDRWapbcBrDiLDXhZjyKc6OhLYBZDj7
 JqXpkrybsqmB+QhldT0rQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XzN5LfIerwA=;RYe6v+dNqUl2p9fsDbUbor5gDhl
 6hvQ8F0pGt1RpysLKJDLOJmvPAfdf7+QRCTT2irdDjh3/C4ZHX6OdoNQbDcb8jpMo6OSeUviG
 7Rbcbum+MiZ43qk30mjf5fbRaOMXLrJBGqCrhaxTgVOXQBtr/8XLcQswMtFEvp7j2E4FMIjBT
 ReuAumGVJUl/EqLB5p7Ni3wAkzD8OHLc4HrdHfg7h0W1Hqjv3IFv42aBFUWwF6PP+JYDBlqna
 iNyJIUsLjwVJmWGyJCEWwSXnSU005oiV09qUjCTj9LcCZUGe/S+E8KkCxod3s80YQSMPeJuSG
 5d//gMkR7O7J8XhNhBWwi631ElO0sUC52npLqKi42plff7F7G0gHirDq0BIBaLgXVhVALclU1
 D38c8gWmENUslklLLshuNKeykROVPgqCkGQec7xvwtSZQGtIy6SqEPuS6ICN+HV/772DlmUji
 PHQEEbs4yOap6zdCs1I2w/hmvlpqfcqGvoUWD/kWhlPuwI1PwJ9/C8ejLvsJvr8rFwCLGMrS6
 gannu+lecyPtG9lqajQ4A0ShIB+Y4+cQPyVQUs5uCfKt85J/99XymtGxsH1E+tDEquFhYXoC4
 pq8TNv8ZOIdq/pqf4ybQJT9idyPyJW35df+nYes0UC4v4r7Nbjuc33qOYJYEwGDKmGWmJi9Ix
 q7jK+H2wp4dt4DzQMDnBjMajFeVcVQ4aPZ7+mBYrAQ9VoVovHEqvMdilEujFSb2Z6avIbC5qa
 mn5VFn/HOGShe27ZYbysRXtSNUAOweJosubLZ4B20KX7E0pu2o9Ar1+HqijqfsJenFyB4bdQf
 SFtr0M22BCXwaR+KBkE0wrONwAadPbI6gp13ElktzeZ5mApyrHx4Qp8+J9FvqoXeDIVftr1Hi
 HHjmBTzyb4hQ0HFxkhlQRxmgwefmrLkRWCMuVs3DUqesQOMQylEZFV9q+VlRyNp4xJje8rTwF
 Zy8YTtycyJlfwHA7rXNuW9EX58G1qQS51Gqh7ElZm6W64re5XVM6vs5VLfXX65zwKjkYPmM+h
 B40outVWtFWu564uK75m6rrCGXvisS/vIooE0Xx3+J+o8xfgRWb4EdDyZL0iablqWQX5J2+Y3
 HDGTkF28wr7vkLwihe7gatwZItG1epCLH7+yvJnT8twIOXjxSZWZv9Ip4rteWXO2J1Oi9TB9o
 /QvfOcSIe/FGCqyk1C/d3xPGrgEN/kH40eiWZSU/cFoju0F4o0ZsbLcuz9+AIi1/x53lWmZmv
 YohrOHp5DLy1yvr3BHalEyMk2K4gnE7V3A6l0Rk+lVWIk096bmUd9ohnJunhg1FRHkWbU9Kii
 ooPJcgbaDBzhUSr56HgL31sdMRoHNBxzQJeL8/aBFRj6xvaAcHpRVRt8/VX5DF3v0r+xdkMxU
 o28V+zKISxZhhSxMW5s/dwgwzmmjuxjGPgk9a96DGHQFTNjXNN0BXXE+09Thw6e5MJhSAlwNe
 XSZC5igvG7stPzJHbvNnRjMFNi6eJ5nbyywSZ62oLPVT8llg0y/728zpvAdSnY77mZyiv5q+1
 0aoY8u47OwQUeZg7HpRNKRgWvRp5Yi9r35CAgY/x2gtBCZbRdSf2ATzf9WfCPIgrPDt72jYCh
 rLsyQbcc4LKiZtJ14Z9c1ePKkj+XVRXXh2P9JzVrl2LXBh7THhzKKt2SUqPmEJr+s4xODiWvF
 rzC2Du+JaXibP16dQ1obbrhd9BYSnJtj5MdruqweQfZvOwyFaFTg8owDwXi6+DlJK5hZEtqxq
 vBzrHdHLhZGZcD9Q3jwjJ+x91UyJPq9PvPYv1dQJEfexQuJTdTA8W61PMcRYes4nPCtLlcKmB
 7OueHyy9i+M3ly1Ycxr76sdTp6LLQRMJzqInzv8W5YGRsA9IbAlRbfwfodIvLMsNR7f2tOI0b
 rRQaldGuHITIdAF5A==

Many thanks Kristoffer,

I'd just posted some further information after realising there's Git=20
forum available but your reply makes a lot of sense so thanks for=20
letting me know.

John


On 16/03/2026 11:45, Kristoffer Haugsbakk wrote:
> The `git` command itself does not have a `--format` option. Some
> subcommands do like git-log(1).
>
>      git log --format=3D<something>
>
>> I'm working on a project which requires me to run "git --format" (with
>> various parameters of course).
> `git log --format=3D<something>` is for formatting log output. But since=
 a
> project =E2=80=9Crequires it=E2=80=9D could this be formatting in the se=
nse of formatting
> source code?
>
> You can for example use the third-party git-clang-format(1) on this
> project. But it is third-party. It is not part of the git(1) suite of
> commands.

