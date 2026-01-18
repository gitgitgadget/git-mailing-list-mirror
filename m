Received: from avasout-ptp-004.plus.net (avasout-ptp-004.plus.net [84.93.230.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECC828C2BF
	for <git@vger.kernel.org>; Sun, 18 Jan 2026 13:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768744771; cv=none; b=gCZ+jFMEzFYAuMDDEMlZ8jVERndpWNYAbFCKzSXTmK+ZvVxIPI3n/jdUAwq+MMpYQ112zD+F4VyVxgHEyR5mkWekbPWyQ/iTPIKZ4STTOjc6+m6syA5ZH98pGAf3MrZm4gREYl+z6Cs0UME6+A+RA6HoT+Ws/pAwMqbF2PUaIPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768744771; c=relaxed/simple;
	bh=j44xiHlkFzXbNYDEQBNFlPS7f6WP+jncWJ5BPDdz4sI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Qd0WdujnmAbqC0evK4XaHJkJwVbKd4M1+Npm/awRYrQ+4RQjEOmCcc7UuO63PvOP3mlEtX6W9J8gLbcmShB6hTgcLtfWR2f0x8LwVATdZz2x+n6BRDLEWEvVYjUNz55WmwjruNXJk+DD6kF3VI1hr3fPzGOJHlL/Nph6eYOnnW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=oMkHMxUh; arc=none smtp.client-ip=84.93.230.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="oMkHMxUh"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id hTJGvVpA8rZAchTJHvcJpz; Sun, 18 Jan 2026 13:59:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1768744760; bh=i1XAyfeZ9lawZtSP8nlXhmkq5fUIC40+ocDIqTSFOv8=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=oMkHMxUhDfUqjbnrw5wNjAwgHGr5m5anqxC8CkquDxwVwHqM11rQRjTWw2HUgEn41
	 pBniy9AQum69EFcdm/I2Sx4WhS1ZKH7gcB22AMDoaNZwcGYIGBY/DSLpY4x23sKCV5
	 Oj0LL5vXXfFDaLVfSUQ8eQ5GdutYmfVvwQedft47iIf/el0IW0Q9izH4DKYJ9Khdgb
	 DCNZoKibwzgBvfvGCaVrjDBG8f9SzpWpttN5jvOEGPkWvDoT03R51uez8hdwit8XZw
	 HuB6Pw1o8E04JLDP5Yjipz4JwXfcAbAgCHbzO8BYmONCFvROvxxDWaxz0VgSzW3iX0
	 rQXxQ+wTXr6QQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=bqnvB1ai c=1 sm=1 tr=0 ts=696ce738
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=ts3SAFlqq7JghuwZjJ4A:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <a19baa0c-e084-44c4-bd77-a6c18626a6f4@ramsayjones.plus.com>
Date: Sun, 18 Jan 2026 13:59:17 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Subject: [PATCH 0/2] v2.53.0-rc0 test failures on cygwin
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
References: <3f8925eb-7602-433c-83e0-a88cf8d155fa@ramsayjones.plus.com>
Content-Language: en-US
In-Reply-To: <3f8925eb-7602-433c-83e0-a88cf8d155fa@ramsayjones.plus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfGGgUgBhVVcZ4V9GW39rIOT8OQV5PNYQZ0z9jfFY7jleadJLhTZwtQRhwgl41MWNpSKiXxv2+TFLmM7aHHLfnTnvt11nSZBOOMP4oXUksie7OoqQ34VP
 MPYtH/DpmBxh2W1fRquMPBJ4+tGUqwFhW8IUJzvu7Dfl/pXB/lCmJUcEXbZ1rxrSYDkL7jl8v2ksXbEbHDJEKYgihAOLmKvk0pY=



On 16/01/2026 8:39 pm, Ramsay Jones wrote:
> 
> 
> This cycle brings a t9700 test failure on cygwin, see patch #1.
> The second patch was owed from the last cycle, sorry about not
> getting to it sooner, but it is _still_ a puzzle. ;)
> 
> I have tested these patches on Linux without issue. On cygwin
> the t0610 test passes with '--stress' which it failed earlier
> and the t9700 test has only been tested by hand.
> 
> Directly after sending these patches, I will start a '-j8' run
> of the full testsuite on cygwin and let you know if it fails
> (it should not!). ;)

Just for avoidance of doubt, this test passed without issue:

  $ ./git version
  git version 2.53.0.rc0.2.gc56c9e3a41
  $ 

[ie. v2.53.0-rc0 + these two patches]

  $ tail test-out1
  All tests successful.
  Files=1028, Tests=32260, 2945 wallclock secs (22.75 usr 64.42 sys + 7655.90 cusr 10222.07 csys = 17965.14 CPU)
  Result: PASS
  make clean-except-prove-cache
  make[2]: Entering directory '/home/ramsay/git/t'
  rm -f -r 'chainlinttmp'
  rm -f -r 'trash directory'.*
  rm -f -r valgrind/bin
  make[2]: Leaving directory '/home/ramsay/git/t'
  make[1]: Leaving directory '/home/ramsay/git/t'
  $ 

> [When I run the testsuite like this on cygwin I can't use the
> laptop for anything else and the keyboard gets _very_ toasty!]

Now I can try a lower '-j' value to find a happy medium (although
no '-j' argument leads to approx. 4 hours for a test run, which is
already better than 6+ hours for my old laptop).

Thanks.

ATB,
Ramsay Jones


