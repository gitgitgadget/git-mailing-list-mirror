Received: from mail.codeberg.eu (aburayama.m.codeberg.org [217.197.91.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E6E2DFA32
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 09:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.197.91.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767692720; cv=none; b=AGd574vkOa6Ppka2vBGCdwHizkFV8oQMsfhhMUMB4aHwKCBQM0oFS9L4zDXfuOFnxU998smF32D1qxaI02BlVlDvunVwwmsakk2c1vyVlfgRRmeUVq9l8+xyIpgC9j4tKjf4wY0aNVtSe8j5OQvnTAvdBltphcboGuYifJlrgSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767692720; c=relaxed/simple;
	bh=KFRAB4Vdf9kE5v5t2C7EMX02E4tj34BCofZ+OwR0fs4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iTX5HJnLInPSdWyWvuJA9xvmCdWrHGopjQIQ+pV05RDkXhpH3CK5urKTPxVbNPqrgJc71WWDoiOcHCoI2OqTx7i11OZLhhRsOE66rVKjc5j6INL083t6T5TVLgz+clvubj2E9l8TulJD3jz8fzeMMHZlA6avAuJ/razJiPZ+8OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codeberg.org; spf=pass smtp.mailfrom=codeberg.org; dkim=pass (2048-bit key) header.d=codeberg.org header.i=@codeberg.org header.b=MDWS/Vbx; dkim=permerror (0-bit key) header.d=codeberg.org header.i=@codeberg.org header.b=NgU7q04n; arc=none smtp.client-ip=217.197.91.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codeberg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeberg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeberg.org header.i=@codeberg.org header.b="MDWS/Vbx";
	dkim=permerror (0-bit key) header.d=codeberg.org header.i=@codeberg.org header.b="NgU7q04n"
DKIM-Signature: v=1; a=rsa-sha256; s=202510r; d=codeberg.org; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1767692576; bh=ErWZxW3DP3rzrlojRzw0frC
	XvljIzs7WXTjAz6YEuTw=; b=MDWS/VbxyQzvmFnHpxrkuECz2vDnwfZU0trzcSsevR3DE0nCnR
	xIoFtohOsp7COvi15jCJfX/ei3uzo2gu1jc7Rgo9gZlNPXvX6X0FHawVMHcZjrK8V3OKM7dSBH4
	WCpyI/epf7tbI+4ygoPZlHYe54Esb/PbwK6BIh77TbzpRHNiANFozgfvXr3fKzApstrKjWgxHoR
	9xoy4j1t1a60neFo2rIDGAKA5etuZreHC7red3IroWQIKizRIvvvb2EIAT0P/gKPUASVteVrjOb
	WxJ9Y3Puarj4czPZ5GDXrQpuomhzSkYkuGp+lER2tiRvQ+SKKElEqw0nLqfxvPDBvaA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202510e; d=codeberg.org; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1767692576; bh=ErWZxW3DP3rzrlojRzw0frC
	XvljIzs7WXTjAz6YEuTw=; b=NgU7q04nIHe0bGAOv0tT5ddJUTCs5Ce/b5P/R0EX7hJAExYO5P
	B+05mliAcuU8NZuDvm/otCABN2Ma1w0b9uCQ==;
Message-ID: <eecb1c9a-4dc9-4666-b2af-1e3478109db3@codeberg.org>
Date: Tue, 6 Jan 2026 10:42:55 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: git-last-modified on bare repository
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Toon Claes <toon@iotcl.com>
References: <09870987-ae2f-44ec-b8a0-1654f598b5fd@codeberg.org>
 <aVvSwkK7RdpFDaVv@pks.im> <8e6dd4d7-6e0a-477a-b10c-8571d6b7da4c@codeberg.org>
 <aVvWDDtBeJMIF3F0@pks.im>
Content-Language: en-US
From: Gusted <gusted@codeberg.org>
In-Reply-To: <aVvWDDtBeJMIF3F0@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/5/26 4:17 PM, Patrick Steinhardt wrote:
> On Mon, Jan 05, 2026 at 04:06:39PM +0100, Gusted wrote:
>> On 1/5/26 4:03 PM, Patrick Steinhardt wrote:
>>> On Mon, Jan 05, 2026 at 02:35:56PM +0100, Gusted wrote:
>>>> Hi,
>>>>
>>>> Now trying to actually make Forgejo use git last-modified after being
>>>> pointed to the non-yet-documented options but I quickly noticed that it
>>>> looks like it does not work as intended on bare repositories when looking
>>>> specifying files.
>>>>
>>>> $ git clone https://codeberg.org/Gusted/math-accuracy
>>>> $ cd math-accuracy
>>>> $ git last-modified -- LICENSES
>>>> 768f05837e7db2832425bc3b65d0f524e81b2769        LICENSES
>>>>
>>>> And on a bare repository:
>>>>
>>>> $ git clone --bare https://codeberg.org/Gusted/math-accuracy
>>>> $ cd math-accuracy.git
>>>> $ git last-modified -- LICENSE
>>>> fatal: ambiguous argument 'LICENSE': unknown revision or path not in the
>>>> working tree.
>>>> Use '--' to separate paths from revisions, like this:
>>>> 'git <command> [<revision>...] -- [<file>...]'
>>>>
>>>> Is a worktree required for this to work?
>>>
>>> A worktree is not required for this to work. The problem is that you've
>>> got a typo in there: you say "LICENSE", but the actual file is called
>>> "LICENSES". If you spell it correctly it should work alright.
>>>
>>
>> Ah, sorry the typo is on me from copying the wrong command from the shell
>> history. It produces the same output with using LICENSES as path.
>>
>> $ git last-modified -- LICENSES
>> fatal: ambiguous argument 'LICENSES': unknown revision or path not in the
>> working tree.
>> Use '--' to separate paths from revisions, like this:
>> 'git <command> [<revision>...] -- [<file>...]'
> 
> Hm, interesting, this works for me in a bare repository. Has this
> already been fixed...? Indeed, bisecting this points to 05491b90ce
> (last-modified: support sparse checkouts, 2025-11-29). So you should
> probably try with Git's "master" branch.
> 
> Patrick

Yup, git from source works! Do you by any chance know if 05491b90ce is 
going to be in v2.52.1?

Kind Regards
Gusted
