Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D95A1A0712
	for <git@vger.kernel.org>; Sun, 25 Jan 2026 17:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769360676; cv=none; b=j45C3obMtHoqK9UgsR0yOY4RgEaHsldttdTGwm+c+eMhvxe+mTIlR0pP+sJKU5Wr+SkuVUfkKPGET10L/XXGYDAAHKPfMj/w2Z76cRsgQm6btNolNy4fxcw9gX7y5cj3f2qYAl3CjVaRbw+iEWx+TV/C2upYJcEdcQKisMdddME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769360676; c=relaxed/simple;
	bh=5MNLC0V6yvw2A6/0GDhG8RGHjxscN8OleqiCRPEKAXM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=K4AWEEid8Xcn86+TJntKIXCrO0+YeRyWTf2WAf5Eb37fq9U5BaWSrW4+2HGFp7DAqsF/wlqCS6Vi+uajJdfkS9hsi8b15uhhEo1Ay9rd6LHXz/h3lxvu5/LWPBkSsqQl8yiw/wg2g0EjR7mZN/goOqijO19+fDFCbHYZo7VCkMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4dzdLd6xDRzRnlX;
	Sun, 25 Jan 2026 18:04:25 +0100 (CET)
Message-ID: <b379d47f-00c1-4d81-bfc7-d485699eab32@kdbg.org>
Date: Sun, 25 Jan 2026 18:04:25 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johannes Sixt <j6t@kdbg.org>
Subject: [GIT PULL] git-gui: more Bulgarian translation updates
To: Junio C Hamano <gitster@pobox.com>
Cc: Git Mailing List <git@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The following changes since commit 453fd8d14ce441896e0b39b85c67c9c26e34d46d:

  Merge branch 'master' of github.com:alshopov/git-gui (2026-01-24 09:25:29 +0100)

are available in the Git repository at:

  https://github.com/j6t/git-gui.git master

for you to fetch changes up to 1a729ccb930f3c3e206117aeb4f536c9864e09c9:

  git-gui: mark *.po files at any directory level as UTF-8 (2026-01-25 10:53:08 +0100)

----------------------------------------------------------------
Alexander Shopov (1):
      git-gui i18n: Update Bulgarian translation (558t)

Johannes Sixt (2):
      Merge branch 'master' of github.com:alshopov/git-gui
      git-gui: mark *.po files at any directory level as UTF-8

 .gitattributes    |   2 +-
 po/bg.po          |  90 ++++++------
 po/glossary/bg.po | 402 +++++++++++++++++++++++++++++++++++-------------------
 3 files changed, 306 insertions(+), 188 deletions(-)
