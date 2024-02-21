Received: from smtpout1.mo529.mail-out.ovh.net (smtpout1.mo529.mail-out.ovh.net [178.32.125.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CED3C491
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 08:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.32.125.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708504928; cv=none; b=reImWid86e/gX8edc+tiBuSzjfn+rONa6QUCWOP9OaaH56vKwXmlqUmy5YgFBaTEaOajW0c20RTl287y/qhCsamvOUmLavuMkwkzxNnjB0iObqEi6MgjoSKyuFZCSHg7XfGLDYbauNiCb9qSgiTmE6UBGTFonstrp1lZy9s8/VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708504928; c=relaxed/simple;
	bh=EqVAOShsPIjWAxv9KMI26i3em+HreHc9C7sOMHkOJnA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rHDNOoae4ZSR6hXluJOG0U5JSsQVB30kuy8tDo7w1auZbUX7vTZXzW1UHHsA5zueJ7SyBv3T5xwW2pqVY3jKEjgLhp5CyS20s7VMTr4PXbR4SG1vEcBl86xmiMcacSc6Vi6HFOz5fhrLPO/v2L5VGvMBWjQj5aO2nDApCtjNbJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jwilk.net; spf=pass smtp.mailfrom=jwilk.net; arc=none smtp.client-ip=178.32.125.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jwilk.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jwilk.net
Received: from mxplan6.mail.ovh.net (unknown [10.109.139.146])
	by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 4TfqP36GqxzyxR;
	Wed, 21 Feb 2024 08:36:07 +0000 (UTC)
Received: from jwilk.net (37.59.142.102) by DAG4EX1.mxp6.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 21 Feb
 2024 09:35:58 +0100
Authentication-Results: garm.ovh; auth=pass (GARM-102R0045309486c-c6d4-490a-9500-6c85b7f5b21b,
                    CA228C6536E6D62ADD890D81204F06B0F3EAA207) smtp.auth=jwilk@jwilk.net
X-OVh-ClientIp: 5.172.255.235
From: Jakub Wilk <jwilk@jwilk.net>
To: <git@vger.kernel.org>
CC: Junio C Hamano <gitster@pobox.com>, Abhradeep Chakraborty
	<chakrabortyabhradeep79@gmail.com>
Subject: [PATCH] git-remote.txt: fix typo
Date: Wed, 21 Feb 2024 09:35:54 +0100
Message-ID: <20240221083554.5255-1-jwilk@jwilk.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DAG4EX2.mxp6.local (172.16.2.32) To DAG4EX1.mxp6.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 155b08f4-cb22-4c55-84f5-beed35fbb504
X-Ovh-Tracer-Id: 13111948842909358045
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrfedugdduvdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfgtihesthekredtredttdenucfhrhhomheplfgrkhhusgcuhghilhhkuceojhifihhlkhesjhifihhlkhdrnhgvtheqnecuggftrfgrthhtvghrnhepfefhteffhfffheetudefvdefheffgfduleejheeiteeihfefffejveeljeevheeinecukfhppeduvdejrddtrddtrddupdefjedrheelrddugedvrddutddvpdehrddujedvrddvheehrddvfeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpehjfihilhhksehjfihilhhkrdhnvghtpdhnsggprhgtphhtthhopeefpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoheptghhrghkrhgrsghorhhthigrsghhrhgruggvvghpjeelsehgmhgrihhlrdgtohhmpdfovfetjfhoshhtpehmohehvdelpdhmohguvgepshhmthhpohhuth

Signed-off-by: Jakub Wilk <jwilk@jwilk.net>
---
 Documentation/git-remote.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 1dec314834..932a5c3ea4 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -35,7 +35,7 @@ OPTIONS
 -v::
 --verbose::
 	Be a little more verbose and show remote url after name.
-	For promisor remotes, also show which filter (`blob:none` etc.)
+	For promisor remotes, also show which filters (`blob:none` etc.)
 	are configured.
 	NOTE: This must be placed between `remote` and subcommand.
 
-- 
2.39.2

