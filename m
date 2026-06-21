Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABFE134CCF
	for <git@vger.kernel.org>; Sun, 21 Jun 2026 13:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782048471; cv=none; b=YM3n2Zxs18R2fKNrRUiikQ533CbOu6E269+ezHX+IC5CMDouX19B/BrP+8fMTiLVdJZPajoEqgs9uevQXxI/ReMrkD3aYZr6x0yh5zMhmNT5BoOrrj5wJvoqZrZkT3QzCLkeYAEteVSzLKD/IpG+WBe0ns0S9088ctbaarliQYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782048471; c=relaxed/simple;
	bh=klH+mtCHdZOOTnp/LeayKbO7BJBDiDk5izwvpR4dA4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OmS3Dyb2rYfZcJHQOmwtSVBVVgcstyVyn3wW18wrKSfIOAYIa6Gn6AkgVUSmRD6pGE78QiGd+DypBr2B+vIXgt7BpA00DaTFZ69oYH4N3Jx+4jpD3bnBx97+qzuM1gu0Me6ZM/JrOw4CoiwcFojjQMjgPMRitkmwGXgRv98ZLP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp2.bon.at (unknown [192.168.181.105])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4gjsZq68r5z7Qw2W
	for <git@vger.kernel.org>; Sun, 21 Jun 2026 15:27:47 +0200 (CEST)
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4gjsZd3WNPzRnld;
	Sun, 21 Jun 2026 15:27:37 +0200 (CEST)
Message-ID: <c98bc105-f868-43bd-8268-52eb56e5a7c5@kdbg.org>
Date: Sun, 21 Jun 2026 15:27:35 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] gitk, git-gui: drop msgfmt --statistics output
Content-Language: en-US
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: git@vger.kernel.org,
 Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.2339.git.git.1781459539.gitgitgadget@gmail.com>
 <pull.2339.v2.git.git.1781995570677.gitgitgadget@gmail.com>
 <98718401-9ff4-4b1a-97c7-71f8b6639fea@kdbg.org>
 <CAHwyqnWM8GpYWOLdMtaF1YJ9mTRBtK0NCQeZE4AorO==7Mz2tg@mail.gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <CAHwyqnWM8GpYWOLdMtaF1YJ9mTRBtK0NCQeZE4AorO==7Mz2tg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 21.06.26 um 15:15 schrieb Harald Nordgren:
> Thanks for the feedback here. What do you want me to do now, should I
> update my code or you are taking over the whole thing from me?
The git-gui part is good. The Gitk part needs more work. Please submit a
new patch for Gitk under the topic "make `make -s` silent". That this
has to remove --statistics from msgfmt invocations is just a part of
this topic.

-- Hannes

