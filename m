Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFC4188938
	for <git@vger.kernel.org>; Thu, 12 Dec 2024 18:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734029915; cv=none; b=A75r1qpbJuCuSyiBufgoD5JZPx1kTWyFF0h7nkofkomz5fKLFbEXNwoLae+a1Bw495QbiF1Z1mUZ/VtO2R4OdcadR/uEeaviZTCRE/IE4cJUSgBGrgxsP2ebt6mFQ4OdoswxPps2w8BgXFnmWYWAQrPB9ENeWEidTQYJgJt90lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734029915; c=relaxed/simple;
	bh=3Pwok7ubHBf52+S06Px9tTWFlocxKBBTeLqDq8T/crI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RgMjdy5ZKuemE6CYxGn8uoK1z1y5g4/45xmvWhOe3DGY42Z0Zhkbp6Gd95s/nBcGoqdhwUTSh2xasGJAftf1sYPkUnw2SNiZbQLg99Wt1Es0Kk+CPH9katsIaHp90hZsWdP4fm5KScnhwJiURyN9ZDkEvvlQ8gwgEkCc6T3DaPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp1.bon.at (unknown [192.168.181.104])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4Y8MF34xWHz7QWlM
	for <git@vger.kernel.org>; Thu, 12 Dec 2024 19:58:31 +0100 (CET)
Received: from [192.168.0.106] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4Y8MDp3VMVzRpKl;
	Thu, 12 Dec 2024 19:58:16 +0100 (CET)
Message-ID: <c6cc8704-6043-4e6d-bc4a-d9801a372710@kdbg.org>
Date: Thu, 12 Dec 2024 19:58:07 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] gitk: add text wrapping preferences
Content-Language: en-US
To: Christoph Sommer via GitGitGadget <gitgitgadget@gmail.com>
Cc: Christoph Sommer <sommer@cms-labs.org>, git@vger.kernel.org
References: <pull.1835.git.1733767737.gitgitgadget@gmail.com>
 <e116685568e4f1db3bc71985945f0ff4e40e12fc.1733767737.git.gitgitgadget@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <e116685568e4f1db3bc71985945f0ff4e40e12fc.1733767737.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 09.12.24 um 19:08 schrieb Christoph Sommer via GitGitGadget:
> From: Christoph Sommer <sommer@cms-labs.org>
> 
> Add a new preference "wrapdefault" which allows enabling char/word wrap.
> Impacts all text in the ctext widget for which no other preference exists.
> 
> Also make the (existing) preference "wrapcomment" configurable graphically.
> Its setting impacts only the "comment" part of the ctext widget.

Nice! I agree that it makes sense to wrap the comment differently than
the patch text section. I notice, though, that the patch text wrapping
is also applied to the commit header section. Personally, I don't mind
it. If someone needs a third option, they can take this patch as a
blueprint.

-- Hannes

