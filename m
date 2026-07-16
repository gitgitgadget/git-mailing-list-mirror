Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C93A3F074A
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 09:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784193227; cv=none; b=lhyGmyyFkcR210a6VTCoBLoMOLEiWCAMgsTOVp2NDbI0Z+tpxOQ0/n3N+uTBfruhSE5n0nx2kY4+eXtjU1JWu3q3xLpeWZXZjR2632MxcBCt3dlUlvptaVdMQ/xPXqNAq2Jn37Gv3xDOupVl9I2c1kfHMDqnO9gV/VjLgnRd23k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784193227; c=relaxed/simple;
	bh=B0W8R1RX40Br7qWovquWNYphcUOwMBVwC3RT4GBlO5I=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=s8Eo9EDVcFG5S/CEuqddBIHJFabzn4NX8wB+2wsYJi63l6LRWx+ojV/llE4sYn/TW/pQvf92swYzgWz6HOGjxVO/YLwwpqVe1qRWrrRQCRYi/pStqEdtdUrEIlnBWlzT9HYm291JJWo0p+2VupCsDbJhY5eQT456gybeMENYoss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp1.bon.at (unknown [192.168.181.104])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4h16m36X6Xz7R5Mk
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 11:13:39 +0200 (CEST)
Received: from [192.168.1.102] (213-147-165-249.nat.highway.webapn.at [213.147.165.249])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4h16lt6SC5zRpWV;
	Thu, 16 Jul 2026 11:13:30 +0200 (CEST)
Message-ID: <c177a717-28c3-41f7-95d7-45fec5b304bb@kdbg.org>
Date: Thu, 16 Jul 2026 11:13:30 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johannes Sixt <j6t@kdbg.org>
Subject: [GIT PULL] git-gui: larger commit msg field, Bulgarian translation,
 silent make -s
To: Junio C Hamano <gitster@pobox.com>
Cc: Git Mailing List <git@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The following changes since commit 1b2c2a2edbaa1638becef4c3755b3e0633b9c304:

  Merge branch 'ml/repo-discovery' (2026-06-12 11:05:28 +0200)

are available in the Git repository at:

  https://github.com/j6t/git-gui.git master

for you to fetch changes up to 5dcb97869546d600a114ef422a135e2e909c923c:

  Merge branch 'master' of github.com:alshopov/git-gui (2026-07-16 11:05:03 +0200)

----------------------------------------------------------------
Alexander Shopov (2):
      git-gui i18n: Update Bulgarian translation (562t)
      git-gui: allow larger width for the commit message field

Harald Nordgren (1):
      git-gui: drop msgfmt --statistics output

Johannes Sixt (4):
      Merge branch 'master' of github.com:alshopov/git-gui
      git-gui: reduce complexity of the quiet msgfmt rule
      Merge branch 'hn/silence-make-s'
      Merge branch 'master' of github.com:alshopov/git-gui

 Makefile       |  5 ++---
 lib/option.tcl |  2 +-
 po/bg.po       | 37 ++++++++++++++++++++++++++-----------
 3 files changed, 29 insertions(+), 15 deletions(-)
