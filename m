Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7908FD2EE
	for <git@vger.kernel.org>; Fri, 10 May 2024 18:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715366204; cv=none; b=ip1oSOj4xM+zmFQ744Gr7nYxwPSDW79x2QXAGYOLcL1ZPXqfn11vNpIXjTTMzc1O5c2iq5eW7oVrzUecKsY/Y/ybR8tgw4A3VUhh4z6uBm0MwVszJY4erXmAXob6I1NLaFO4HwKW2ARloHJQQTvUKMIeiXNg0wBXdh/RTkYlHAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715366204; c=relaxed/simple;
	bh=E0ivETe3ft5RqX8PgReuVtbGt1fnDszvi7EXSA/dLwU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OPzU0ElvsCKRzbqWy5cGV6U+VsVHDlm0gYgJphWe3HIOhiwwKwRktUrCK+WotdDrX1KU7LEkfXqE8tXMddELhlKEFC9gcGArJGgEmX3odKuUsyu39mrC211LZRdAXEGiEIBt3KyWftX7yssTdCD4t0esL9XkbQJ/d4uRKwWGilM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FqWaz0Pa; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FqWaz0Pa"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715366198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=R8O1eEpc3cH4zCrDXGVQhm5btkp9bX/FfpfZXaH4jPs=;
	b=FqWaz0Pag3HBa9Dz8Ex93bY1vv2D4dN2yd7rG7if2gG+JpLr/vF06YPxlW4b8jlaqBIvEW
	WFtt0PMQ8NFI6QLJXHmJHYAvofVvzfZCVkQoxH44MIfKX4xXvy6f+UVzF9ptohydGNKOjm
	4S4J2v8FLcLrmvuFOV68L6TLt/wtNK4=
From: Dov Murik <dov.murik@linux.dev>
To: git@vger.kernel.org
Cc: Dov Murik <dov.murik@linux.dev>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Arver <linusa@google.com>
Subject: [PATCH] doc: git-update-index: add --show-index-version to synopsis
Date: Fri, 10 May 2024 14:36:22 -0400
Message-Id: <20240510183622.77750-1-dov.murik@linux.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Fixes: 606e088d5d9a ("update-index: add --show-index-version")
Signed-off-by: Dov Murik <dov.murik@linux.dev>
---
 Documentation/git-update-index.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 8c47890a6a..7128aed540 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -25,6 +25,7 @@ SYNOPSIS
 	     [--really-refresh] [--unresolve] [--again | -g]
 	     [--info-only] [--index-info]
 	     [-z] [--stdin] [--index-version <n>]
+	     [--show-index-version]
 	     [--verbose]
 	     [--] [<file>...]
 

base-commit: 3402c0e53fb798cb471dd6562eb5c938885b7295
-- 
2.39.3 (Apple Git-146)

