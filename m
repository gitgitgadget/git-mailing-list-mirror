Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AD12E093A
	for <git@vger.kernel.org>; Sat, 21 Mar 2026 11:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774094048; cv=none; b=lBYu7sYIhXa8GIYFRkjou7yNXuldPmjWbSe7nUpRKCvCIKuwIoEQbRZ9RO5QD3ehlp95wv41yKecit7kmng3tkxgGNmQhX8Z7NOKDwkfgCe8pfWBFdWNBUCgbivpUvZcEJiFJMzth2p71Azw1rbhBAnKEW+xvDUS9pBVtd4MM8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774094048; c=relaxed/simple;
	bh=AahCjuTQ9I39tS54wFhqGgXh1avneIjpDSEMCBxclO4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=oUpYgEwdUJIskk87ZA31P8Gcu/XUT1BCkFiYbZ9VIJfr5TVQQjwXqhzngnHUj5hsSDMmaEt/P/YzyPA9BSTzbbfAP3HSQO2wSqCzi+NotFtQ9TpD0SUdbCMonUxTNTsXHcYmJoL0M9I29b1ikE0RyuB+aoRn7lN5bBxjTL/HlY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp3.bon.at (unknown [192.168.181.107])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4fdHpD5YmCz7QjcM
	for <git@vger.kernel.org>; Sat, 21 Mar 2026 12:51:32 +0100 (CET)
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4fdHp35RCzzRnlX;
	Sat, 21 Mar 2026 12:51:23 +0100 (CET)
Message-ID: <02518d2c-d1f1-40d4-8b14-ca27968ac87b@kdbg.org>
Date: Sat, 21 Mar 2026 12:51:23 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johannes Sixt <j6t@kdbg.org>
Subject: [GIT PULL] git-gui: grey comments, askyesno with meson, tabstop
 positions
To: Junio C Hamano <gitster@pobox.com>
Cc: Git Mailing List <git@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The following changes since commit 1a729ccb930f3c3e206117aeb4f536c9864e09c9:

  git-gui: mark *.po files at any directory level as UTF-8 (2026-01-25 10:53:08 +0100)

are available in the Git repository at:

  https://github.com/j6t/git-gui.git master

for you to fetch changes up to bb52cdac6254c006e06bf0bb820268dcf024fc22:

  git-gui: grey out comment lines in commit message (2026-03-04 08:04:37 +0100)

----------------------------------------------------------------
Chris Idema (1):
      git-gui: shift tabstops to account for the first column of patch text

Johannes Sixt (1):
      Merge branch 'pks-meson-fixes' of github.com:pks-gitlab/git-gui

Patrick Steinhardt (4):
      git-gui: fix use of GIT_CEILING_DIRECTORIES
      git-gui: prefer shell at "/bin/sh" with Meson
      git-gui: massage "git-gui--askyesno" with "generate-script.sh"
      git-gui: wire up "git-gui--askyesno" with Meson

Wolfgang Faust (1):
      git-gui: grey out comment lines in commit message

 .gitignore                                |  1 +
 GIT-VERSION-GEN                           | 16 ++++++++++++----
 Makefile                                  |  9 ++++++---
 git-gui--askyesno => git-gui--askyesno.sh |  0
 git-gui.sh                                | 18 ++++++++++++++++++
 lib/diff.tcl                              |  2 ++
 meson.build                               | 31 +++++++++++++++++--------------
 meson_options.txt                         |  2 ++
 8 files changed, 58 insertions(+), 21 deletions(-)
 rename git-gui--askyesno => git-gui--askyesno.sh (100%)
 create mode 100644 meson_options.txt
