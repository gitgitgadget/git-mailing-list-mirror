Received: from tortuga.telka.sk (tortuga.telka.sk [185.14.234.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18CD5C8EF
	for <git@vger.kernel.org>; Wed, 15 May 2024 14:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.14.234.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715784150; cv=none; b=N0CLc9zsiCt4Js/olvfGUWlT0pztLR+y/BpOnUIoxkOJ9NHiHVwrPZphIIAHn1Oc2E6BoiGG3k+kFgDZV+gWf/3L7K3GfO79u1xA8D9/d6z7KdItkEX/FdBfdlTvS2i0KrtXlS0Zto7laVxNKOWp+4/fTk+7BTUyTVxgfT4E5E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715784150; c=relaxed/simple;
	bh=OvXPCEKswWoJjx9cHSw2bBSZgf5i0PatRFAHprP9r9A=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=H9VbslijABlPm3gBj/du4vxKj9wd854jOBYLm5zTueJW7Xnp0ZArw6H/R18ZTx+YbKA8XBRwdsXyRH4/n1yBbdgXcQHHToPVVnyx69l0QeiA+S9ThIrtezDJCXr5lkvXv3ZEka/fTowbtOir6L2IUfMg1j/4uQacu+VBR3j22MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telka.sk; spf=pass smtp.mailfrom=telka.sk; arc=none smtp.client-ip=185.14.234.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telka.sk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telka.sk
Received: (qmail 15433 invoked from network); 15 May 2024 14:35:43 -0000
Received: from telcontar.in.telka.sk (HELO telcontar) (marcel@10.0.0.10)
  by tortuga.telka.sk with ESMTPSA (DHE-RSA-AES256-GCM-SHA384 encrypted); 15 May 2024 14:35:43 -0000
Date: Wed, 15 May 2024 16:35:42 +0200
From: Marcel Telka <marcel@telka.sk>
To: git@vger.kernel.org
Subject: t0211-trace2-perf.sh: typo patern -> pattern
Message-ID: <ZkTIPlTS4jcQ-rHX@telcontar>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

There seems to be apparent typo in the t/t0211-trace2-perf.sh file:


--- a/t/t0211-trace2-perf.sh
+++ b/t/t0211-trace2-perf.sh
@@ -233,7 +233,7 @@ have_counter_event () {
 
        pattern="d0|${thread}|${event}||||${category}|name:${name} value:${value}" &&
 
-       grep "${patern}" ${file}
+       grep "${pattern}" ${file}
 }
 
 test_expect_success 'global counter test/test1' '


Thanks.

-- 
+-------------------------------------------+
| Marcel Telka   e-mail:   marcel@telka.sk  |
|                homepage: http://telka.sk/ |
+-------------------------------------------+
