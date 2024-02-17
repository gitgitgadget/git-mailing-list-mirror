Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2ACC12E61
	for <git@vger.kernel.org>; Sat, 17 Feb 2024 00:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708129701; cv=none; b=t2u+bfd8BbA2r0haKLJpXV30YcwxKizGZypv7cGNDiAFld5F3l+Ev9QPR2/aEdedAjHjbInbQly7uxxla+xgO2OzR1N40DLsYklaVKHTJe43r6zwmJfON9B+hoUXrBYwZgVlMinxURp+gN7SyPNFUk8fRczyNXHM02xcIG8hEsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708129701; c=relaxed/simple;
	bh=mCUXR0jSjiwnF8sBSVZJV5c92h2I4fPSS+lY+a7gWDI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h0CP7/lXmJtQeKlXlE0yiWin0rnQgOIBD+8FDtjUeJwKBN166HFM/oMy3GcPdC2xS2YpiRhYu7Nzppyhoon3XuSnL6Xzelh9MUSJV0FIwWqq36MbwrcHFdRaVOQcoI1M+bUY1rPMNDRMHrwptEk8AenZQSFJap7cY2j9MbXCE7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=obfP08fX; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="obfP08fX"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 38C231E7EBA;
	Fri, 16 Feb 2024 19:28:18 -0500 (EST)
	(envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-transfer-encoding;
	 s=sasl; bh=mCUXR0jSjiwnF8sBSVZJV5c92h2I4fPSS+lY+a7gWDI=; b=obfP
	08fXCWF6EMwHarjEUZVzMJMUTlPDNA7MCY0nxDx45bnnQn19yqgduZ2jS69FHP0Q
	uP6d5ZUwXI0uJ4TFtPUIxhhY8wQm/1IAHOYJGaZZfjduPcXQHWNOVSqo6l2tyQuu
	yxqOrhtUivqEsSuOKWTcg6VR+YOaytYE3vntHno=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 302301E7EB9;
	Fri, 16 Feb 2024 19:28:18 -0500 (EST)
	(envelope-from tmz@pobox.com)
Received: from morphine.paradise.teonanacatl.net (unknown [47.204.171.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7C3301E7EB8;
	Fri, 16 Feb 2024 19:28:17 -0500 (EST)
	(envelope-from tmz@pobox.com)
From: Todd Zullinger <tmz@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: [PATCH] RelNotes: minor typo fixes in 2.44.0 draft
Date: Fri, 16 Feb 2024 19:28:03 -0500
Message-ID: <20240217002806.231340-1-tmz@pobox.com>
X-Mailer: git-send-email 2.44.0.rc1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 72134614-CD2B-11EE-9DB4-78DCEB2EC81B-09356542!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 Documentation/RelNotes/2.44.0.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/RelNotes/2.44.0.txt b/Documentation/RelNotes/2=
.44.0.txt
index 7dd8d75844..731c3f7592 100644
--- a/Documentation/RelNotes/2.44.0.txt
+++ b/Documentation/RelNotes/2.44.0.txt
@@ -3,7 +3,7 @@ Git v2.44 Release Notes
=20
 Backward Compatibility Notes
=20
- * "git chekcout -B <branch>" used to allow switching to a branch that
+ * "git checkout -B <branch>" used to allow switching to a branch that
    is in use on another worktree, but this was by mistake.  The users
    need to use "--ignore-other-worktrees" option.
=20
@@ -54,7 +54,7 @@ UI, Workflows & Features
    gitweb behaved as if the file did not exist at all, but now it
    errors out.  This is a change that may break backward compatibility.
=20
- * When $HOME/.gitignore is missing but XDG config file available, we
+ * When $HOME/.gitconfig is missing but XDG config file available, we
    should write into the latter, not former.  "git gc" and "git
    maintenance" wrote into a wrong "global config" file, which have
    been corrected.
--=20
2.44.0.rc1

