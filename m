Received: from www610.your-server.de (www610.your-server.de [162.55.254.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C1E17A300
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 18:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.55.254.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776883722; cv=none; b=D8FFvNCmfIhADoH41z4BiMhS+uRG95hTGcJdosn3k3iMYTjss2IUCCrdme7hbLPVSaHc84uNgH6biYvOX2bry8f1N1zqixYkH93FwCW+3PYX5Rs6LMIm718IkT6FR/RJJch27VXYV+blL7hatvK/vx38LQmXHHmApvlmo+lJ4H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776883722; c=relaxed/simple;
	bh=Mct+yDZhai4pWu13zUUPSXZJgqNO/1If7Hia02SWafc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HilfH33I3CRs/jFipytUwUk5HIbLJbwJl7zxKu/AiN7dk2Qm+/LezoDrnxy9PCz/d6yiLscRvJ5bj7LIMB/4L/nrPHee0mz265XiCnDojMNlSQFGBKQ9rfsXyBbq1kjT5lUYLR3KLIQMcCRT4P+RFyzXN86NwCtLZpm0IUNOvuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=beniamino.eu; spf=pass smtp.mailfrom=beniamino.eu; dkim=pass (2048-bit key) header.d=beniamino.eu header.i=@beniamino.eu header.b=mjfRxNAi; arc=none smtp.client-ip=162.55.254.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=beniamino.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=beniamino.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beniamino.eu header.i=@beniamino.eu header.b="mjfRxNAi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=beniamino.eu; s=default2503; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=j1usttzDQA31mycrLSWiqzrdjFnHByUASNWxsNr7KdI=; b=mjfRxNAiRA8EEFSOro0PobHN9q
	eK63xlLT2Lc3Nckb8rQdAbZBmrySmyc6fqYXdzUWlcZWS/kcAdv5kY5oToCgTk3tkIVwF+QE6Yed8
	Q9IDhzCnqs4r/Qd1k5mS5fviQk5dSDIlVGxeY+vgIy1lLCMMZz9XvO7Lncazlb+rjl/iFXuNK0iOe
	UYkRdB/vAVh9i2481NxQn/uaaSdHbSHfffkkUFYpHS+XUvyLpsR3sNDkMk73y+71LMzEKBODRsR9m
	m5hl3qTB9UkUrrWVb6ZgOGfBUIGQz8MPyXPKUsJ3WizumdqwY3qXPfsDx0zHtbpuJhkdNz43TAmvr
	u8cbrj5w==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www610.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <m.beniamino@beniamino.eu>)
	id 1wFcGF-000GJw-05;
	Wed, 22 Apr 2026 20:25:19 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <m.beniamino@beniamino.eu>)
	id 1wFcGE-000Bat-1t;
	Wed, 22 Apr 2026 20:25:18 +0200
From: Matteo Beniamino <beniamino@beniamino.eu>
To: git@vger.kernel.org
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Matteo Beniamino <beniamino@beniamino.eu>
Subject: [PATCH] l10n: it.po: fix italian usage messages alignment
Date: Wed, 22 Apr 2026 20:25:04 +0200
Message-ID: <20260422182516.26667-2-beniamino@beniamino.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422182516.26667-1-beniamino@beniamino.eu>
References: <20260422182516.26667-1-beniamino@beniamino.eu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27979/Wed Apr 22 08:26:01 2026)

Fixed a misalignment in the "usage:" and "   or:" lines in the italian
help messages.

Signed-off-by: Matteo Beniamino <beniamino@beniamino.eu>
---
 po/it.po | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/po/it.po b/po/it.po
index 20fd8bb28d..b5ccd8c731 100644
--- a/po/it.po
+++ b/po/it.po
@@ -5400,7 +5400,7 @@ msgstr "uso: %s"
 #: parse-options.c:915
 #, c-format
 msgid "   or: %s"
-msgstr "  oppure: %s"
+msgstr "  o: %s"
 
 #: parse-options.c:918
 #, c-format
-- 
2.53.0

