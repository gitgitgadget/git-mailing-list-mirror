Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F18127E37
	for <git@vger.kernel.org>; Fri, 13 Sep 2024 18:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726251348; cv=none; b=b14AzE5C/tWvqMYhkxBjXw1PIWQ1OOaWyivv85lYSiPwIL9HMPGkwEY9QGBy+11VJt0p6qeLTKXKJkaOOTX2K8D0QQd/94GqcT5PsQ9AP0HrFbppZxSsEIVROa5xW47+47rK9CWladm2zLYWXQ5xXRanMSXsKGO/pThwS9xWUzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726251348; c=relaxed/simple;
	bh=U8gV48HAMw7NOcKX/GFW9mPG5fADdPdBLNoAKZ7szjI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ct61sCBUnXTygC4fI9hQQZWbq3TL0/FHi/xF4TTfcrUpARKyh6KusUZld8ENeHKDGegrIJGTQYMpfPr+UUjQjP4h8NNQTBc9JcxMys8JZyWDomQ/D55cF8Wk8dTedAYtg38/JeivBYy9JkpaOyPwU+9+la55clH6PLGlbaaEy2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=B9aRwaJq; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="B9aRwaJq"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 24A0620AF6;
	Fri, 13 Sep 2024 14:15:45 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=U8gV48HAMw7N
	OcKX/GFW9mPG5fADdPdBLNoAKZ7szjI=; b=B9aRwaJqgYW4KoLAx5C41++vNVPa
	DemwLWndBXn70xy6VNPDFE/YQR7TFEegDK8/lF5jcKAzrhEJkyLcNUuTTYjgcjRe
	UxCarMDPS74EIV4RzvxLUV4+uHJwiHO2u2LEqTM9k/MhMzFnKmbxJ6MUjzYab4WQ
	fHlcIW4mKv0ZltA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1C1C620AF3;
	Fri, 13 Sep 2024 14:15:45 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7A1F920AF0;
	Fri, 13 Sep 2024 14:15:44 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?=
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,
  =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH v4 0/3] doc: introducing synopsis para
In-Reply-To: <pull.1766.v4.git.1725573126.gitgitgadget@gmail.com>
 (=?utf-8?Q?=22Jean-No=C3=ABl?=
	Avila via GitGitGadget"'s message of "Thu, 05 Sep 2024 21:52:03
	+0000")
References: <pull.1766.v3.git.1723389612.gitgitgadget@gmail.com>
	<pull.1766.v4.git.1725573126.gitgitgadget@gmail.com>
Date: Fri, 13 Sep 2024 11:15:43 -0700
Message-ID: <xmqqo74rxvw0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 315566C2-71FC-11EF-8E3A-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

"Jean-No=C3=ABl Avila via GitGitGadget" <gitgitgadget@gmail.com> writes:

> In the continuation of the simplification of manpage editing, the synop=
sis
> processing that was developed for synopsis paragraph style is also appl=
ied
> to all inline backquoted texts.
>
> Refining the magic regexp took more time than expected, but this one sh=
ould
> really enhance writers'experience. I had to fight a bit more with
> asciidoctor, due to discrepancies between version 2.0 on my laptop and =
the
> 1.5.6 used by Github actions.
>
> The git-init and git-clone manpages are converted to this new system.

The fact that such a "magic" processing will hide the gory details
from those whose primary interest is to describe the commands and
their options cuts both ways.  While I can understand that purists
would find it ugly, as `backticks` is now much more than a mark-up
that means "this text is typeset in monospace", it is a very welcome
thing for developers around here, who just want to write their
document in a way even whose source is readable without having to
worry about suh gory details.  Maybe this gets popular enough after
other projects notice what you did to AsciiDoctor, love it, adopt
it, and eventually it feeds back to improve AsciiDoctor proper ;-).

So, unless there are objections and people want to discuss it further,
I'll mark the topic for 'next' soonish.

Thanks.
