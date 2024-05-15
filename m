Received: from tortuga.telka.sk (tortuga.telka.sk [185.14.234.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A9739FEC
	for <git@vger.kernel.org>; Wed, 15 May 2024 22:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.14.234.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715813469; cv=none; b=AeEzGbGFVS7MaEO433kbQbssvSX8srDo02waUtra0BGZX9kt8c450b49g2nmsGL24TsEIwiF/J+KOed4im+gcd6ecnQTYMINwCIKbEaKWvsa7WS9pKw+ci+mUdjN6dVAievw1v5og8omCbL/re8n0D44rK3s2kE+w8tw6ZhXgYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715813469; c=relaxed/simple;
	bh=sHM4yRa7WTWP9hgMicIaPciMDfd7r65p9x6wQotq7Jk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=luYzvzf19mvz7ufl+ZL5gzpPv8sdpTF6yeBSDL8pyaAMXRzXhoE8rtOaUmdCPM9DxetClTMsEsX86XiX+m2EJ/j+rz7LPLgvOgeqtI9HSI2AIvFOVRzqgWfwjAaEcrkWPqLvouRfbz3P7LtH2PY95aVA9bA+Z66ddnLawM5dV0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telka.sk; spf=pass smtp.mailfrom=telka.sk; arc=none smtp.client-ip=185.14.234.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telka.sk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telka.sk
Received: (qmail 15405 invoked from network); 15 May 2024 22:51:01 -0000
Received: from telcontar.in.telka.sk (HELO telcontar) (marcel@10.0.0.10)
  by tortuga.telka.sk with ESMTPSA (DHE-RSA-AES256-GCM-SHA384 encrypted); 15 May 2024 22:51:01 -0000
Date: Thu, 16 May 2024 00:51:00 +0200
From: Marcel Telka <marcel@telka.sk>
To: git@vger.kernel.org
Subject: [PATCH] t/t0211-trace2-perf.sh: fix typo patern -> pattern
Message-ID: <ZkU8VAUnKx_SXU5U@telcontar>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received: (qmail 15178 invoked from network); 15 May 2024 22:49:23 -0000
Received: from il-bld.in.telka.sk (HELO il-bld.localdomain)
 (il-bld@10.0.0.17) by tortuga.telka.sk with ESMTPSA
 (DHE-RSA-AES256-GCM-SHA384 encrypted); 15 May 2024 22:49:23 -0000
Received: by il-bld.localdomain (Postfix, from userid 5001) id B057123B77D;
 Thu, 16 May 2024 00:49:10 +0200 (CEST)
X-Mailer: git-send-email 2.45.0

Signed-off-by: Marcel Telka <marcel@telka.sk>
---
 t/t0211-trace2-perf.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0211-trace2-perf.sh b/t/t0211-trace2-perf.sh
index 13ef69b92f..070fe7a5da 100755
--- a/t/t0211-trace2-perf.sh
+++ b/t/t0211-trace2-perf.sh
@@ -233,7 +233,7 @@ have_counter_event () {
 
 	pattern="d0|${thread}|${event}||||${category}|name:${name} value:${value}" &&
 
-	grep "${patern}" ${file}
+	grep "${pattern}" ${file}
 }
 
 test_expect_success 'global counter test/test1' '
