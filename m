Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65F52857CD
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 08:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771575467; cv=none; b=q7Qvc/z+YGPaAktRFSC9njpac2BFH/80iFqOrpvy/ybmf5IUh5YeEBkSrezmuGxtQ3xLDeOR616rgp/KkkggMgFoGFVRGS5hgWYJLEXlBY5V669p35ZzpHuV23g25HyEKHGgggZpQhnzcAUl6WMe7ykyjVZ4Cfrs5QDfZB2KHEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771575467; c=relaxed/simple;
	bh=+3PvBIrsfoaOcdjsAe0tLSeuA0YYNDjjOsj/90eUwdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XrjAY3mCP7MGESKFvbbvZi87OAOGOR1vjGiTJHjB47gPKocbYhdY9wIaK3MeOVQF5LNMOMbBMBs573XG5Z/yGuaxvrYBPQTP8+GaRDT+w+CIYF1f7V6NAJKcS1Tf7ShsdGeK8KxnQdzAnNO9bFY8uuDLZvJnkvlfYWLfWzk1n1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b=tRb4D2FN; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b="tRb4D2FN"
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id C67E91D49A;
	Fri, 20 Feb 2026 08:17:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 embla.dev.snart.me C67E91D49A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dev.snart.me; s=00;
	t=1771575465; bh=+3PvBIrsfoaOcdjsAe0tLSeuA0YYNDjjOsj/90eUwdQ=;
	h=From:To:Cc:Subject:Date:From;
	b=tRb4D2FNmhLKdg3hU2tIOR3ajipTDyDM6etG3zmZZFiEVeXOwasI6wBPwsfwYoceR
	 lVGwnIuqZbd7GUs4xN5TD1LjTFPxRMye7ZLqOpn0T9RVaJDo9q/qI+KaohCJr7cXXL
	 Pd7KgHXXWLSzJeGstsnzC0Q8n8zMkdWU+Dx++VB0=
Received: from maya.d.snart.me ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id 5H+NHagYmGmxoAIA8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Fri, 20 Feb 2026 08:17:44 +0000
From: David Timber <dxdt@dev.snart.me>
To: git@vger.kernel.org
Cc: David Timber <dxdt@dev.snart.me>
Subject: [PATCH v1 0/1] send-email: add client certificate options
Date: Fri, 20 Feb 2026 17:17:12 +0900
Message-ID: <20260220081717.555185-1-dxdt@dev.snart.me>
X-Mailer: git-send-email 2.53.0.1.g242c94b05d.dirty
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Additional doc touch up on configurations. No code change :)

David Timber (1):
  send-mail: add client certificate options

 Documentation/config/sendemail.adoc |  6 ++++
 Documentation/git-send-email.adoc   | 17 ++++++++++
 git-send-email.perl                 | 48 ++++++++++++++++++++++-------
 3 files changed, 60 insertions(+), 11 deletions(-)

-- 
2.53.0

