Received: from avasout-peh-001.plus.net (avasout-peh-001.plus.net [212.159.14.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2B53F12E5
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 18:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790273529; cv=none; b=EDB9kHeYglcqEjwi9FTFgyxaPKsdmXtY9Uk0A6KZpc87eCNg4yFevthSAp4HEOTrMZZuBWmRTrn7q5ijeAWqXxMNXFt9bfjYvnH/Gd/hSyaf8/SQcqHNwreyZmYwgFJQzM/wSzcFIOmHEu7jE5NecAeVvsFCgNA8c4Ay4olzkwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790273529; c=relaxed/simple;
	bh=Um/ms6aKTsrbMI+qjrV9E93BejybecHc4FvQ6CQcypc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pm59bKIHYrjAUGOnWcin4KKbIJDqYyKGKt/auwjCPbbiuxPfRos8ATgq42R3l0SbfLHuZCyGxluCHe3cNvHO7pavXiFw0RBh31KGyo5K1j0Hf7GyNSIS0gRPWCi5zGEW8OoRP9gbSpxkHlJPMXOLYq0IOuzbUQDhkOmLdsXpy+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=nTq3WNLv; arc=none smtp.client-ip=212.159.14.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="nTq3WNLv"
Received: from [10.0.2.15] ([195.99.11.174])
	by smtp with ESMTPA
	id 9nsLxw7CK5WHg9nsMxAD1f; Thu, 24 Sep 2026 19:08:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1790273335; bh=6WEz62JjHDVPARtu/mY48qiXR7cQNseAv7NeuRKfMVE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=nTq3WNLvythq5dhBlky4CIeeIvyN3DMx4ApVThzoHXbYfdTZFtXA0mSg/F6netQqw
	 /Z8Te+K/gzz0I8qYx7aensUgeeZ9apSHhZiw1rEMLD6nZbi2qGCn1tCsosrIq/CU6c
	 dqxzBDw8+NaWp75Cqm5Qz6ZmpTH6K7N2VYEuT5P858hrzQboRnly7pxDhjoqVCIPUh
	 qllOw9VfA2RotyVncKloOpoACc5PSiXsWN219bni2kVJHiFPMLuxK+4QtkTe1gmzM2
	 pgvWhhZKWSxUAkRp8Rj7ziiZ/5d9XWnhPWLRkxU4nUb5oU5OHbNcTdPM1E1H3Beqd4
	 7W4uaBS84QIFg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=dpt4CEg4 c=1 sm=1 tr=0 ts=6ab56737
 a=rWEfxJwGD0TuYe46u5FB7A==:117 a=rWEfxJwGD0TuYe46u5FB7A==:17
 a=IkcTkHD0fZMA:10 a=CCpqsmhAAAAA:8 a=ybZZDoGAAAAA:8 a=YJ8ixoa4bHfJ0UeAcskA:9
 a=QEXdDO2ut3YA:10 a=h2X0mqEp8x8A:10 a=ul9cdbp4aOFLsgKbc677:22
 a=0RhZnL1DYvcuLYC8JZ5M:22
X-AUTH: ramsayjones@:2500
Message-ID: <d1ad4da9-e5b6-41c8-8049-0d8ac012a1e2@ramsayjones.plus.com>
Date: Thu, 24 Sep 2026 19:08:53 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Git v3.0 timeline, was Re: What's cooking in git.git (Sep 2026,
 #08)
To: Junio C Hamano <gitster@pobox.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org, Adam Dinwoodie <git@dinwoodie.org>
References: <xmqqwlsei1pv.fsf@gitster.g>
 <76ac51df-cef8-c6a9-2610-8c21f03c6999@gmx.de> <xmqq4ifhgzvx.fsf@gitster.g>
 <5f34a5a9-9f72-b725-666a-94798895d122@gmx.de> <xmqq4iff5ml0.fsf@gitster.g>
 <xmqqpky346fr.fsf@gitster.g>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <xmqqpky346fr.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfBOESRBfjw/gk6ViArLnJ3Z59EVgKGwrpoP4liNuT9dwIWrrKKNm/Uz7mGiL0ei+GCAQcjrqOk6gEP0/eLrsnUU/MFlR72benzaAn3oJPKe2KM1VZ1MY
 qbm+o/0ZHsHsYvYIkZCX0KItG3jA9JSWLjlrSOfPbiEt/C4KnC4AxLu+JpqWK0JXBQjsMSlxZMzUBoL7PW53Y1CaurYSmYUfkaU=



On 24/09/2026 5:30 am, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
[snip]
> As I wrote, after the current cycle ends at the end of this month, a
> 10-to-12-week cycle including the end-of-year slowness would mean the
> next cycle, 2.98, will end at the end of this year.  Extrapolating
> from there, 2.99 will be March 2027.
> 
> The consensus in the room was that we want to use 2.99 as a signal
> that something big is coming, so there needs to be some lead time
> between 2.99 and 3.0 for "advertisement".  This lead time between
> 2.99 and 3.0 does not have to be the usual 8-to-12-week full release
> cycle.
> 
> I do not think there was a firm agreement on the date for 2.99.1 and
> 3.0.  Potential factors mentioned in the room included that we may
> want to match the LTS release schedule of major distributions.  My
> preference would be to give a month after 2.99 to apply only
> accumulated bugfixes and nothing else, and tag it as 2.99.1, which
> means 2.99.1 would be April 2027.
> 
> The contents of 3.0 should be identical to 2.99.1 except that
> breaking changes are enabled in 3.0 while they are disabled in
> 2.99.1.  Volunteers can run the 2.99.x series indefinitely to help
> LTS distributions.
> 
> At the release engineering level, I am very tempted to keep the
> WITH_BREAKING_CHANGES Makefile knob in the 3.0 release in order to
> keep the differences between 2.99.1 and 3.0 to an absolute minimum,
> and then remove the "dead code" that is used when
> WITH_BREAKING_CHANGES is not enabled from the 3.x series at our
> leisure.
> 
> So the above is what I have in mind, shaped mostly around the
> consensus at the Contributors' Summit (or at least how I understand
> what the consensus was), with my preference filling in what was not
> firmly decided in the room.


Back in January, on the cygwin-announce list[1], an experimental rust package
was announced. This package was marked experimental and unmaintained in the
cygwin setup program. I was hoping for a more 'official' package to emerge
before trying it out on git. (the package was version 1.91.0 of rust built
from a source tarball). However, there has been no sign of a formal supported
(test or production) package since then (there is still time, of course). ;)

Anyway, this thread prompted me to try the experimental package:

  $ vim config.mak # comment out NO_RUST
  $ cat config.mak
  DEFAULT_TEST_TARGET=prove
  GIT_PROVE_OPTS=--timer -j8
  #NO_RUST=1
  NO_DC_SHA1_SUBMODULE=NoThanks
  DEVELOPER=1
  $ 

Having fetched today, the 'master' branch @0f8e75abeb is v2.56.0-rc2 with
the branch 'en/no-amend-during-conflicts' reverted.
  
  $ make >out1 2>&1
  $ ./git version
  git version 2.56.0.rc2.1.g0f8e75abeb
  $ git describe
  v2.56.0-rc2-1-g0f8e75abeb
  $ diff out out1
  1c1
  < GIT_VERSION=2.56.0.rc2
  ---
  > GIT_VERSION=2.56.0.rc2.1.g0f8e75abeb
  277d276
  <     CC varint.o
  308a308
  >     CARGO target/release/libgitcore.a
  $ 

The 'out' file is yesterdays build of v2.56.0-rc2. (Similarly, the 'sp-out',
'sc' and 'hcout' files record output for v2.56.0-rc2).

  $ make sparse >sp-out1 2>&1
  $ diff sp-out sp-out1
  268d267
  <     SP varint.c
  $ 

  $ ./static-check.pl >sc1
  $ diff sc sc1
  $ 

  $ make -k hdr-check >hcout1 2>&1
  $ diff hcout hcout1
  $ 

  $ . ../git-test-setup
  $ env | grep TEST
  TEST_NO_MALLOC_CHECK=yes
  GIT_TEST_CHAIN_LINT=0
  $ make test >test-out-2-56-rc2-1 2>&1
  $ tail -n 13 test-out-2-56-rc2-1
  Test Summary Report
  -------------------
  unit-tests/bin/unit-tests.exe                    (Wstat: 256 (exited 1) Tests: 261 Failed: 1)
    Failed test:  254
    Non-zero exit status: 1
  t9904-url-parse.sh                               (Wstat: 256 (exited 1) Tests: 53 Failed: 4)
    Failed tests:  39, 42-43, 47
    Non-zero exit status: 1
  Files=1060, Tests=33592, 3519 wallclock secs (42.61 usr 141.30 sys + 9056.74 cusr 12680.95 csys = 21921.60 CPU)
  Result: FAIL
  make[1]: *** [Makefile:82: prove] Error 1
  make[1]: Leaving directory '/home/ramsay/git/t'
  make: *** [Makefile:3424: test] Error 2
  $

Despite the failure, this shows exactly the same failures as v2.56.0-rc2.

So, this doesn't stress the rust compiler very much, but I guess it is
slightly encouraging! I suppose Brian has plenty of rust code in a branch
somewhere that could be tested ...

Unfortunately, I am just about (in a few hours) to go into hospital for a
surgical procedure, so I will be AWOL for some time yet, ...

ATB,
Ramsay Jones

[1] https://sourceware.org/pipermail/cygwin-announce/2026-January/012823.html




