Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221DF3595D
	for <git@vger.kernel.org>; Sat, 24 Jan 2026 08:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769243534; cv=none; b=AXYMqxYKU8mAUZc8kskukTkqYkcbX67/6oRdoVER7kqLGPedXAVvZVY7OSxTVZ8BahMV6O1cH7EUK1/EODghcCwm5BorARcVFffLKeXTo5wRCo/jy3TEKqKD7HE9dJzEr5fAzOX0cQFRI6MSERLGgZco5LWbRRldZwzz/3+pa7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769243534; c=relaxed/simple;
	bh=AWjUS56Ib3JOL0hbAU4fCXCIv8mYBzQ6OmxjF7bcwDA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=QR3JWUe0NwXuCO9JxB8WD27Vb5Sq4l5WcbNu0W1J6i6p2i79v6h6AoHXS6zxxEAi9meJ3QGTC6mp/k/dZp9pvbcdZbksOu2GoSjMGpDOV/FE5kaMa9pY4zXTHRWwt5gnprxifsy3jXmIJDdhQLKf1iOOqbtWWd75LSZp/Twlblw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp2.bon.at (unknown [192.168.181.105])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4dyp1w53pxz7QZN9
	for <git@vger.kernel.org>; Sat, 24 Jan 2026 09:32:04 +0100 (CET)
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4dyp1l5V2VzRnlL;
	Sat, 24 Jan 2026 09:31:55 +0100 (CET)
Message-ID: <90358cd1-1a4e-45b6-8c1d-7b6bda0c8d46@kdbg.org>
Date: Sat, 24 Jan 2026 09:31:55 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johannes Sixt <j6t@kdbg.org>
Subject: [GIT PULL] git-gui: small Bulgarian translation update
To: Junio C Hamano <gitster@pobox.com>
Cc: Git Mailing List <git@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The following changes since commit 7ef77ec0054b3b4ef3cfee6ef97c43c01965be88:

  git-gui: sync Makefiles with git.git (2025-09-06 11:59:48 +0200)

are available in the Git repository at:

  https://github.com/j6t/git-gui.git master

for you to fetch changes up to 453fd8d14ce441896e0b39b85c67c9c26e34d46d:

  Merge branch 'master' of github.com:alshopov/git-gui (2026-01-24 09:25:29 +0100)

----------------------------------------------------------------
Alexander Shopov (1):
      git-gui i18n: Update Bulgarian translation (557t)

Johannes Sixt (1):
      Merge branch 'master' of github.com:alshopov/git-gui

 po/bg.po | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)
