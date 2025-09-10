Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79875329F0B
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 17:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757524442; cv=none; b=FxfPDBspQZPzz5ZaavbkcKw59E9Tk+k7OVI9afnP/29kghVJeCWVXLhDkc5arVHPWDjehcbjboQJKQzD3bb0gpJpdy/XRN2KHeTV9Kmy8T4q2iFJoInu9nESl449gkkQUf8e5H9FLnxa19q5aNDt6nko96ZIioTubissFeOdQMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757524442; c=relaxed/simple;
	bh=zzr3ywqS0UUhO5qawdlxRLGHbb9nF/z2pzNGIUE9IMg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=k3M8A2MpQ2FC+eBbhEkvszqz7ijcV7qYotTJf5zlw67zI3Z5h9zbBW407FkmXCSvUMznPQg9T96+GMzpufyM6O6ZEiP+t55d9+TPjULc50cLS82Ff1BPS+FhaJrKn/47XMXfue0mA/pp4qN0SW/pSMHzQxALL1yd6h90qh0aW4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.104] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4cMS2k13SbzRnmF;
	Wed, 10 Sep 2025 19:13:49 +0200 (CEST)
Message-ID: <a2482504-b372-490b-866f-75d8b07566fd@kdbg.org>
Date: Wed, 10 Sep 2025 19:13:49 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johannes Sixt <j6t@kdbg.org>
Subject: [GIT PULL] gitk: macOS fixes, README
To: Junio C Hamano <gitster@pobox.com>
Cc: Git Mailing List <git@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The following changes since commit 93ff79ed417e8d1afa770b31721ad3640ed2d0ad:

  Merge branch 'docglobs' of github.com:ilyagr/gitk (2025-08-04 18:20:32 +0200)

are available in the Git repository at:

  https://github.com/j6t/gitk.git master

for you to fetch changes up to ac8fec7d8de265e56441713faaf4e08f11c31469:

  gitk: add README with usage, build, and contribution details (2025-08-28 19:51:31 +0200)

----------------------------------------------------------------
Johannes Sixt (2):
      Merge branch 'aqua-ctxbut' of github.com:ZhongRuoyu/gitk
      Merge branch 'tk87-touchpad-scroll' of github.com:ZhongRuoyu/gitk

Michael Rappazzo (1):
      gitk: add README with usage, build, and contribution details

Ruoyu Zhong (2):
      gitk: use <Button-3> for ctx menus on macOS with Tcl 8.7+
      gitk: fix trackpad scrolling for Tcl/Tk 8.7+

 README.md | 93 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 gitk      | 26 +++++++++++++++++-
 2 files changed, 118 insertions(+), 1 deletion(-)
 create mode 100644 README.md
