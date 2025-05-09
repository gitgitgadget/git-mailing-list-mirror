Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA76238172
	for <git@vger.kernel.org>; Fri,  9 May 2025 17:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746811531; cv=none; b=CowgGr8Cb585qE0C9z5sNQNNcHImU8WyiPUW822Ig+WQehyCAKHYBYvlk6eHyrOiMqssJ446yQ8Iy5VCa56aTDIO/hnN/AgB/P5/iRM7IMARgDYlw4Yj9R01oizZUS8LhGmxFBhbSawlP8r7sY23EFeJjK2OihOO3SCkxJXTFoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746811531; c=relaxed/simple;
	bh=f0PqF86EW0eRr450kfP2w0NPqSq/3OcvCCSsoUZxtHs=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=E1oqOdkV+F4y1g2Ghek65NoQOX1W8TyaYYFSw7ztNC3lkjRXutpuO2fQbiX2fRbdVmsEataj5sCwk+zRyF/0bkCQU/rAuFNo4JgWCOVRZcwO/Ohz6EypT9lfvPbZZFP8QWUXHOEHnyrgz9oaTpgQvTf8u+tMveL3AhBgYIG+Hac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp3.bon.at (unknown [192.168.181.108])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4ZvG9F68KWz7Qgqw
	for <git@vger.kernel.org>; Fri,  9 May 2025 19:25:21 +0200 (CEST)
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4ZvG9340MvzRnlK;
	Fri,  9 May 2025 19:25:10 +0200 (CEST)
Message-ID: <69db24c0-40b3-44e0-b225-4df2c357106a@kdbg.org>
Date: Fri, 9 May 2025 19:25:00 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Git Mailing List <git@vger.kernel.org>
Subject: [GIT PULL] git-gui: heed core.commentChar, ephemeral git-gui.pot
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The following changes since commit ae6336b6173bf5303fad53e0a52a16f92c47b6b7:

  Merge branch 'as/translations-bg' (2025-01-05 10:44:35 +0100)

are available in the Git repository at:

  https://github.com/j6t/git-gui.git master

for you to fetch changes up to 309bb874dcba2c96f8b12d20bed16cf6a1ea0133:

  Merge branch 'js/po-update-workflow' (2025-05-09 19:17:19 +0200)

----------------------------------------------------------------
Johannes Sixt (4):
      git-gui: po/README: update repository location and maintainer
      Merge branch 'ob/strip-comments-on-commit'
      git-gui: treat the message template file as a built file
      Merge branch 'js/po-update-workflow'

Oswald Buddenhagen (1):
      git-gui: heed core.commentChar/commentString

 Makefile       |    2 +-
 git-gui.sh     |    8 +
 lib/commit.tcl |    4 +-
 po/.gitignore  |    1 +
 po/README      |   74 +-
 po/git-gui.pot | 2666 --------------------------------------------------------
 6 files changed, 23 insertions(+), 2732 deletions(-)
 delete mode 100644 po/git-gui.pot
