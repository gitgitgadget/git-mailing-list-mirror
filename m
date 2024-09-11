Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D759D1BA276
	for <git@vger.kernel.org>; Wed, 11 Sep 2024 22:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726093143; cv=none; b=qGqJ4faZIby4oyvfl0fCBpv8Snup/t6qaEAd3CQWxoUSuzzv8B2JACR5QphX8VKaUDwCwjmVoYeWF0RUQDDfgOuYyheSgtDsxer690rOCYCwXmqMYRrEW/+AtdE8svZnKGCtOXme0dLyNXjOWb3EJZ6ZyGbeeuX3WuPTxcglt/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726093143; c=relaxed/simple;
	bh=fN2k+srg9mfDvxgbUGp6ZBvY/ZZwxNieHiirk28Aow0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=IZ0MxLwKUbqYEh3ifDgB27uF68mkJc1iBmSWTKfIRDgpHfvofaZrdPXgdwU2yzRrlRwTtUasqqoBZBl8eqN7N/v0qKfXeHj86+ykZwyAMSGRxsgsrCBX7P56QmjE1GXIbChQyPl2TmK6n/ZCud7yBcLQSUuWx2bAmpbz2BEnxcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=VldZt3XJ; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="VldZt3XJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1726093134; x=1726697934;
	i=johannes.schindelin@gmx.de;
	bh=RKfIzRaFfs5qbKAo38FRVp5slaNJ4BWEKNIHL0GZPuk=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=VldZt3XJF5aV2LkeONb7UYz30bm6w1kM75v3pPLZmW5Ryr23n9Uej/jXJ3RW/ViA
	 b5Lc2PD6AdDqZ1arWYgRbTkIndpVk+NclT8G5DPmoFy3Tt2nHiufAmSzztEDh+Xtq
	 sMxHAqDBUOpUfa9ZKkCb7lMfXosIIuOCWA5gr98QHTSj6a/SdFTCwZyyW5qSnFjpW
	 IbTUUzAYZKP8X22gKzmBNtQXQnOTElRdklGhTVBLHkd8fVIGMpI+JFdUWupHOR0cW
	 j70aCrLeNIPEc/rIgOPKAB3vZp7XNb08W0rE6IUYgYU6squuPcwqi0SFCi1EX32VC
	 CEL8aHSQxI0/jL6Sgg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.102]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFKGZ-1smbsF0fu5-004XFl; Thu, 12
 Sep 2024 00:18:54 +0200
Date: Thu, 12 Sep 2024 00:18:53 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
cc: Matt Burke <spraints@gmail.com>, Victoria Dye <vdye@github.com>, 
    =?UTF-8?Q?Matthias_A=C3=9Fhauer?= <mha1993@live.de>, 
    Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
    Todd Zullinger <tmz@pobox.com>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: Migration of git-scm.com to a static web site: ready for
 review/testing
In-Reply-To: <6f7d20b4-a725-0ef9-f6d3-ff2810da9e7a@gmx.de>
Message-ID: <155bc141-a16a-9fd2-920b-7a8c398d5e36@gmx.de>
References: <6f7d20b4-a725-0ef9-f6d3-ff2810da9e7a@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-241714924-1726093078=:19209"
Content-ID: <4af69c4e-149c-621f-a611-330cd90e8b60@gitforwindows.org>
X-Provags-ID: V03:K1:oC+fpzwCkFDvC3aBXm3FuEmz+yFj6fnjrnGTgYei5WGamu0f1MG
 zVooSu1QALr8TSj8yu91bJfq148OvIwsCk+QbGpvxmXsUjnNb4/deVLERa+BiV71wzX88z7
 YM76emkSQhdDujjkF2M8ZHom6tl7MAJ6oaIGNk3iaRK0VI3//5irZOr03ZrWGCoapvTMJzY
 hgx18hi3lgVfrHj05ioSQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XoRUPNPPLg4=;qD58stpO0enJghT+ndeqAaqw8dd
 cFmIr8DFt2D+hwE+jjO/CbDDXUxDvHXmxWtPw+450I7acWbQSunnk1nUgvwm8I43SIF12OQer
 VSw5NNVodfOrV8SCa6rgpoUHR6iwCA06oVWGQpHJ1SKk163Dif8sVNS+wUcfPPRrstCn8e6HG
 S6AXnBr/VgzrqypOwNYkknC3AHhYirdAxEx0Vzp6Ifo8xk8rw/gD/5tARMqH9r8WLc4mvnUC7
 hmz1s4TVX0PlFyUB0EvNL1z1qjxrg1OMeCEkoeyaJkil3aA2W3HwHjlnojvoduPeQVf4W6eed
 U7A5U0uDaqZ+K86zdhHMrfJRo7SMGq82iLbOcM/JvuF1xuKjAWztwXlSyRtlTWqu89WPMTKlf
 JbiHwpLKe2UPhrpJKrSKvXXSecOCHqsM9tNEyP74AxKeqLKNJKL+yLSHfSGtdKWrN7cCVQLSe
 Su35D2ulXVLL06NTW+3yvbbHdLccqpVxxtBFGVIpM0+UnvM/9m9xoRHtCeBt7/VqbbB54Szi1
 J829/myyX+HY0bbNPKlbG+agZjG4U12PZqKe845dljt0ssYZSvDMxWRcWrzZUUWhH1TnaY7F/
 xBAgPqtNrdaDjooT9vC4i5ZA3zXV4hbPyRikQSZO369AqYT0Plv1wS7Jrcpw1k5vXJtR0xaoE
 DeT92IQ8uaPHBYVehPti/oikMrt/Ru2DWeH2AelkDO27j9TtIz/YgSqWDo7GCNHNu9b8fqFLy
 jqVxjZjTndDdyFHCqwoORa8KelCOIPPSHf5NSTSABIsDP81gc4kax4Qmr1id0gM3mHasnG68b
 5KKt6wFD3oWaOML5N2aJvDGf1dtaf8a+UY5P5e0XvJHC6Ggmx5iB6EHRB6byWXCTwSlRrSJc9
 k/yoOTF7/rmN6Ig==

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-241714924-1726093078=:19209
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-ID: <8604d198-d330-1ab9-e7ba-5b82682ec3b2@gitforwindows.org>

Me again,

On Fri, 17 Nov 2023, Johannes Schindelin wrote:

> the idea of migrating https://git-scm.com/ from a Rails app to a static
> site has been discussed several times on this list in the past.
>
> Thanks to the heroic, multi-year efforts of Matt Burke, Victoria Dye and
> Matthias A=C3=9Fhauer, there is now a Pull Request, ready for review:
> https://github.com/git/git-scm.com/pull/1804
>
> This Pull Request is not for the faint of heart, mainly because of the
> sheer amount of generated pages that are committed to the repository (su=
ch
> as the book, the manual pages, etc, a design decision necessary to run
> this as a static website).
>
> These pages are generated by GitHub workflows that are intended to run o=
n
> a schedule, and the scripts that generate them are part of the Pull
> Request. For that reason, I do not consider it necessary to review those
> generated pages, those reviews have been done in the upstream sources fr=
om
> which the pages were generated.
>
> At this point, the patches are fairly robust and I am mainly hoping for
> help with verifying that the static site works as intended, that existin=
g
> links will continue to work with the new site (essentially, find obscure
> references to the existing website, then insert `git.github.io/` in the
> URL and verify that it works as intended).
>
> To that end, I deployed this branch to GitHub Pages so that anyone
> interested (hopefully many!) can have a look at
> https://git.github.io/git-scm.com/ and compare to the existing
> https://git-scm.com/.

It's time for the next update, after working with Pagefind, lychee and
Playwright project members to improve on this effort. Here is a focused
list of changes since November 17th 2023 (when I sent the first RFC), in
descending, quite subjective order of importance:

  - A couple of patches were upstreamed via
    https://github.com/git/git-scm.com/pull/1855

  - All other upstream changes were incorporated by rebasing the branch
    (keeping the merge commits as structuring elements). A couple of
    times. Okay, I won't lie, I must have rebased them about ten dozen
    times, even if I "only" force-pushed 22 times since my first update on
    this mailing list.

  - A rather huge change is that the pre-rendered HTML files are no longer
    stored directly in `content/`, but instead in `external/` (using Hugo
    mounts), and each and every pre-rendered file is marked clearly as
    such, to avoid accidental PRs that want to change those files.

  - Another important change is that the link checker Lychee is now used
    in CI builds to verify that there are no broken internal links (it
    does not try to follow external links, that would be too fragile and
    too expensive).

  - Yet another important change is that there are now UI tests (using
    Playwright) that verify e.g. that the current book section is marked
    as active in the Chapters drop-down.

  - The Playwright tests also pass successfully on the current Rails-backe=
d
    git-scm.com, with a few bugs of that Rails app clearly documented in
    the tests.

  - The `README.md` is now updated in logical steps, reflecting how the
    commit history builds up the Hugo site, then adds Pagefind, etc.

  - Upgraded to the newest Hugo and Pagefind versions.

  - I've re-done the way git-scm.com/docs works, it is no longer a
    complex `_index.html` file, and uses a much more powerful partial
    template now instead of awkward shortcodes.

  - The pages' sections are now determined more carefully (and correctly).

  - Since my last update, a couple of GUIs were added and others modified,
    therefore I scripted the migration from the single
    `resources/guis.yml` file to the separate `data/guis/*.yml` files, and
    documented it in the commit message.

  - The code using Pagefind was fixed (there were missing `await`s as well
    as racy search result order).

  - Translated manual pages are now searchable (when on a page in the
    corresponding language).

  - The `.html` file extension was dropped from the search results' URLs.

  - Book sections containing question marks are now handled correctly,
    with a fall-back when those question marks are incorrectly specified
    in the URL (which is then interpreted as separator of the path from
    the query part of the URL).

  - Missing files in the ProGit book or its translations no longer fail
    the deployment (and yes, there was one update that resulted in such
    missing files, and the speed with which this was fixed provided the
    motivation for this change of behavior).

  - The Hugo and Pagefind versions are no longer hard-coded in the
    workflows, but instead parsed out from `hugo.yml` (which is now the
    only location where these versions are specified).

  - Some Pagefind changes that accidentally slipped into earlier commits
    have been moved into their correct spots in the commit history.

  - The CI builds now verify that the search works as intended, by
    verifying that searching for a couple of subcommand names will find
    the respective manual pages as top result.

  - Commits that were created by automated GitHub workflows report in
    their commit message which workflow signs responsible for the update.

  - Obviously, the automation updated Git version, download URLs, manual
    pages and book (including translations) many times, as designed.

  - Workflows that can be triggered manually now really respect the
    `force-rebuild` flag.

  - The GitHub workflows were updated to use current GitHub Actions'
    versions (e.g. `actions/checkout@v4`).

I will try to reply to this mail with a range-diff that is slightly edited
to leave out the changes made by GitHub workflows (i.e. book and manual
pages). It is still over 100kB, therefore it might well bounce. Wish me
luck.

Ciao,
Johannes

--8323328-241714924-1726093078=:19209--
