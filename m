Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC32479D8
	for <git@vger.kernel.org>; Sat, 30 Mar 2024 04:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711772800; cv=none; b=JaHLVpR8sZyJxSBR7q4jMJPB62SfV/nNUa4jk0BW6b3HGc27J5jh2AmjcE4b9n09EPtX168NMKewxLsMtBAKKjcCNMFj5IpFh7YvjxhJEW1n/peaEfu1Pf0wrMN+x3pDiVnJShN2XfLGa14QPXTnZvOo9GWz5tIPO0n+IILGvVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711772800; c=relaxed/simple;
	bh=1SNhATiA8Dr604g/ecVNGlulXe8t3r+YesiuhaXOics=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=P5tTMdpE7z+vo5EyxTyL2oKxK3bovVMtKekZxerJ31/W0et7oKMwe7cZ7iIJkq6aylbgnQYxsfNMKNS19PHNm6y+PrRaLuF87W+4Hs3Oo7TEdPkxA7lFuCSuIPNclJg011ebcu/x1zfWLvQPd9CdU7UPeo7hchlgKe4BhIynPPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=DD2wwxqU; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="DD2wwxqU"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1711772794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZCIV87vXMzy5VpTDJJNl6dfKAWBzOdyd0JwUDEVXI1g=;
	b=DD2wwxqUreoe20bMWu37sh/uvII3Oe9Gjxl2qgz0QuDDU8RUGTmpEjLN/TM1S0x1Hryp6z
	J5yyUWfJvc06q1Y003hOOZh9WrGFxxIZ0z0kP9XToG0LymUUVJcO8cyh7M4jsL6l7DbSr/
	4Rx3GlRFY6KJr3gpvF1aseE761vimgxRTJIkTXH8CRgSRj10idjKrKkljvnG1wNGqqzy0t
	NHD1tfrDCKnHAzK/sCc1SC8MKyYCzGA+YvfMrZZEAZIDOhu/Fyhks7u/NNEyeEErBMqTRF
	2w1j9ZMjvxb5GUJGIqoyXWMbNR2OfpjdZMzZwkrvEQWNN/PpaRP59RmnovT0yw==
To: git@vger.kernel.org
Subject: [PATCH] config: fix some small capitalization issues, as spotted
Date: Sat, 30 Mar 2024 05:26:31 +0100
Message-Id: <6f6f821fc090fb59f632fcdbd061154b897b1244.1711772691.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Fix some small capitalization issues, as spotted while going through the
documentation.  In general, a semicolon doesn't start a new sentence, and
"this" has no meaning of a proper noun in this context.

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---

Notes:
     * Fix some small capitalization issues in the documentation.

 Documentation/config/core.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index 2d4bbdb25fa3..31fe417065c6 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -688,7 +688,7 @@ core.createObject::
 	will not overwrite existing objects.
 +
 On some file system/operating system combinations, this is unreliable.
-Set this config setting to 'rename' there; However, This will remove the
+Set this config setting to 'rename' there;  however, this will remove the
 check that makes sure that existing object files will not get overwritten.
 
 core.notesRef::
