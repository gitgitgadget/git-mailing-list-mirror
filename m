Received: from mail.codeberg.eu (aburayama.m.codeberg.org [217.197.91.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3934733B943
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 11:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.197.91.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767614066; cv=none; b=NIlIKInw5wkxE+etBhcmi/giAhWAzOoi1k2v09CfNedlHmZSsfajn/+XVuJyTSlBnyR5ezOmL0HbHWGmLQLsHMXUdm9OQFnW1rpdYkeOniYmDmswwxSLbtSvQiy3qSaWM7ZGZV5HJG3fpD47yW2+9TqKVp5zDgDzhgu9CvKseVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767614066; c=relaxed/simple;
	bh=VtmCcbccABoudww+3XxADcx+9Sjpmijb84rnvZXjPr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YG/1Zo/rOaVpfJR+rhEcA9qDUvqDX8JoR/O+RWVHuwLIDmdvF0pwq1qY/7KmFPZTbJtE6INkdmbMyvbiUIg0z8dysey6YI7nWS5fXD/4nowrpeeO1ox7zLOaWV3PAw3DC1raCbyKoo+C/zqC3INkhPiSiy1Nn/jeyePvwHKd5rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codeberg.org; spf=pass smtp.mailfrom=codeberg.org; dkim=pass (2048-bit key) header.d=codeberg.org header.i=@codeberg.org header.b=JF+LT0kt; dkim=permerror (0-bit key) header.d=codeberg.org header.i=@codeberg.org header.b=yuN/WM0d; arc=none smtp.client-ip=217.197.91.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codeberg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeberg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeberg.org header.i=@codeberg.org header.b="JF+LT0kt";
	dkim=permerror (0-bit key) header.d=codeberg.org header.i=@codeberg.org header.b="yuN/WM0d"
DKIM-Signature: v=1; a=rsa-sha256; s=202510r; d=codeberg.org; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1767613921; bh=F5vzb7FlauxwPj7n4bUsy5+
	jWqdBd705/LT4DQpO4D8=; b=JF+LT0ktEy5XTvCyau9LjNy//JK4w02Vi1izuvcaRTK7dlFRJG
	lFzujPyl6qoYOngGHWKIWSLzUriKTu3MFu4xOqhdJWFhmaBTh4yUJ5GaSjBg3UGO3ocgGM91hlD
	S/eAt2IOpDNiMBY84LLitP+61rOdJcSZ0EsYCqWjJRJrur2iXOaYoctjTdwIdvtglzRKghwjmkX
	guEenQch8dtuIFmUde/H65cpREjFv3p4/XpIXpDEVIfFqS5jk65cJfFj0t47JJYO+ehKlsxIIux
	x8KnsTC8uw8/GoHVrxI2UaVW9SMlnLDMCWzm1S1fS2mwQSc2diPtWx+PS5OBC0rALRQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202510e; d=codeberg.org; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1767613921; bh=F5vzb7FlauxwPj7n4bUsy5+
	jWqdBd705/LT4DQpO4D8=; b=yuN/WM0dyljxWRkqRGc5k+Ym2s5nYHBPLfOBkGIt8uFXeCIgJz
	R4Wb0Ak0pF3nAbiplFOBd3ap1qIvs2dpLsAQ==;
Message-ID: <4b6fe686-bb3d-4d10-8a4d-7542b4c93e45@codeberg.org>
Date: Mon, 5 Jan 2026 12:52:01 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: git-last-modified weirdness
To: Toon Claes <toon@iotcl.com>, git@vger.kernel.org
References: <406222e6-d10b-47d8-a177-de5912db4512@codeberg.org>
 <03f96860-29fc-42a7-a220-c3ec65eb8516@codeberg.org>
 <87v7hgpbrk.fsf@iotcl.com>
Content-Language: en-US
From: Gusted <gusted@codeberg.org>
In-Reply-To: <87v7hgpbrk.fsf@iotcl.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/5/26 11:57 AM, Toon Claes wrote:

 > Gusted <gusted@codeberg.org> writes:
 >
 >> Hi,
 >>
 >> Resending this mail as it looks like it might not have arrived (couldn't
 >> find it in the mailing list archive).
 > Thanks for following up. I didn't see it yet.
 >
 >> For Forgejo, I wanted to look into using git-last-modified to gain extra
 >> performance for larger repositories where this can often result in being
 >> (one of) the slowest git operation. However I noticed some problems that
 >> looks to be bugs.
 >>
 >> I've ran all the following commands on the following Git repository, 
on Git
 >> v2.52.0 (Arch Linux) and my git config does not enable or disable any
 >> feature that should've impacted the any of the following observations.
 >>
 >> $ tmp=$(mktemp -d)
 >> $ git clone https://codeberg.org/forgejo/forgejo $tmp
 >> $ cd tmp
 >>
 >> During some experiments I noticed it being slower for some files. An
 >> example:
 >>
 >> $ hyperfine --warmup 5 'git log --max-count=1 DCO' 'git 
last-modified DCO'
 >> Benchmark 1: git log --max-count=1 DCO
 >>     Time (mean ± σ):      86.9 ms ±   0.8 ms    [User: 70.1 ms, 
System: 15.6 ms]
 >>     Range (min … max):    85.5 ms …  88.3 ms    34 runs
 >>
 >> Benchmark 2: git last-modified DCO
 >>     Time (mean ± σ):     151.3 ms ±   4.3 ms    [User: 133.4 ms, 
System: 15.9 ms]
 >>     Range (min … max):   145.4 ms … 167.1 ms    19 runs
 > In my local benchmarks I see similar results.
 >
 > I agree this isn't great, but git-log(1) is just very good at logging a
 > single path. git-last-modified(1) is mostly designed to give commits
 > for a bunch of paths. For example:
 >
 >      $ hyperfine --warmup 5 'git ls-tree HEAD --name-only | xargs 
--max-args=1 git log --max-count=1 --format=oneline --' 'git last-modified'
 >      Benchmark 1: git ls-tree HEAD --name-only | xargs --max-args=1 
git log --max-count=1 --format=oneline --
 >        Time (mean ± σ):     852.5 ms ±   9.2 ms    [User: 703.8 ms, 
System: 141.9 ms]
 >        Range (min … max):   841.9 ms … 869.4 ms    10 runs
 >
 >      Benchmark 2: git last-modified
 >        Time (mean ± σ):     141.2 ms ±   2.0 ms    [User: 133.0 ms, 
System: 7.9 ms]
 >        Range (min … max):   137.7 ms … 146.0 ms    21 runs
 >
 >      Summary
 >        git last-modified ran
 >          6.04 ± 0.11 times faster than git ls-tree HEAD --name-only | 
xargs --max-args=1 git log --max-count=1 --format=oneline --
Only using git-last-modified when there are more than a few paths is
okay for how I want to use it. I was not really able to deduce this
from the manual, the general feeling after reading Github blog, Gitlab
blog and the release notes of v2.52.0 it looked to be a good
replacement of git log -n1 in all cases.
 >> This might be me misunderstanding the feature, but it looks to me this
 >> cannot be used for paths that is inside a directory. The following 
two commands
 >> yield the same output:
 >>
 >> $ git last-modified -- web_src
 >> 24019ef5e83fd7bed7f31ad09dd8d5f26b4bdc69        web_src
 >> $ git last-modified -- web_src/svg
 >> 24019ef5e83fd7bed7f31ad09dd8d5f26b4bdc69        web_src
 >>
 >> Where I expected the latter command to return the last commit of
 >> web_src/svg.
 > I agree this is confusing. And I plan to propose a change to this
 > behavior. But at the moment what you're supposed to do in this
 > situation:
 >
 >      $ git last-modified -- web_src
 >      28e0af23faf6c8e8f353ba2ae818ee0f83fd3e5c        web_src
 >      $ git last-modified -r --max-depth=0 -- web_src/svg
 >      b8f15e4ea09c6571872607874ae099269ea4b201        web_src/svg
 >
 > I plan to change the default behavior to basically behave like `-r
 > --max-depth=0`. But I'm happy to hear your input if you think it should
 > be something else?
 > There's some context here[1], but as said, I might shift direction a bit
 > toward making the default more intuitive.
 >
 > [1]: 
https://lore.kernel.org/git/20251126-toon-last-modified-zzzz-v1-0-608350df0caa@iotcl.com/

Oh, there's a whole new option! That's exactly what I was looking for
to get that behavior. Only returning the root level information by
default looks and feels silly and does remind me of git-diff-tree's
default, so I would agree on having -r --max-depth=0 as the default.
Returning the information exactly for the paths being given sounds most
reasonable.

Although given you mention that this command works best for multiple
paths I can also imagine -r --max-depth=1 as default to nudge people to
use it for that purpose.

 >> I'm not sure why I tried this, but I can trigger a BUG when giving 
it some
 >> nonsense input:
 >>
 >> $ git last-modified fb06ce04173d47aaaa498385621cba8b8dfd7584
 >> BUG: builtin/last-modified.c:456: paths remaining beyond boundary in
 >> last-modified
 >> [1]    690163 IOT instruction (core dumped)  git last-modified
 >>
 >> `fb06ce04173d47aaaa498385621cba8b8dfd7584` is the tree commit id of
 >> web_src. I
 >> suppose this should've returned a nice error message or blank output. It
 >> does
 >> give a blank output when you specify a valid path:
 >>
 >> $ git last-modified fb06ce04173d47aaaa498385621cba8b8dfd7584 web_src
 >>
 > Hah, that sounds like a real bug. Thanks for reporting, I will look into
 > it.
 >
 >> Kind regards,
 >> Gusted
 >>
 >>

Kind Regards
Gusted
