Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF128258CCC
	for <git@vger.kernel.org>; Sat, 21 Mar 2026 11:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774093878; cv=none; b=noKoa9cxaAUF9fqRUAHVhaEAJ/+SdtTMfwurhzqRMHG1mgGB5bz9spM6fsFj4qPnf5toZ4gFBQw+d4shMUtbz0zfRYs7iLm8JqhdDkYarAYkF4OjK5vyioyMdOpfjzvipr6iJiNwnlxjU82HNNvTDyV8D0VYWykZs93w/glo7XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774093878; c=relaxed/simple;
	bh=6Axv9HC6XKDFePC9Iamc1rLLahOZN3XvrU2uPYOFBzo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=igkq8bM034COauwLkeyHJCNC0IcJAW+es+g81UsPPZmS3i25tr/bcFN/dLt/E5tjZojje537kAssfxJX2hZEYvrxcDH+bIP8007tWShwcVsZoiZ0/1+8q3pLkih8THT4gAA2X6b7v/TBiKGgEWOQzD2/54DZ0anvzqlnNeilMaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4fdHnl39WGzRnlK;
	Sat, 21 Mar 2026 12:51:06 +0100 (CET)
Message-ID: <5a6b375f-734d-4935-825a-afa41abc3ea0@kdbg.org>
Date: Sat, 21 Mar 2026 12:51:06 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johannes Sixt <j6t@kdbg.org>
Subject: [GIT PULL] gitk: *.po no-location and package name, link and ref
 colors
To: Junio C Hamano <gitster@pobox.com>
Cc: Git Mailing List <git@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The following changes since commit ddae547e3775638c238c11f30120f1e7e763fba8:

  Merge branch 'pks-meson-fix-missing-msgfmt' of https://github.com/pks-gitlab/gitk (2026-02-05 13:45:51 +0100)

are available in the Git repository at:

  https://github.com/j6t/gitk.git master

for you to fetch changes up to c8c5df79df34b40119c4bf8e3079520762f258d1:

  Merge branch 'jx/i18n-fix' of github.com:jiangxin/gitk (2026-03-20 09:23:32 +0100)

----------------------------------------------------------------
Jiang Xin (3):
      gitk: i18n: use "Gitk" as package name in POT file
      gitk: ignore generated POT file
      gitk: l10n: make PO headers identify the Gitk project

Johannes Sixt (4):
      gitk: commit translation files without file information
      Merge branch 'sb/heed-ref-decoration-settings'
      Merge branch 'js/i18n-no-location'
      Merge branch 'jx/i18n-fix' of github.com:jiangxin/gitk

Shannon Barber (1):
      gitk: use config settings for head/tag colors

Wang Zichong (1):
      gitk: support link color in the Preferences dialog

 .gitignore        |   1 +
 Makefile          |   7 +-
 gitk              |  21 ++-
 po/.gitattributes |   1 +
 po/bg.po          |   2 +-
 po/ca.po          | 312 +-----------------------------------------
 po/de.po          | 318 +------------------------------------------
 po/es.po          | 312 +-----------------------------------------
 po/fr.po          | 341 +++-------------------------------------------
 po/hu.po          | 312 +-----------------------------------------
 po/it.po          | 312 +-----------------------------------------
 po/ja.po          | 327 ++------------------------------------------
 po/pt_br.po       | 312 +-----------------------------------------
 po/pt_pt.po       | 316 +------------------------------------------
 po/ru.po          | 397 ++++++++----------------------------------------------
 po/sv.po          | 328 +-------------------------------------------
 po/ta.po          | 391 ++++-------------------------------------------------
 po/vi.po          | 312 +-----------------------------------------
 po/zh_cn.po       | 374 ++++++--------------------------------------------
 19 files changed, 187 insertions(+), 4509 deletions(-)
 create mode 100644 po/.gitattributes
