Received: from avasout-peh-001.plus.net (avasout-peh-001.plus.net [212.159.14.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42A47081C
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 03:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731468627; cv=none; b=iNBq2sLdnRYfuG9meSnjJIXnk3OLYIJXZHfo1U6Q+Fkvx/YqDCiesHPCe1eoW2OK+emND6oBLukgQjYcUi0ptiwn2bTIFG8B+gBdhxZBhmcRUqskjsrsox4TSVFwp5uese3y+YQC/oehpYMHap6310beUYdLwqeygX15ibIJNMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731468627; c=relaxed/simple;
	bh=IG6hyxmczAsak3grTi0VnAIxegMH6ZcgNI4GBEerhaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=glZ9GejnRHXosVSVtU2JJyG0mJ2B94jaH3gmQhHjtg3X4XM6ppVvV370xhDeA30GInr2KVM3qigUdPNHHj6ZDKSr8fbxP4VbqTMgECswD59L9crZcpcbHX/TZIx3gyYc4M4DBc7Li2FplybZpx235tChZsVDf0sLRUw1N59ituE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=N8Oe2qXW; arc=none smtp.client-ip=212.159.14.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="N8Oe2qXW"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id B45EtlZQUxileB45FtIyZx; Wed, 13 Nov 2024 03:30:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1731468622; bh=A6qT28tQPZBtabJorZJTaG8Vz/V0yIQ49mmiRIVZ/xI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=N8Oe2qXWBZSC/D81ZBicAwSItBOyB8l2s2VW6yezQtqCA0VFFJXnxJcPWAawEdCdJ
	 K2z5E81DlV4q93jZAjzMZZ76zsocWPbuKGZzsjCxz2b8GPOGD2Xr5CKo8oo1SvTzg2
	 1goH3zeEKnH8yTFhJ0QnfNhhSOpJw8ibbeEc4iDA9DqkPz+Wfs7I5+3lrh4YJLutnY
	 gGdXdLWLH6DwqIhU2HFonKYILX+UFn9BDIBCK+BHqbe882o1+YEB53lz40WPxFbEpP
	 e18IO+9oigIjI0nrXKANlYX14QLaiuaT/ZxpJkwfacIETnudZitBCOsnkDNuALajU3
	 p+RjDWbE0moOg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=VaJUP0p9 c=1 sm=1 tr=0 ts=67341d4e
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=NEAV23lmAAAA:8 a=Cg17eAtb_1GXvYkoA9AA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <94fa4a3c-c9aa-473a-a129-74edfd617a16@ramsayjones.plus.com>
Date: Wed, 13 Nov 2024 03:30:20 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [-SPAM-] [PATCH RFC v6 00/19] Modernize the build system
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>,
 Eric Sunshine <sunshine@sunshineco.com>,
 Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano
 <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
 David Aguilar <davvid@gmail.com>, Jeff King <peff@peff.net>
References: <cover.1727881164.git.ps@pks.im>
 <20241112-pks-meson-v6-0-648b30996827@pks.im>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <20241112-pks-meson-v6-0-648b30996827@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfByOre/+FNYy8i43LYhsfAwb87e0FlaATAjXIIkoe+Fqr/B7+MtLVlAz38swvl51YUugNG1oCSYnr9bOhu0gh3pMrBGrQPYtSF1TvKKp/SKWAWxuXhRP
 7PUXtmyaCO/P9iB12tT0gXnfXZ05e2Iyg2F3p7LzzwjSxjiT4Qnrc/gl7jqzznqvghQMkKz1eRfjUx6CxL3VfrERu8ik4HwEExA=



On 12/11/2024 17:02, Patrick Steinhardt wrote:
> Hi,
> 
> this patch series modernizes our build infrasturcture. It refactors
> various parts of it to make it possible to perform out-of-tree builds in
> theory.
> 
> The series then continues to wire up Meson as a proposed alternative as
> a modern replacement for our current build systems. It provides better
> integration into IDEs than our Makefiles, better usability than our
> Makefiles and CMake, better configuration and discoverability thereof
> than autoconf and CMake (which is of course my personal opinion).
> 
> The intent is to have Meson replace autoconf, which is mostly unused and
> broken. Eventually, the plan would to also replace CMake and our
> Makefiles in case we figure out that this replacement is indeed a net
> benefit for the project, but all of this would happen over the course of
> multiple releases.
> 
> Changes in v6:
> 
>   - Add documentation for how to use Meson.
> 
>   - Fix compilation in case libintl exists, but required tools like
>     msgfmt and related don't. Instead of failing, we now automatically
>     compile with the equivalent of NO_GETTEXT=YesPlease.
> 
>   - Update last patch that fixes semantic merge conflics with in-flight
>     topics in "seen".
> 
>   - I've changed the series to be based on "master" at b31fb630c0 (Merge
>     https://github.com/j6t/git-gui, 2024-11-11) as all prereqs of this
>     series have since landed. This doesn't make any difference though
>     as there aren't any merge conflicts or additional changes caused by
>     this. I mostly mention this so that there is no confusion around the
>     changed base commit.
> 

Tested this version, without issue, on Linux and cygwin (build + test).

On cygwin, the unit test now no longer times out:

  $ cd git/build
  $ tail test-out
  1030/1030 t9902-completion                               OK             114.74s

  Ok:                 1030
  Expected Fail:      0   
  Fail:               0   
  Unexpected Pass:    0   
  Skipped:            0   
  Timeout:            0   

  Full log written to /home/ramsay/git/build/meson-logs/testlog.txt
  $ 

Having said that, I was expecting to see an 'Unexpected Pass', since
meson decides to not set NO_REGEX. (The 'make' build on cygwin will
set 'NO_REGEX = UnfortunatelyYes' in the config.mak.uname).

In the meson-logs/testlog.txt file, for the t7815-grep-binary.sh test
stdout, we find:

----------------------------------- stdout -----------------------------------
ok 1 - setup
ok 2 - git grep ina a
ok 3 - git grep -ah ina a
ok 4 - git grep -I ina a
ok 5 - git grep -c ina a
ok 6 - git grep -l ina a
ok 7 - git grep -L bar a
ok 8 - git grep -q ina a
ok 9 - git grep -F ile a
ok 10 - git grep -Fi iLE a
ok 11 - git grep ile a
ok 12 - git grep .fi a # TODO known breakage vanished
ok 13 - grep respects binary diff attribute
ok 14 - grep --cached respects binary diff attribute
ok 15 - grep --cached respects binary diff attribute (2)
ok 16 - grep revision respects binary diff attribute
ok 17 - grep respects not-binary diff attribute
ok 18 - setup textconv filters
ok 19 - grep does not honor textconv
ok 20 - grep --textconv honors textconv
ok 21 - grep --no-textconv does not honor textconv
ok 22 - grep --textconv blob honors textconv
# 1 known breakage(s) vanished; please update test(s)
# passed all remaining 21 test(s)
1..22
==============================================================================

Note the 'TODO known breakage vanished' on test 12.

Setting NO_REGEX on cygwin is for 'reasons' (not necessarily good) and we
need a way to override it's decision here. (In general, we need to be able
to use *any* of the many build variables to override meson's automatic
setting of these build variables).


Thanks!

ATB,
Ramsay Jones



