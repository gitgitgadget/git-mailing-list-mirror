Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B37442A8F
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 22:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727215638; cv=none; b=emTrLquEtQ8JI2d5Nf7stQkai92udB5DJr8XS+BmSlThLWNa/aKxu9dcGdFvU8KaTigcGC52/pWCB3Szo5IxSCLko6XmT0xbwf3baf8y+9KJPyxHLGYdoH06S20XNlCjnoOdCm2MQvP2Fat4Z9t5fbfXjBeU9G85mxO70nPCD4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727215638; c=relaxed/simple;
	bh=WSJHWu1GliN5MpaCz7fUPjxPRcU93TUMeGZb+D/zad8=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=mT2IzaIeRp0e8Pp7CbCIWWJf50jJdMysN0nxyXX28UkV+D5SVVirnNU7777ZVyr9mB3sgkT6hHXIjxUkqjli8ZNWMVcT8aTuvs3w00oPHu50s42evM5RMm21srHoSX1aIydNuFwFAPKFC6u5nFe5sR+oop5SQ7U8/FJebljlPrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=NfDsFphC; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="NfDsFphC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1727215627; x=1727820427;
	i=johannes.schindelin@gmx.de;
	bh=QXNK3a7F9mwMDBE0bAozd4nTQD5yeBmsuXgZ/KWLGKU=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:Message-ID:
	 MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=NfDsFphCndpwGCayRBpporkrW+9P/hUVSEw3PWG9NmvAik3Ga6Xx7UfbKHfR4bx4
	 xd74HN90/ygtMpEo9uqC9UKNS2zPK3b8LHE1kBMJshfWcUXUejExm31eP8McAn5kB
	 AFng9ZXk+mkakhFp1m3pzyP/+EFgCoA6xJiv7tLqr1NqgVhMJaSMmNRAMkIn6ROGO
	 LGMbZVjhu5yfntVelm8m8h2i5XBtoENhJAfDH0ScViCppP/TGi55N7VJouhAcnins
	 bhCJWtqHj4o0PqKxE2DqPKrhIx7om5+awqXyML1P8oaaVwh/MC98Fat1j1U+DZ6aR
	 E0MFP2yk55E/EXaQMA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.169]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQvD5-1sXYVR3xtn-00Ixc9; Wed, 25
 Sep 2024 00:07:07 +0200
Date: Wed, 25 Sep 2024 00:07:05 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
cc: Matt Burke <spraints@gmail.com>, Victoria Dye <vdye@github.com>, 
    =?UTF-8?Q?Matthias_A=C3=9Fhauer?= <mha1993@live.de>, 
    Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
    Todd Zullinger <tmz@pobox.com>, Johannes Sixt <j6t@kdbg.org>, 
    =?UTF-8?Q?Matthias_A=C3=9Fhauer?= <mha1993@live.de>, 
    Toon Claes <toon@iotcl.com>, Taylor Blau <me@ttaylorr.com>
Subject: git-scm.com is now a static website
Message-ID: <c3e372f6-3035-9e6b-f464-f1feceacaa4b@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-162024908-1727215049=:116"
Content-ID: <1cda2165-f94b-2233-0e05-a50536dba3a1@gitforwindows.org>
X-Provags-ID: V03:K1:i6uTOLvb453JEnwHtTtc5TfdcpHOdFQFwiKXZJv8/EEBzQyqxOJ
 MvgfGZcokPUO3GHSJ9hl0kRaVYbj8lSXObojLNoqk1AK5fl+D0j8W7SkZvJZKVmIMbfHKfo
 ueLUdmL8ZeS4FiZZH1r6oqRqRfKuY7ax3Yfujq+CJ1Qg98kmMQzoh2XFcVipgEBowXQKwhz
 qqzQ8v+6epquz/Xvb9H1A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0vYxfq5dqPM=;ZdSpC4O2Y/ej9Amh/uYwfaaHWCq
 1+/pZOhCmJB+U3M83YLjLhnHFs1ef0Ty92Zp1TQVle6aqampmMuSd+goY9qKeAHqE1Q6bICfD
 qvuuOzyCCafbLVBBB1/ZRy2gJZZSRkgkF4g3s5e652B7rBybHBeaSnl0JJPUzfuW6pBwzz1I9
 er68qX9YRHqqNECIZPfgBUsJJKy6axO2zcPsj9PKiVp0kAejuVGYTRQhE+xO6uegC15Oifpwh
 2tl7MmvG2yaTMXzDIbMeLKtibqE6XFFZTVgqPPYAXkqMuG2o0ZtuHWulMOI6kdIT2h7kLuTK1
 kndlCDplUKxgAthobSOz7nQv0CqCken2KMwrxcTEI2nwfVNNZSeJNkno2mCkk4lwMCvohVLFX
 pDOEapwudws95n/tn9VEdr21xmVeAQwPACZDgCe/AY8ppAIZr1yPwCG8mu3yaBYE22V/Ll1dJ
 X7jYmB/Ta1M4NC3z1aBa8gpEUTWrCpuwxgxw+RvJfNMqIPqULUlUZ7x194MNeRTjo5J3nbeuD
 DwUi/dAUHc4MpnOxcCNBVsRjp5A2kfxTSBFR3ehE11TCb8NFQMyqfnVGU2ssENjFZcss8cd2l
 sQwge2v50t9MSjFhaZnf+D/N3rfeuxt/0Y8DDIFF318ej5kgxPFIfkO0OV0cZ2XYmtuLVfmXI
 prJ7QNwJ740L3niGfPenRZ2AEy+Ebg8pnfYdQwiPxeSgeQNZJ4o1cEEhAu7FeRUi+yxO3rD7m
 8uPaSlNjkppk1OCXYAErjI+78eNljdviE43ocBOWSXZ0Sf5ogOIgcITp4U+YEtdasbSx4k0SR
 8zLGZIaKvlDugcuqKsdYtYweb16/7veECb2d0vsum6FY/mZE9FT/cd4AGr+dpo/2rGky5bKM1
 mWzwvG9g4zbjflw==

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-162024908-1727215049=:116
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-ID: <cf0792cd-d53e-7820-2635-ec8ed67d50f2@gitforwindows.org>

Hi all,

almost 400 weeks after Matt Burke started the process with
https://github.com/spraints/git-scm.com/commit/60af4ed3bc60 of migrating
Git's home page away from being a Rails app to being a static website that
is hosted on GitHub pages instead, today marks the day when Git's home
page at https://git-scm.com/ has finally moved. Or actually: yesterday
(because I took so long writing this email that I ended up sending it
after midnight).

This was truly a team effort, and I would like to celebrate everyone who
contributed:

- Jeff King for nerdsniping Matt Burke to look into migrating the site to
  Jekyll,

- Matt Burke for the first spike that identified what would be easy and
  what would be tricky in said migration,

- Victoria Dye for working with me during the first hackathon and figuring
  out all the hard parts such as sorting and filtering the GUIs at
  https://git-scm.com/downloads/guis,

- Bj=C3=B8rn Erik Pedersen for his tireless work on Hugo, a static site
  generator that is fast enough to handle the amount of content on Git's
  home page within a reasonable amount of time (unlike Jekyll, sadly),

- Andrei Rybak, Pedro Rijo, Kaartic Sivaraam and Todd Zullinger for
  testing the site when it was still rough around its edges,

- Oswald Buddenhagen for pointing out that the auto-generated content
  needs to be tracked separately from the non-generated content,

- Todd Zullinger for suggesting to use an automated link checker,

- Matthias A=C3=9Fhauer for reviewing (part of) that humongous 242-commits
  strong PR at https://github.com/git/git-scm.com/pull/1804,

- Liam Bigelow for writing the only client-side Javascript-backed search
  engine (called Pagefind) capable of dealing with the size of
  git-scm.com, and particularly for his patience and for his competent &
  kind assistance when I tried to adapt Pagefind to the needs of Git's
  home page, so that searching for Git's subcommands will find the
  corresponding manual pages first,

- Matthias Endler and Thomas Zahner for their extensive work on the link
  checker Lychee, including their outstanding help with my PR to support
  the extension-less URLs we want to see on git-scm.com,

- Toon Claes for not only pointing out that the style sheet for the search
  results needs fixing but also for fixing it right away,

- Taylor Blau and Jeff King for endorsing the work enthusiastically and
  suggesting to switch over already at the end of the Git Contributor
  Summit that took place at GitMerge '24.

- Taylor Blau for assisting in the switch, taking care of the DNS
  adjustments, and in particular for taking care of the rollback when the
  first attempt at switching failed (due to caching issues) allowing me to
  catch my train.

You will note that the site looks pretty similar to the version before,
and this is of course intentional.

There are subtle differences, though. For example, the site search is now
language-dependent. Searching for "commit" when on a Spanish version of a
manual page will find only matching Spanish pages:

https://git-scm.com/search/results?search=3Dcommit&language=3Des

As with all big efforts, I am under no illusion about everything working
as intended, I do expect some fall-out to crop up (e.g. external links
that might now be broken, even if I tried very hard to avoid that). I hope
that the team spirit I described above invites more helping hands in
getting those issues found and sorted out.

There are also new things that have sprung up that are not caused by the
migration to Hugo/Pagefind, for example some diagrams no longer shown (see
https://github.com/git/git-scm.com/issues/1862) because the Google Charts
API entered the Google Graveyard. Any takers?

Ciao,
Johannes

--8323328-162024908-1727215049=:116--
