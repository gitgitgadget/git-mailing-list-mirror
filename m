Received: from mx.mylinuxtime.de (mx.mylinuxtime.de [88.99.235.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2C8225D4
	for <git@vger.kernel.org>; Tue, 16 Jul 2024 10:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.235.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721124114; cv=none; b=tlc32y0VHWNMbIUSSWKxNqcHsrs33NdXWPHWBakMwQnTfSmJfPPuR03oAeWEF5RSS4+lR2BcEs5W91pkDTzvUlQN6D/hO6YYnf/kUiJwj7S6mLdA+xOvVqQIBR0UMSEC1Bub7XmK4jS7CNQ3cWix9ZFjbVp8/moiyZVeAHjmoDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721124114; c=relaxed/simple;
	bh=Tq7iOMwyMvSYgmtkDi6vT5uOP+sJQKhjYojwhKjsBqo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h8dh7rcZfOswzyDajrzwe6+8s/CPR7Mftd3/Smi09zHFA5XsZKHaw6HNjGrNOS3e9XytqCHUVUUqMTHvM3+lYTGXnhMsqP+HgrjHJouX2caLx3SKdsrlY4izSDII+rUCGBNySHodyM+93eMoK7R/UlunjjJjlQrKSYel+Qle6n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eworm.de; spf=pass smtp.mailfrom=leda.eworm.de; arc=none smtp.client-ip=88.99.235.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eworm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leda.eworm.de
Received: from leda.eworm.de (unknown [194.36.25.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx.mylinuxtime.de (Postfix) with ESMTPSA id 12EA2268F27;
	Tue, 16 Jul 2024 11:56:00 +0200 (CEST)
Received: by leda.eworm.de (Postfix, from userid 1000)
	id C45F21841CA; Tue, 16 Jul 2024 11:55:59 +0200 (CEST)
From: Christian Hesse <list@eworm.de>
To: Git Mailing List <git@vger.kernel.org>
Cc: Christian Hesse <mail@eworm.de>
Subject: [PATCH 1/1] refs: update the version numbers...
Date: Tue, 16 Jul 2024 11:55:44 +0200
Message-ID: <20240716095544.65931-1-list@eworm.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Hesse <mail@eworm.de>

... as they were one off.

Signed-off-by: Christian Hesse <mail@eworm.de>
---
 refs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/refs.h b/refs.h
index 0ecba21b4a..b3e39bc257 100644
--- a/refs.h
+++ b/refs.h
@@ -1087,10 +1087,10 @@ int repo_migrate_ref_storage_format(struct repository *repo,
 				    struct strbuf *err);
 
 /*
- * The following functions have been removed in Git v2.45 in favor of functions
+ * The following functions have been removed in Git v2.46 in favor of functions
  * that receive a `ref_store` as parameter. The intent of this section is
  * merely to help patch authors of in-flight series to have a reference what
- * they should be migrating to. The section will be removed in Git v2.46.
+ * they should be migrating to. The section will be removed in Git v2.47.
  */
 #if 0
 static char *resolve_refdup(const char *refname, int resolve_flags,
-- 
2.45.2

