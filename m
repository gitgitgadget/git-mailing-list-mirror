Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6D32F5473
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 13:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760104561; cv=none; b=LhGmt+z0vzG8xHqoiNfI7mEjLMI11CSu8Lwwtyz32NtpTSvK+vsDKOgdJ7oKER5leqSqvADVrpSy9WGgkeCN16LmAlrKWkAKkWBMT4DJSf8/+lyuTk7hF801NDu5LQG8hpLjZoh9PtQbzcggd+IbIYShStEswdHzqkpxEfXE0N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760104561; c=relaxed/simple;
	bh=syylVcWxxSTKpaotBVr4b8/akboi4n94OvBFRdE4tsY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cQnBK5NYVmMHLgofuYQppT5vsEK5aPi42am/YSvVN/paa3u3SpuayUWGffH2Zn7U3tSi7a7Py81C5MX7Tu5AmahcLVsJP4KVNRRIOYAB+29+OjCcTk3T8yH6URfxEKzUTJjdJTbDl4tgKgfm9s11lmRIn8Vf68jJObV+Jq8A170=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=fscps0J6; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="fscps0J6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1760104557; x=1760709357;
	i=johannes.schindelin@gmx.de;
	bh=syylVcWxxSTKpaotBVr4b8/akboi4n94OvBFRdE4tsY=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=fscps0J6n3vJXSVH8HvNj+xXOJppotT6MH1fry9qJr1SGD0iXakQ3oO7yPiTtlri
	 XyhaWrYqjPZQ9tURgEu+SlIDCLW2XeskEHk37XXMnmG4U4XJUWaFt3rU3cSqi/CTl
	 RKAhClzUe+LF0P0qJZBJtTRZ3YX+egP1NQbrgA1L2U5nAP6CZBrVPjDVJdvYAQlJY
	 7H/2vZzZ0w3+v4sZYPxyIIejHUurOD13aEiAEVTjo8PFvEeCUN9ZtiDwSeohOWSLK
	 kkkyWC5kcmw292unUIsqN2pH7pr0MsE/i7NWw+xHTvUfx28mtawzy1GqAdv9ODQjk
	 MXNPkTFqEduH2/OUaA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.213.255]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWASY-1ujfMd1jv0-00Yyma; Fri, 10
 Oct 2025 15:55:57 +0200
Date: Fri, 10 Oct 2025 15:55:55 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH 0/2] Organize mingw includes
In-Reply-To: <aOjXjEJePkpCDoI3@pks.im>
Message-ID: <c4a03e23-1c14-05b7-25ad-a3d6998df876@gmx.de>
References: <pull.1985.git.1759995961.gitgitgadget@gmail.com> <aOjXjEJePkpCDoI3@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:o/ZDVXDPoJSA9Je8rrVvg9F6JLxIuLZbY9gV3kb1jzlbDT44pOA
 ADIduogXndlDrNJWE/uzFpC4T8cyGVIaqHlFmdvnynmUsBaeTES3JEALDu0G8ULl3xowWoE
 EZRriup7hfjBRqyiih3A+lGFmRY0TMt3Pu5Bo0ON5ilCoYZlPy9mMDgrUaulPh4batWBVfs
 uIa1aJMYbA02b5RXT1PDQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oQ1nFbLHBYg=;KCM8hyo+FLsx4jUrPj1+dWCNt4R
 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
 fy5MrBslY4Ub8oLAM5dGQxnJq3ohgj4iK94=
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Fri, 10 Oct 2025, Patrick Steinhardt wrote:

> On Thu, Oct 09, 2025 at 07:45:59AM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
> > Following in the footsteps of the many, many recent #include refactori=
ngs,
> > this patch series orders the #include statements in compat/mingw.c.
>=20
> Both of these patches look good to me and I like the improved
> consistency that they bring. I may also do the same for our code in
> "refs/", where some of the files use relative includes, as well. Might
> be worth to document this somewhere if it isn't already, but that
> doesn't have to be part of your patch series here.

There's already such a lot of documentation that I fear it is intimidating
to any new contributor (and if I was one, I'd be tempted to read it
exclusively via AI summaries). I don't want to add to that amount.

> Sorting them also makes sense. It's another thing where I wish that we
> had a tool to enforce this. clang-format supports this in theory, but
> it's disabled right now. And I'm not even sure whether it can be told to
> include e.g. "git-compat-util.h" first.

In theory, I am totally with you: Sorting `#include`s is a job best left
to tools. But then, I say the same about formatting, and I see a lot of
appetite on this list for preventing that to become a tool-driven job, and
instead requiring developer time to be spent on it. Therefore, I don't
want to spend any effort trying to get this automated when I see small
chances of success in the endeavor of freeing up cognitive cycles for
tasks I find more intellectually rewarding than figuring out where a space
or a line break goes.

Ciao,
Johannes
