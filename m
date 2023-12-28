Received: from mout2.freenet.de (mout2.freenet.de [195.4.92.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01208468
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 13:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freenet.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freenet.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freenet.de header.i=@freenet.de header.b="huOvD9jo"
Received: from [195.4.92.122] (helo=sub3.freenet.de)
	by mout2.freenet.de with esmtpa (ID soekkle@freenet.de) (port 25) (Exim 4.94.2 #2)
	id 1rIqRR-002qLm-HB
	for git@vger.kernel.org; Thu, 28 Dec 2023 14:28:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=freenet.de;
	s=mjaymdexmjqk; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wTWlmKMePrQchPenDbj0mClpjfRD5lEPb1XJ4Z7OBuc=; b=huOvD9joYWQOGxUpbxKOrif8Km
	EvWMBfZup+n2h/UtmlKtn80i9zbYVjBse8JPRExsBocRGNSXsUYuHuYIc4olCCAH8GN/AJ/HTg5di
	TOfz6bSsh/594XLvGP3bypVCf4XpyjgR0qFrIz4I2RcPwGX9vX5VjgNAQzF4qFjcTZQ6O4RgWjxPo
	zgyp7SgsIn1UGfuIvobjJ/Qx6Zg66hA5lrRfOEKXDbRWZr2E+KnW27YwkRqZfQFgeI8Aai3yFUPdE
	pX1ECP7lFCMLwNMBZAeo7c+an8BuhfYZncpmOM/hAesTockm2J/bzhUpf5BcQWYpVEWUlfMBTFrk+
	vhyFs0+g==;
Received: from p200300e2e7202b00dacb8afffee0ca63.dip0.t-ipconnect.de ([2003:e2:e720:2b00:dacb:8aff:fee0:ca63]:33666 helo=soren-pc.lan)
	by sub3.freenet.de with esmtpsa (ID soekkle@freenet.de) (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (port 465) (Exim 4.94.2 #2)
	id 1rIqRR-004Ja0-7t; Thu, 28 Dec 2023 14:28:53 +0100
From: =?UTF-8?q?S=C3=B6ren=20Krecker?= <soekkle@freenet.de>
To: git@vger.kernel.org
Cc: =?UTF-8?q?S=C3=B6ren=20Krecker?= <soekkle@freenet.de>
Subject: [PATCH 0/1] Replace SID with domain/username on Windows
Date: Thu, 28 Dec 2023 14:28:43 +0100
Message-Id: <20231228132844.4240-1-soekkle@freenet.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-FN-MUUID: 1703770133330F25F87893O
X-Originated-At: 2003:e2:e720:2b00:dacb:8aff:fee0:ca63!33666
X-Scan-TS: Thu, 28 Dec 2023 14:28:53 +0100

*** BLURB HERE ***

soekkle (1):
  Replace SID with domain/username

 compat/mingw.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)


base-commit: e79552d19784ee7f4bbce278fe25f93fbda196fa
-- 
2.39.2

