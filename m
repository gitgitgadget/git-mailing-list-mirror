Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED0B6F06D
	for <git@vger.kernel.org>; Sun, 24 Nov 2024 17:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732469998; cv=none; b=iPhYv+ZEye+GBI+sf7PmG/ibn4OWJpt8A+32jnPW5zgdrfT8y3u7rD+997O7/2ApFmcvbNBvQh6nmLgfbrbpfsuA3pGph5hX+wrgUJODH6F+eLj1IWRY+aohSd92JpU20sYmXCcBz4iFFpeVa9NvztAYxf+eGgCTdvgVq1ZRJBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732469998; c=relaxed/simple;
	bh=ohtCmw4moROud851oFSFgjz1JD7OeKoQHk70HUsgN8M=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=MAsVKed6hJcQ94z/HQi3tYYPxsJWZdNJKuI0Wg8murcNZ4UyAkYTEJ0Vb5SoI1i7mGzmDF8YXEkaGiuIYhf9FflvRQNXp+Jx+gMJcdUrKE4daU/5yHzwTJbHdBWww5uyhXjnXLuV+5HKgwrrT8i6Sn7DFAvJpDuAN/evfzJIl4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.106] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4XxGLT1PF0zRnmP;
	Sun, 24 Nov 2024 18:39:44 +0100 (CET)
Message-ID: <2c70404d-d4ee-4e42-a330-b7fdc7c8f8c0@kdbg.org>
Date: Sun, 24 Nov 2024 18:39:43 +0100
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
Cc: Git Mailing List <git@vger.kernel.org>, Paul Mackerras <paulus@ozlabs.org>
Subject: [GIT PULL] gitk: synchronize repository trees
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The following changes since commit 7dd272eca153058da2e8d5b9960bbbf0b4f0cbaa:

  gitk: escape file paths before piping to git log (2023-05-08 09:15:24 -0700)

are available in the Git repository at:

  https://github.com/j6t/gitk.git master

for you to fetch changes up to c18400c6bb04f4e8875c1930db72ddd9b94649ca:

  Makefile(s): avoid recipe prefix in conditional statements (2024-11-24 13:45:49 +0100)

As stated in an earlier message[*], I am taking over maintainership of
Gitk. This first pull request of mine synchronizes my tree with that of
version 2.47.0 in the git.git repository:

$ git rev-parse v2.47.0:gitk-git
192acffcdd37921fc1c46c0373806651876d772c

There is no functional change because I only continued on top of the
commits that are already in git.git and cherry-picked the changes listed
below (which were tree-wide changes that covered gitk-git) into my
history.

I have prepared the change that brought us here in branch
tp/macos-visiblity-fix, but it is not yet included, because I want to
give it some workout on Windows before I move it forward.

[*] https://lore.kernel.org/git/5ccc1943-c2a3-4896-a858-aa5fd6cdd426@kdbg.org/

----------------------------------------------------------------
Josh Soref (2):
      doc: update links to current pages
      doc: switch links to https

Taylor Blau (1):
      Makefile(s): avoid recipe prefix in conditional statements

 Makefile | 4 ++--
 gitk     | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)
