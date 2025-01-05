Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD661D5ADA
	for <git@vger.kernel.org>; Sun,  5 Jan 2025 22:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736116228; cv=none; b=T6j1n7UP94jOfSTE7yqiWTo58au/CtRr7CGeJjdxLb/G8onj8lYns1eW7/RpoR5W9+fIrGAnEFyq5ZkQjm9b6Z9kw1ofdBsxFFjQMlLE0ALxAuNfjSLtl+09/ZbElzmtXjquh/2TPTIOb0ngi9RItfdVORlWJUeCRo649isWRso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736116228; c=relaxed/simple;
	bh=MRtqxiAOPHxpplAJ+baRJt3/WhBLxeNASIB73AqE8kA=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=rpBm62v04ImIZRq1AzQumokXNyKjZaDtkSRnoMgzvqL4nrR/7RkqgSvo5MK6J438doEzmy949xnGP3ptcgu4zBJ+ghRNDab7YWAeecSyx1Pc7HCvvE7nAcuNMiIsqV5wSX6siD5RJwneLM3zYj5DjF0+j9DlsUq8kFLg1mK+vkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp.bon.at (unknown [192.168.181.101])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4YR9hc0Jq1z7Qh0X
	for <git@vger.kernel.org>; Sun,  5 Jan 2025 22:40:16 +0100 (CET)
Received: from [192.168.0.106] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4YR9hS1XT1zRpKQ;
	Sun,  5 Jan 2025 22:40:08 +0100 (CET)
Message-ID: <9f806733-2498-4959-8878-9aae4e623bde@kdbg.org>
Date: Sun, 5 Jan 2025 22:40:08 +0100
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
Cc: Git Mailing List <git@vger.kernel.org>
Subject: [GIT PULL] gitk: Bulgarian translation
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The following changes since commit 661734e6c8c38d2cd2000481ffb22cca6e2b0e5e:

  Merge branch 'ah/commit-id-to-clipboard' (2024-12-17 21:54:58 +0100)

are available in the Git repository at:

  https://github.com/j6t/gitk.git master

for you to fetch changes up to e76b53ef23871ff81ab305822eb605baf0cc5bd3:

  gitk: Update Bulgarian translation (327t) (2024-12-24 11:58:09 +0100)

----------------------------------------------------------------
Alexander Shopov (1):
      gitk: Update Bulgarian translation (327t)

 po/bg.po | 730 +++++++++++++++++++++++++++++++++------------------------------
 1 file changed, 385 insertions(+), 345 deletions(-)
