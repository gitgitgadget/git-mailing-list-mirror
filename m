Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE6D343D64
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 09:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784195393; cv=none; b=PeLRGM+6Xou5vkcPRiX+hebJuniBulRyxbl6FhvNk5abBZvSdTTvHVEmhfoBa21151JGp5nxBhNjs4YsErfdLFLZkIekBamqsTXmjOUZPvwi4nTx78m+BApBM74R3Sm07kzEO3XMtpyMVWTZVdnvGlfA1ufo/TTXgRB7hGaiuM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784195393; c=relaxed/simple;
	bh=rgd/6ryxPwLdIdxZ0Ts90haksn6Ws3Uq0c4cLFc/GT8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=Wxeh1yVHmPFwfG0w7G1764aZkClIcK6dqVJbPIvp4/kNVG8e8crLZS3HWioo9lHZG7APlAcjnPA8PwocKtbDHM64owKHeqTbNFSC4QPw4EiniAP6fAN5IR6mjHsp08RHcZ49EY77gv52kFepZvydoBQUoXrX9K4EL3LTGkK7idQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp3.bon.at (unknown [192.168.181.107])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4h16Rx1f9bz7R1pS
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 10:59:41 +0200 (CEST)
Received: from [192.168.1.102] (213-147-165-249.nat.highway.webapn.at [213.147.165.249])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4h16Rl3rD7zRq26;
	Thu, 16 Jul 2026 10:59:31 +0200 (CEST)
Message-ID: <fdef432d-0b84-4b58-9915-83eb4d7dae87@kdbg.org>
Date: Thu, 16 Jul 2026 10:59:30 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johannes Sixt <j6t@kdbg.org>
Subject: [GIT PULL] gitk: Bulgarian+Spanish translations, silent make -s
To: Junio C Hamano <gitster@pobox.com>
Cc: Git Mailing List <git@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The following changes since commit bad83ada0ebf9e293d570e6e7ca4f1cd7877f482:

  Merge branch 'horizontal-scroll' of github.com:ramcdona/gitk (2026-06-12 11:30:22 +0200)

are available in the Git repository at:

  https://github.com/j6t/gitk.git master

for you to fetch changes up to f1de86371cb85dd09d55070d139e5fcdc595f026:

  Merge branch 'spanish_pr_bis' of github.com:basuradeluis/gitkbis (2026-07-16 10:53:01 +0200)

----------------------------------------------------------------
Alexander Shopov (1):
      gitk i18n: Update Bulgarian translation (329t)

Harald Nordgren (1):
      gitk: make "make -s" silent

Johannes Sixt (2):
      Merge branch 'master' of github.com:alshopov/gitk
      Merge branch 'spanish_pr_bis' of github.com:basuradeluis/gitkbis

basuradeluis (1):
      gitk: spanish translations

 Makefile |   6 +-
 po/bg.po |  45 ++++--
 po/es.po | 488 +++++++++++++++++++++++++++++++++++++--------------------------
 3 files changed, 321 insertions(+), 218 deletions(-)
