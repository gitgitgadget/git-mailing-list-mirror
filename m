Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109DC1420A8
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 08:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721810402; cv=none; b=O5TEzzAOJT3p6aqO2u/TCIkZm/LPykQoWs5R2oVBS8oTFlPFlyaU9N5mqbbuuds2W4GdE2MclAesiyTS+uDJxUed2wuV/URqCdK/EbIrOZQThDfzQyYd5FwMh9+u6Eeztc0rDWQlwF7xjAIefqsZLcSCllrw2EYMqb47So2/dNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721810402; c=relaxed/simple;
	bh=+R/yP3BH/N3bs6+akhrsUMggtltaMB2/YxQLu7em81I=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cS7JNoQlRnB0B7anjKzjYCwG0EK/D0YhpS9Jh2gpFMInr9LHbeI8Vp1LS4/IUGEZHM85dXhJB4qg8o/2+AZtRR5I4fyJXzSr2MnzawIEVFQHcCsJMm2csVaJHbby/a1IExhrIq/TOaIFbFBdFhOsakylJwcV51vDuAPYLZHbY5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=SHcmYrYn; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="SHcmYrYn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1721810394; x=1722415194;
	i=johannes.schindelin@gmx.de;
	bh=aRDTcg+KmHrkWmFDcHme7EspdDeFso4TZxOJVlJft2g=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=SHcmYrYnB0n9JXRQGvV3ICcovjtIp/WLpfx0fMoqjgs3p1pziCxoJ9iuutXlCGld
	 kg6EXa6ZujmWABzIA9+FTbummz0Rc/L7BPBrZ4z9EVFH4F4MIeUQE4MewAIFVlaqy
	 QvvJk2zDywhMUG58pjM1WQgSWVGsedyq4ky8hkiJktt89M4BkrIqAy2+RJeqXHSbD
	 W1ThgmqNfbGtvDFeuFe/0Cbl7eE+jojNSJ9XlztdEZ+20c2oCtPmtIrwaukJCt4EL
	 doxpRMhOGyP6bqw3Px7uXs3XI3C+AF2/X0FFKhtrZeW44izTxRYxBejfqygUmkwTP
	 JEhnQwqDHhg9MNuxDg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.218]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McH9Y-1s0UVS2maa-00m8GH; Wed, 24
 Jul 2024 10:39:54 +0200
Date: Wed, 24 Jul 2024 10:39:54 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: git@vger.kernel.org
Subject: Re: [PATCH 2/3] ci: update Perforce version to r23.2
In-Reply-To: <ee5d836b779087890acdad061ef6995642942479.1721740612.git.ps@pks.im>
Message-ID: <da9c4d1e-0fce-3bf3-c35b-32704a8a2129@gmx.de>
References: <cover.1721740612.git.ps@pks.im> <ee5d836b779087890acdad061ef6995642942479.1721740612.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:/wMdjmBHWQkdZt8+qSlo8b6TYcZK7LSQVoFz0N40CV4QgyP1rOo
 PqbWrBPmcDRqcDhMvRyblaQL7DDwVgeRMJIz86tW4/Jmj1Q/4Fa4pluP55snylIsuXgEov2
 UND964Z4spETlezn55UACHx7StFNcrb+vud1e/boMpcOLR9bLjdl49rs0BEtxGfDypHVEa6
 2EGIdJybVTxG7+S3O7RKw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NXD0v/5oe5o=;Wm8PTeVdfCbRUeWaKz8vZzuM1DG
 3Cm3nefYcHGf3L7P04NR+47Q9ZwxFWJLoM6Cyx+r9xwY2jDvJoUreFHc8TP/iTRWiayIXUTUf
 hn+14UvVLMAIJ9QVo6UcKHiieA9YMdBpbpF2ra7I6yd0JpAl8sQ02K0e4S1H6dhkhADf7UJub
 WU8+ZE9kyPQltfXVpmTC2FX7212fDELfKAfsOpy0wgbvAQ0k1w9wQWj96YH5HE/1RtaxL8Fsz
 u0H2CyKSmkRr6asAUDWUpMrtKsm30AnQfBFRBUmPShWIWq1igG6JOi4eMY03NOqSN5gKS6hmq
 BUOQMsBkmQd718BqkhWWlRVPxkxZ+1TM0DQPh+3dpA/sI47BqYNhZ9ZqCb+NJFj2aSORZxCYS
 tvjD7eJ4nz/MO9Gvc3YvbPCGGF+vDH6LifSQLJ5uLgpDJX3mGMkNrNH+xTUPe+/hQj1ZqgFWG
 5qnY6wUXrUl7D8iCBXhKx4T6FZk321e/7rIn8Z/0fa38K1OF15HxIk0wNXb7S+Ag/RoEeUl/a
 feF+7jE3Byba71rAucQO7OSZfKLJhDerGZdpoJKiZu1lqQv+t0ipk88EBhFJVpZbGfD1SKCc/
 456kCRSeL+4QetwceNdWNRcHfegi5k8gBQMWbRJelAOGES7nykLWk1iO7/FKv7c1EctNCRR/g
 /xEX5EFOK6pn5Ho1mgrl0VnnOauEr4uPzOs/3PCpIr+B903c79TtxF83QDhlb6xd0b+nUtoHC
 cFI2sZIySOTJJHnNT7qTJ7x6izZBgLGeJw9hn2hwLY0uLbNoTA10DorsPs8VwM3wiLygH6QVF
 5YRp/M19qJbcUhbbLhjBLJbQ==

Hi Patrick,

On Tue, 23 Jul 2024, Patrick Steinhardt wrote:

> Update our Perforce version from r21.2 to r23.2. Note that the updated
> version is not the newest version. Instead, it is the last version where
> the way that Perforce is being distributed remains the same as in r21.2.
> Newer releases stopped distributing p4 and p4d executablesas well as the
> macOS archives directly and would thus require more work.

An alternative would be to simply stop installing `p4` in CI. I would
actually be in favor of that, for multiple reasons:

- The pace of reviews and integration of `git-p4` patches has slowed down
  over the couple of years. For example,
  https://lore.kernel.org/git/20210510183638.156a6b1d@ado-tr/ has not seen
  any traction in over three years (most likely because we no longer have
  any active contributor with a vested interest in `git-p4`), and
  https://github.com/gitgitgadget/git/pull/1028 and
  https://github.com/gitgitgadget/git/pull/1070 have not even been
  submitted to the Git mailing list (most likely because of the hurdles to
  contribute).

- Over the years, it has been made harder and harder to install Perforce
  in CI. I spent a good deal of time trying to keep the Homebrew taps up
  to date (which was hard because Perforce kept replacing the archive
  behind that URL with newer versions, which always broke Homebrew's SHA
  check until it was adjusted accordingly).

- The `git-p4` tests use quite a bit of time and electricity in all those
  CI builds. Therefore, it seems desirable to me to stop running these
  tests as part of the CI builds.

Ciao,
Johannes
