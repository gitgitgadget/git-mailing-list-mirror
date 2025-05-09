Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E5E21CC60
	for <git@vger.kernel.org>; Fri,  9 May 2025 17:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746811770; cv=none; b=jOOX5hr+4CckX4bIHtcX6lVm/GAT42Dv19c0fJ+cNpCbr+UA7B2AQK9I5EIfpSHcPLMdMECeRhE5fB3NMmc5Iy2Uhl//hRXyY4YGDStaQjMFaDPVZa7lUz2GkDioZR5OOMZTsVLWMR38nuHty7HjO5YHWkPHCXhCDpoVrGirvu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746811770; c=relaxed/simple;
	bh=zr2zOpNJ99slYKzfmki5iDXzXOkV4/9jKkz5nCKi/Qg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=ZxjO3VVrK3jA5cM5YxJ9cxhZyOrx+k2MF05Dp0JkPNO4+jJLdJ4r/159VEvOTH03ZuztP+Rsz5NgiDXZjo62x9MYuSbuQUhGaN3HF+NKwb4xAzLVrBUbosHWpJmBvr9MI9f2qlycWaOR+nu11jcvmxfkMyZdSkn/0L8jXLyB6g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4ZvGFv59vgzRnlK;
	Fri,  9 May 2025 19:29:22 +0200 (CEST)
Message-ID: <113a6aef-7dd3-4a5c-8c0e-1acb9c0bd16e@kdbg.org>
Date: Fri, 9 May 2025 19:29:16 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
Subject: [GIT PULL] gitk: fix Cygwin infinite recursion, Tamil translation
To: Junio C Hamano <gitster@pobox.com>
Cc: Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The following changes since commit 4a6cc6a20eeb593f1ad0f60475a9867532d7c5d5:

  Merge branch 'pks-meson-support' of https://github.com/pks-t/gitk (2025-02-20 10:54:37 +0100)

are available in the Git repository at:

  https://github.com/j6t/gitk.git master

for you to fetch changes up to 3fdbf184be906b5f6abb35c02842ec8ad861e8f9:

  Merge branch 'at/translation-tamil' (2025-05-09 18:01:02 +0200)

----------------------------------------------------------------
Johannes Sixt (2):
      gitk: adjust indentation to match the style used in this script
      Merge branch 'at/translation-tamil'

Mark Levedahl (3):
      gitk: override $PATH search only on Windows
      gitk: _search_exe is no longer needed
      gitk: limit PATH search to bare executable names

தமிழ் நேரம் (1):
      gitk: add Tamil translation

 gitk           |  221 ++++-----
 po/meson.build |    1 +
 po/ta.po       | 1457 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 1553 insertions(+), 126 deletions(-)
 create mode 100644 po/ta.po
