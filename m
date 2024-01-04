Received: from mout0.freenet.de (mout0.freenet.de [195.4.92.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D292C681
	for <git@vger.kernel.org>; Thu,  4 Jan 2024 19:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freenet.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freenet.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freenet.de header.i=@freenet.de header.b="ys0jD/W/"
Received: from [195.4.92.120] (helo=sub1.freenet.de)
	by mout0.freenet.de with esmtpa (ID soekkle@freenet.de) (port 25) (Exim 4.94.2 #2)
	id 1rLTIC-00EZcS-J0; Thu, 04 Jan 2024 20:22:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=freenet.de;
	s=mjaymdexmjqk; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MrJ+vPCBomFSrfPyCBPpUru4GCPxkbN6sSmsP0zvn7w=; b=ys0jD/W/oYiDMKfGqitglLOoTR
	9Pu4a8s2IrTgKEvfeL2j0oubefVjNJks1PaQkNbOMtP96MZR61USIHOwLzfWKJ1fduWPXPcAylFzy
	eIgtbtJvl0EuCJTY0iKCGywc1V27IhVzDWdFgq/pm5H6V6uvuzfSIX2E7qGiqMm9VynNVMTwEK/GB
	eGkKv2SVCTK6mkZgde5Im+H7nCThDMEa83JUcuKg2pKuENtfwn4NaDtNRQcps++o7N83hgj5w9isV
	k2efI4U7CHVMZpc1tr1ldyyj920ie53Ca1OGyEC32VER5VvRp4gtdEAoPo2Qq1aiqp5olLABNn7FC
	mFxQ2TOw==;
Received: from p200300e2e7202b00dacb8afffee0ca63.dip0.t-ipconnect.de ([2003:e2:e720:2b00:dacb:8aff:fee0:ca63]:35642 helo=soren-pc.lan)
	by sub1.freenet.de with esmtpsa (ID soekkle@freenet.de) (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (port 465) (Exim 4.94.2 #2)
	id 1rLTIC-00FhVK-9B; Thu, 04 Jan 2024 20:22:12 +0100
From: =?UTF-8?q?S=C3=B6ren=20Krecker?= <soekkle@freenet.de>
To: git@vger.kernel.org
Cc: sunshine@sunshineco.com,
	=?UTF-8?q?S=C3=B6ren=20Krecker?= <soekkle@freenet.de>
Subject: [PATCH v5 0/1] Replace SID with domain/username on Windows
Date: Thu,  4 Jan 2024 20:22:01 +0100
Message-Id: <20240104192202.2124-1-soekkle@freenet.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <DB9P250MB0692C8B4D93ED92FEE680AA9A560A@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
References: <DB9P250MB0692C8B4D93ED92FEE680AA9A560A@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-FN-MUUID: 1704396132C798A01E962BO
X-Originated-At: 2003:e2:e720:2b00:dacb:8aff:fee0:ca63!35642
X-Scan-TS: Thu, 04 Jan 2024 20:22:12 +0100

Hi everyone,

I change the error message. I Hope that it is now better for every one.

Thanks

Sören Krecker (1):
  Adds domain/username to error message

 compat/mingw.c | 64 ++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 51 insertions(+), 13 deletions(-)


base-commit: e79552d19784ee7f4bbce278fe25f93fbda196fa
-- 
2.39.2

