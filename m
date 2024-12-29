Received: from libero.it (smtp-18-vd.italiaonline.it [213.209.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8246A3214
	for <git@vger.kernel.org>; Sun, 29 Dec 2024 10:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.209.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735466522; cv=none; b=ge6kQkVLD5Ht25GC5jP63o2t9OUcazGJ03smrVXTfKtlytK34Yf/+OIIvewPix1WQ2jf5Cf0YvlSzbPn2eJYIkJCeH4r/2vC0nrIjuuvvRIOi+wjWzi+Sv7zeRID319366mge58+U3UntfInouWwFjGVpvjB+3snyJ8A480Xi+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735466522; c=relaxed/simple;
	bh=6ZFqrLJV+qA+ZUlinnYYevIwhgp6pTlg3nqnwcN/Zd8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=W8Zn+iR8Doex186Or68dnzoRGlmjZ7i1ZxjurY5+OqA30OagmA1aZz8M/APwo2lX05qAN/4CM1u07nh2SEKLTfa6spT0h+0NQKtajtlANWf1aw6INFHREa1DAviV61kTzd8Sl+5UQVHYIllbMRQuQ9CZCnaSifG5Tld9OfEhPZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it; spf=pass smtp.mailfrom=libero.it; dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b=WHq8j5+6; arc=none smtp.client-ip=213.209.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=libero.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b="WHq8j5+6"
Received: from [192.168.0.129] ([188.27.146.10])
	by smtp-18.iol.local with ESMTPA
	id Rq7RtnoYVgetmRq7RtROGV; Sun, 29 Dec 2024 11:01:58 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
	t=1735466518; bh=GDsxod0Y1wAY44yNRYj4MoeFjhWKM7UsA04tNS/BhLw=;
	h=From;
	b=WHq8j5+6IdVMu2hZ03c0qXJBacJRYvsqqXYfpY+3V0r8DkEiwtT1DhOBZbZc47gxV
	 1tGXoEFKXdpz939e/OTyKWdf05xqE++SBJIqDQv0nJPUiJuEkQ6Nb0l+OICjLZX/gn
	 hhaY+G463JaxqS+V+KseTgfl1inB6mM3KTk6phFGypVaR/0MaqvgqvOEphdkZahrcH
	 HSyXqAe2ULCNKwoiyU5mFXbpRysitlm1/KjyrJ46b6hVdMui3baB0zsOAp1grx4H5B
	 lpYRcZovR+yZVZQz/cJcU4xhy/9ZujBB8mSCEMNlS1RBITtCXCD8XARZLF1Z99Q1cw
	 cmBiPp5g6bWVQ==
X-CNFS-Analysis: v=2.4 cv=QPmjRRLL c=1 sm=1 tr=0 ts=67711e16 cx=a_exe
 a=nouTapptOgoxzTc4WCMdog==:117 a=nouTapptOgoxzTc4WCMdog==:17
 a=IkcTkHD0fZMA:10 a=f7IdgyKtn90A:10 a=zP1U1BMpm3EJbaN69RQA:9 a=QEXdDO2ut3YA:10
Subject: Re: connecting the local main branch to the remote origin/main
 without pushing
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: git@vger.kernel.org
References: <a69c4e2e-cbb0-c242-a34a-8997a84fefb7@libero.it>
 <87h66nk9uy.fsf@igel.home>
From: crstml@libero.it
Message-ID: <5dfb85a8-2e26-92f8-e3f9-5e3fb89ca43a@libero.it>
Date: Sun, 29 Dec 2024 11:01:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 SeaMonkey/2.53.18.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87h66nk9uy.fsf@igel.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfIHgUf1L2t3y0csBe4bTDWbrTRl2W54+LBzKV0EP6Mjzc5oQnUlCOjFT4ILm91f4uUtHg6n2ekx2fpam5ETL7xKQn4+zW/Lgo1quzcO8Kd8/sG0tndRr
 1PUsos1sBJAHaQdCz4JEV+4MeGjGl5fJyJPeqwSh18G9vq3T4BBX4KLmdQLaBnuHnLMypaVGbvi21EhsqRqgOryh8wqagv7eJwzk1Kg7ALi5izpZGeGw2Zfm

Andreas Schwab wrote:
> On Dez 28 2024, crstml@libero.it wrote:
> 
>> My question is:
>>       Is it possible when applying the method 2 to have (without pushing)
>>       the local main branch connected to the remote origin/main branch as
>>       in the case of method 1 which by cloning connects these branches.
> 
> You can establish the effect by setting two config entries:
> 
> $ git config branch.main.remote origin
> $ git config branch.main.merge refs/heads/main
> 

Indeed.

By making a diff between a folder containing a cloned empty repository (method 1)
and an empty folder in which "git init" and "git remote" were run (method 2) the
only difference is in the .git/config file. In the cloned version the file contains
the following section:

[branch "main"]
         remote = origin
         merge = refs/heads/main

These commands add exactly this section to the file.

"git branch -u" does exactly the same thing when connecting a local branch to
an existing remote branch. It adds this section. "git push ---set-upstream"
also does the same thing.

It would be nice if "git branch -u" would work for an empty remote repository
and allow us to set the upstream branch.

Cristian





