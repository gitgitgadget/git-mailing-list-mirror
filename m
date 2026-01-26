Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB28D33CEB5
	for <git@vger.kernel.org>; Mon, 26 Jan 2026 15:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769440880; cv=none; b=APFMkKKsedddGYgRtWsJ7llKzKJnEkc5qT+u5inqaqB5V10mSGEbg0KZjIRFcuTBaMnuXtItST3Mai48p0PG85asJy68gd+/hc78qMqUITw0fJGFyVkOhnUNRRffxOhMl1XAdsOOPhGxq7ESbY45E02XBs/oruyo3D5I3xoUzoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769440880; c=relaxed/simple;
	bh=S7wgVEHE8894W9LkhVhDZ7ZALTdAsvxXRgQuPZcvnOI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gkHWzihz+3TEC9iZUTkxg6oC64ebP1Qvg+06XSQ+Rf3UyYQ0qCxESOrWEt11PBfYnimLPfMgMRJJLzvHNPjgFIlKp46P+fUS6AhlHXUVIgvrfnhMNzqPrxKLe/1XGRvBJjL7JXpfZZkAXVbd/qOhYWCV4gNih8Rjr53HrI6eZ3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=SwisUIpf; arc=none smtp.client-ip=79.135.106.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="SwisUIpf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1769440871; x=1769700071;
	bh=lvyjFaNuPBHnqf2uoaUoWv3miSpn9u9M5vV5aDlZpw4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=SwisUIpfvaiz6QYKBkD8gQo77gHqcwcYZLONgWT4E2q3s6LqUJNOAq6736swIOzEU
	 2qg7TjFqSRDkXonjURboyUs7k+P0a9HyiFnDFE/Ho/1gyhpukn6QVu6dEB57XhRypa
	 XEbAmgF0pTFadjGsPdSJuaFHLdDUV7QttC9BZJtq8BZfOMVWq1KU7JyCiBrpiLfn/Z
	 x4ipnZPZK+OXBITwBX0HonAAgY3aYljyowy6JYCb1TeWvq+C7pgV+Fa+qLcFpFB7Qo
	 CaY1AusLzjYsDO2e7HinaRZaa+zcU7XnemPZxnklTA+6Bqz3UD/Op1Z8ONXH6gvzgk
	 EhjTFl5ix7JRQ==
Date: Mon, 26 Jan 2026 15:21:06 +0000
To: Johannes Sixt <j6t@kdbg.org>
From: GitHub Chris Idema <github_chris_idema@proton.me>
Cc: git@vger.kernel.org, Chris Idema via GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [PATCH] diff.tcl: fixed alignment of tabs in git-gui diff by using spaces
Message-ID: <cN1fnsEmJFcm0Tn-hnMbo4tx4U4_SXBxO1s7j0NjOOv2Fn-sH0IsQTX2QqxD7g1bt_7aOSjXNEIBoLAMJT25UZLwr-Uzh9jFC_vBZ9QlLy8=@proton.me>
In-Reply-To: <5ab10a31-8ee5-48f9-a5fd-63c6d7f4adcf@kdbg.org>
References: <pull.2179.git.git.1769424301394.gitgitgadget@gmail.com> <01d0faaf-99fb-42a4-befd-bb7f359809bc@kdbg.org> <Lj9kojJwK1ZAtvE5nj6rTq5EXf1-QhsRlmBDM9YntbYeWb3J07mlbM-njNco2XT1pSPXsNVbo9Uc5kJOHihb11odjthYN4YtuhVdNwxSIqk=@proton.me> <07014d88-67ed-498a-8cc1-423c77972fd7@kdbg.org> <sYbEiapPid30QZ89paQ6hF_v4BjKnAqUTOt_ImBEfFYBlMVU9uoGwZbKqSkk7aZVxGPrqVXbb58Ogppnw0gQEbH1gwRfBmx3HC2AECWjGkY=@proton.me> <5ab10a31-8ee5-48f9-a5fd-63c6d7f4adcf@kdbg.org>
Feedback-ID: 177675452:user:proton
X-Pm-Message-ID: eb6e168f57660777c2350f7c3f3199dd7efba24e
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> I am not particularly fond of such a change. Years and years of reading
patch text has trained my brain to expect such misalignment to the
extent that even the absence of misalignment can sometimes indicate a
whitespace error.

The problem is not just incorrect alignment. It's also inconsistency. In gi=
tk the alignment is correct. In the git gui window it's not.  The best solu=
tion would be to make the git gui window behave like gitk. I thought my cha=
nge only affected the way it was displayed. I'm going to see if there is a =
better way.

-- Chris

-------- Original Message --------
On Monday, 01/26/26 at 15:52 Johannes Sixt <j6t@kdbg.org> wrote:
Am 26.01.26 um 15:43 schrieb GitHub Chris Idema:
>> So, you mean that if the tab width is set to 4, then the tab stops
>> are not aligned anymore?
>
> Indeed. It's probably due to the + character shifting everything by 1 cha=
racter.

BTW, this isn't a problem with a particular tab width. It happens with
the default width 8 as well.

>> My suspicion is that the patch text does not match the actual file
>> contents, and so the commands fail.
>
> If you select and copy the text from the window with you mouse it
> won't match the patch. I didn't know people used it that way. I use
> it as a way to review my changes before staging.

I don't mean copy-and-paste. I mean the context menu commands. They stop
working (I suspect). This would be a show-stopper.

> I don't know if there is a way to make it that when you copy it will
> copy the original text and no the modified text. If not then we
> should come up with a better way to align stops.

I am not particularly fond of such a change. Years and years of reading
patch text has trained my brain to expect such misalignment to the
extent that even the absence of misalignment can sometimes indicate a
whitespace error.

-- Hannes


