Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8483FEF
	for <git@vger.kernel.org>; Sun,  4 Jan 2026 04:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767502395; cv=none; b=Lh0MvZvU32XpD2a42knxoBss9xEHoLi1ESk96H3b1447zIjwOsiH8KY4ziyhvu8Zi4eKOgud13b/CK8WHigkSFGw6PooiR50vT00qK1WKdvaFmcrlx+NX7mCeQjcop/3fndcrv5iM281giRo6/BndwT0bxh7wzI29Ib1Gzmo2VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767502395; c=relaxed/simple;
	bh=9XuvRFeALxIkDSAsX7i4gcbWIacNtVrnnDcJZyeqCnk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=O5rVoLOyx+CsSBBtBmLOCGKtdeffRJ1Z7GU93QIXf7MwZ/ridL3Ul+BHpIvWvwNr1+OBdSFucxlxMT5/+fyLPHeD0GqKfLpsSwJcKE660i5SNeRd2EUDp3QIBZRCaAawABRuzcYBFOlWidhgBL+8E1r42Wy74RIi0iKgMkgtLvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land; spf=pass smtp.mailfrom=howdoi.land; dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b=VJ0rYo0r; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=howdoi.land
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b="VJ0rYo0r"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <ask+git@howdoi.land>)
	id 1vcG6t-00CPhT-Sx; Sun, 04 Jan 2026 05:52:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=howdoi.land
	; s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
	References:Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=+HS1geKSAeZ2expdXC5b9N8E37u0SXM1O0qC6/BJUuU=; b=VJ0rYo0rw/dV7YoB9FYC5V7rZ6
	RvWSaupVfLsIDwp1e99b1S4ouIaSNW7JNk5xFyjY017DKq/3d21619LRNtOK10Z1fz4vBVRj1mPUo
	yKGLdDRj3l/EdnKH6+8/Pdv6QFPmZs3qXZScKAVCgjJQiIpqLxrNu+hM/ZnlfP+DrPMHL16uh1odN
	E6BbudXTfPK9EGit35XDfsinDG9OSZ6Bfw7D46gkQO8R1vtm2yIGiFgquYD2PeFQ4piLfbpIpuSPH
	WB0ERhBjx/hf6ohtRR5Qo0WrSYUlAMEqgZOF+FleosF57bHBhOQ8qQkdBt89sy7yNCgnAKfHoz6Lt
	CTmoVNlg==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <ask+git@howdoi.land>)
	id 1vcG6t-0005nq-II; Sun, 04 Jan 2026 05:52:59 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1204229)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vcG6j-00GeaT-79; Sun, 04 Jan 2026 05:52:49 +0100
Message-ID: <e25b4d76-c1b5-4b6b-ba77-e1e2f7243ce9@howdoi.land>
Date: Sat, 3 Jan 2026 22:52:46 -0600
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Colin Stagner <ask+git@howdoi.land>
Subject: Re: [Bug] Git subtree regression
To: george@mail.dietrich.pub
Cc: git@vger.kernel.org
References: <176677910605.6.2281395015810449820.1087545551@dietrich.pub>
 <20251230170719.845029-1-george@mail.dietrich.pub>
Content-Language: en-US
In-Reply-To: <20251230170719.845029-1-george@mail.dietrich.pub>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello, George!

Thanks for looking in to this.

On 12/30/25 11:07, george@mail.dietrich.pub wrote:
> ---
> I explored this more and think I found the root cause.
> Commit `83f9dad7d6fb5988b68f80b25bd87c68693195dd` changed `should_ignore_subtree_split_commit()` to examine only a commit's own trailers via `git show --format='%(trailers:...)'`.
> The old code used `git log -1 --grep=...` which had the important side effect of searching through ancestor commits.

The old `--grep=...` approach was introduced as a performance speedup 
for large splits. I don't believe the original author intended to alter 
the split result, but the old approach inadvertently did in some cases.


> # 2.52.0 produces broken result
> $ git subtree split --prefix="src/components/clock"
> 0efb3d9858e3bfee65165508aeeacc50417c9a99  # 7 commits,

On v2.52.0 on my machine, I get an error instead:

      fatal: could not rev-parse split hash 
d0ed70566b3e962fbff71145d8155986b48c6885 from commit 
5817d4435bf448f526c3b0049f00e6500277e4bb

I presume I need more history than just master to make this work.

Can you test this split command in git v2.43.7? This is before 
`should_ignore_subtree_split_commit()` was introduced.

I'd like to distill this down into a minimum working example that 
doesn't depend on an external repo like athena. Namely, some shell 
instructions that start from an empty `git init` and create a repo with 
the bug condition. That way, we know exactly and narrowly what sort of 
history graph produces the bug. I think I have almost enough information 
here to do that, but you're welcome to try writing an MWE yourself.

> In a multi-subtree monorepo with this topology:
> 
> ```
>    main:    A---B---M---E    (B = subtree add --squash for subA)
>                    /
>    feature:   C---D          (D = subtree add --squash for subB)
> ```

Just to verify: in this example, is commit M a normal merge commit? Or 
is it also created with subtree?

Colin


