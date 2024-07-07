Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6421E532
	for <git@vger.kernel.org>; Sun,  7 Jul 2024 13:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720360385; cv=none; b=fm8xVdVBsmlRPmtGQurdEUAjl8iiuqI4SLRYc/xFKkSuTb30oK4YyDnZ0spq5DwSYbQg5D/8DzTjZ0fUxuGmHNDd6+29/n6mtMHKLG1bnsI3Dze8eQicLyJ3K8ghcGmRYesfaSpTZfZ0hVpPA2g7cpZz2jCmqM+gGzRIj4hwJmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720360385; c=relaxed/simple;
	bh=0kyeSJPMIISxA14MkRCSoNJThVriUN9hSP93BPRjT8Q=;
	h=Message-ID:Date:MIME-Version:To:From:Cc:Subject:Content-Type; b=B37c6iwKAUOhV4ElJG/8wVO3HKKOkQeNUTF3ATwNmLtdVDJhU2BCkxDJxS67VhcBa7XN/EJdg5WMPD83OeHXRciPwn9jRhAOxZ2s7R00WUJlT4WxhsxaB46DtextifO0XRKvlBgSrnn/u/Vo/BNl0k7sacWJgWcr48ZUOtMVklM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.104] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4WH7xL6hT7zRnmK;
	Sun,  7 Jul 2024 15:52:53 +0200 (CEST)
Message-ID: <c3fa919a-2c4c-4c0f-9e6d-de7bdfeee80c@kdbg.org>
Date: Sun, 7 Jul 2024 15:52:53 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Junio C Hamano <gitster@pobox.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
Cc: Git Mailing List <git@vger.kernel.org>
Subject: [GIT PULL] git-gui pull request
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Junio,

I assume that a pull request like this is your preference. Let me know
if anything can be improved.

Concerning the commits themselves:

- Mark Levedahl's are already in your tree, but I merged the branch as
  well, so they are mentioned in the summary.

- Josh's, Taylor's and your commits are cherry-picks of the parts
  concerning git-gui that are also in your tree.

- The other commits are new.

The tree of my commit 6a8c13e03daf is identical to your git-gui tree as
of v2.45.0:

$ git rev-parse v2.45.0:git-gui 6a8c13e03daf:
8c60bdfc0dce346d1fff62e20ee548f9bb9b6de1
8c60bdfc0dce346d1fff62e20ee548f9bb9b6de1

---
The following changes since commit e25cbdf3576f07bda742a4f13d9380a815e43502:

  Merge branch 'ml/cygwin-fixes' (2023-08-24 16:46:29 +0200)

are available in the Git repository at:

  https://github.com/j6t/git-gui.git master

for you to fetch changes up to 2864e855932540c3ec6c9bf41ee3fe027d85f642:

  Merge branch 'os/catch-rename' (2024-07-07 14:14:59 +0200)

----------------------------------------------------------------
Johannes Sixt (5):
      Merge branch 'ml/git-gui-exec-path-fix'
      git-gui: note the new maintainer
      Merge branch 'bc/french-translation'
      Merge branch 'pk/swedish-translation'
      Merge branch 'os/catch-rename'

Josh Soref (2):
      doc: update links to current pages
      doc: switch links to https

Junio C Hamano (1):
      Makefile(s): do not enforce "all indents must be done with tab"

Mark Levedahl (2):
      git-gui - re-enable use of hook scripts
      git-gui - use git-hook, honor core.hooksPath

Orgad Shaneh (1):
      git-gui: fix inability to quit after closing another instance

Peter Krefting (1):
      git-gui: sv.po: Update Swedish translation (576t0f0u)

Taylor Blau (1):
      Makefile(s): avoid recipe prefix in conditional statements

brian m. carlson (1):
      git-gui: po: fix typo in French "aperçu"

 .gitattributes   |    1 +
 Makefile         |   16 +-
 README.md        |    4 +-
 git-gui.sh       |   37 +-
 lib/encoding.tcl |    2 +-
 po/README        |    2 +-
 po/fr.po         |    2 +-
 po/sv.po         | 3611 ++++++++++++++++++++++++++++--------------------------
 8 files changed, 1863 insertions(+), 1812 deletions(-)
