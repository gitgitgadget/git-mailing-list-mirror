Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C09155322
	for <git@vger.kernel.org>; Thu, 29 May 2025 08:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748506065; cv=none; b=lRetf7p1Upqdw8441mqjpOj+db5Y/1T4Kb1gWHIOG3fPBy7zvrx8tHhNIyJUppLuSb2d7fPlZInhIlVihkHtqqt+KORkuM61AkNmQT+Whc4w9ilGxBvAxHMgoaW7tYCiCnxMdNdh5sR6qBVwAbj8DGe2wVeAuaCgCbNEyeEZgLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748506065; c=relaxed/simple;
	bh=IWZqSCPMS6WRQytuvWT9n4EAG4JsLGnCiDZYofb3p0A=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=MzLwxzHqvoisUJogLhzTruKnwrACJVYeb+1NDnaoYkeCpKZPnLGY1ZJ0lt4swnjyGMJ0w+8exNGrjywf9tzOUK0BQsWN4DsnF9o2pdhjQsqEqiJNjq7sAC1enLUrGx+IZp7RQvAuvEjT8FwxDVUpdvFWApRHyfaEL4SwtF5Xd6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.100] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4b7JrP5qDYzRnmF;
	Thu, 29 May 2025 10:07:33 +0200 (CEST)
Message-ID: <7c7779c1-32a7-4a6b-a193-be516e620233@kdbg.org>
Date: Thu, 29 May 2025 10:07:33 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johannes Sixt <j6t@kdbg.org>
Subject: [GIT PULL] gitk: MacOS preferences fix, minor fixes
To: Junio C Hamano <gitster@pobox.com>
Cc: Git Mailing List <git@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The following changes since commit 3fdbf184be906b5f6abb35c02842ec8ad861e8f9:

  Merge branch 'at/translation-tamil' (2025-05-09 18:01:02 +0200)

are available in the Git repository at:

  https://github.com/j6t/gitk.git master

for you to fetch changes up to bfb0fa7099e541c15d103b75f453f613a751da03:

  Merge branch 'top-panel-search-highlight' of github.com:bnfour/gitk (2025-05-22 19:15:31 +0200)

----------------------------------------------------------------
Alexander Ogorodov (1):
      gitk: do not hard-code color of search results in commit list

Johannes Sixt (3):
      gitk: place file name arguments after options in msgfmt call
      Merge branch 'yh/fix-non-themed-combobox'
      Merge branch 'top-panel-search-highlight' of github.com:bnfour/gitk

YOKOTA Hiroshi (1):
      gitk: Legacy widgets doesn't have combobox

 Makefile |  2 +-
 gitk     | 10 ++++------
 2 files changed, 5 insertions(+), 7 deletions(-)
