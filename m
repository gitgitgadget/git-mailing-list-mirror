Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB2B2233B
	for <git@vger.kernel.org>; Sat,  9 Nov 2024 13:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731160268; cv=none; b=iewa9nJ+0hwvw9DpVENEtfK1ObpZhu+E+bQHYBTSJYRgga2O3IQ3S9GaRDxmyQpHq2yKvqkVwoU3Zy4AVZI4lt7w/E/0J3Fvhjg31yZHEGLy7DtJB3IUUTVEWHV3acchlzA2pRyF98BEJVEnko2FR6Buf+pSr6t10V7R21mFOwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731160268; c=relaxed/simple;
	bh=BiQP7yYmrE3qfkv+XUCSdktoq6SOGZeWYsnTa4oAV9I=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=qc/pH40d8Jbf7Q2ulmibntRynwonjUrQL4x4OSe9GbtblbckfWGmE9RjWbTJOhUuvlLGT4s0dWj8CImg4QFhITyX3lWbnFagPzQyObwkI6UvFgsXoWh39dac4PX79aZNy38z25fHDwk5HhNt2zYBnLzig1JFYaO11PuFiIQ1wxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.106] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4XlxzL6RYhzRnlK;
	Sat,  9 Nov 2024 14:50:53 +0100 (CET)
Message-ID: <91307087-2934-4037-b4c3-9691f8540c12@kdbg.org>
Date: Sat, 9 Nov 2024 14:50:53 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johannes Sixt <j6t@kdbg.org>
Subject: [GIT PULL] git-gui pull request
To: Junio C Hamano <gitster@pobox.com>
Cc: Git Mailing List <git@vger.kernel.org>, ToBoMi <tobias.boesch@miele.com>,
 Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The following changes since commit 2864e855932540c3ec6c9bf41ee3fe027d85f642:

  Merge branch 'os/catch-rename' (2024-07-07 14:14:59 +0200)

are available in the Git repository at:

  https://github.com/j6t/git-gui.git 

for you to fetch changes up to e5033898da23b6e2f6b77320bd0aa613595a50a1:

  Merge branch 'ob/strip-comments-on-commit' (2024-11-09 14:37:45 +0100)

----------------------------------------------------------------
Johannes Sixt (2):
      Merge branch 'tb/mergetool-from-config'
      Merge branch 'ob/strip-comments-on-commit'

Oswald Buddenhagen (2):
      git-gui: strip comments and consecutive empty lines from commit messages
      git-gui: strip commit messages less aggressively

Tobias Boesch (1):
      git gui: add directly calling merge tool from configuration

 lib/commit.tcl    | 11 ++++++++++-
 lib/mergetool.tcl | 21 +++++++++++++++++++--
 2 files changed, 29 insertions(+), 3 deletions(-)
