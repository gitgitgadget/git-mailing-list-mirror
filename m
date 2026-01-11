Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BC225744D
	for <git@vger.kernel.org>; Sun, 11 Jan 2026 20:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768164232; cv=none; b=cQjRHnR/Lq13TTGv2TLe39oBWOsl2Ex/Hat9zfWZnArB93nE/F2qDY4dsA6nqETfZweqJ07S4tsDPe7xSlwD2hldxd4FS9nebunILGtmna7vB3g5tT4CyvxWrT7K6120STMiBBNlko7qQwjZIZ5plOee3NxMZgx6f2c+f5Er3Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768164232; c=relaxed/simple;
	bh=oIZllf3sxxrwUscfZtPMHrSImVVLvIdl8Xv0e8c3D9g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z0Qypfjo9wfpx2UcTvON7bc+JiYcd2/ZzeqZTGbGw1U7wmClF4pp01fj4/usfULyY16ajGXa9AauJdTe16Fy7YC/23VMfmXRyW/a0P3aOghIux3yj3sYjwPGTe60eakOhsoaq6EAX0XQmV1q/4RawI2Z+4DAOyqHQ8SIanx7U40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=michael.lyo.nz; spf=pass smtp.mailfrom=michael.lyo.nz; dkim=pass (2048-bit key) header.d=michael.lyo.nz header.i=@michael.lyo.nz header.b=j/B3FO0T; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=michael.lyo.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=michael.lyo.nz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=michael.lyo.nz header.i=@michael.lyo.nz header.b="j/B3FO0T"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4dq6t41gstz9srv;
	Sun, 11 Jan 2026 21:43:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=michael.lyo.nz;
	s=MBO0001; t=1768164220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=np42Z/JUsczy3Ovqx/ll1ukwoZqe/c6GsjRc5Fy1ipc=;
	b=j/B3FO0T56PJH5lTfJoTjoDQldskckdHRW0ICm025T4wsAd83hH3wqAUPsmy6xViUvY0F6
	yqALOj+1jM18IlZStM8k7emrNWU9ggr1sxlpSBCduP5wDm1ZaydPfv+dVIvY8l6+9IvwM4
	j8rvZ1B4po0PIlHrbQuzZuNJbUAfsz23vcT9H3comyAWxK/6xzxDaMCGRVOyJS5iUEWzvc
	o7X8sJC50B86mpsgm1rjw7w5ifuhO690rROx9xCDfEt9ZnkIWyKlBuPlwT332zeSvQOGnJ
	bOJFKTRDumc4WVmBodR7gJz4ETg68/HTL4goJepRjKKxhnGGTFrr+MocxM/nsQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of git@michael.lyo.nz designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=git@michael.lyo.nz
From: Michael Lyons <git@michael.lyo.nz>
To: git@vger.kernel.org
Cc: Michael Lyons <git@michael.lyo.nz>
Subject: [PATCH 0/1] doc: git-bisect to synopsis
Date: Sun, 11 Jan 2026 15:42:47 -0500
Message-ID: <20260111204316.836446-1-git@michael.lyo.nz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4dq6t41gstz9srv

Update the format of bisect. This one was less involved than git-blame.

Should I be changing any code blocks to [synopsis] as well?
There might also be formatting changes desired among the "Bisect run" exit codes.

Michael Lyons (1):
  doc: git-bisect: convert to new doc format

 Documentation/git-bisect.adoc | 67 ++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 33 deletions(-)

-- 
2.47.3

