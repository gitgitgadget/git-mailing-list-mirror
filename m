Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720CE369203
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 09:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781257143; cv=none; b=Neyo4931dqzajvE25S8VjcDTfbReD3HVu4patQCgyNbb+mRK8PHyPzLiI7XU1ahkiGAXgHCsSdT2ca0NU/LN9Zb83tjEkiAxS2eXW8tT9lfykdlwiYhHP8UCQjATIwNe6IfypTUM4hGUPPJwWbA2IURCtqM1fbc+Kny4eliMiak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781257143; c=relaxed/simple;
	bh=HKU/KLQwZ7ds+uQaO0rP0E4ahZgYa8bcE4bMaskkmpw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=NDOht2mBD8lJGA22+rB3rp2ZrCXEiam+vXRgOG0poCMATTCyqosnZT9LiV+JfOhxNuS2TWJGy/5moua7SPsx6a8v+5E1JGG06Wk/HCztuH/RHJmso0np+f41d1UY3bAd4Dzriw5FAwddaeLv3M41m6j7fnzggFErpMx0mFNwN3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp3.bon.at (unknown [192.168.181.108])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4gcDwp3BVXz7R1pM
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 11:38:50 +0200 (CEST)
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4gcDwd1HFrzRnlV;
	Fri, 12 Jun 2026 11:38:40 +0200 (CEST)
Message-ID: <c2e32c3f-2496-4fdb-a698-56153931f49c@kdbg.org>
Date: Fri, 12 Jun 2026 11:38:40 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johannes Sixt <j6t@kdbg.org>
Subject: [GIT PULL] gitk: horizontal scrollbar for commit list
To: Junio C Hamano <gitster@pobox.com>
Cc: Git Mailing List <git@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The following changes since commit c8c5df79df34b40119c4bf8e3079520762f258d1:

  Merge branch 'jx/i18n-fix' of github.com:jiangxin/gitk (2026-03-20 09:23:32 +0100)

are available in the Git repository at:

  https://github.com/j6t/gitk.git master

for you to fetch changes up to bad83ada0ebf9e293d570e6e7ca4f1cd7877f482:

  Merge branch 'horizontal-scroll' of github.com:ramcdona/gitk (2026-06-12 11:30:22 +0200)

----------------------------------------------------------------
Johannes Sixt (1):
      Merge branch 'horizontal-scroll' of github.com:ramcdona/gitk

Rob McDonald (1):
      gitk: add horizontal scrollbar to the commit list pane

 gitk | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)
