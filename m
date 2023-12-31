Received: from mout1.freenet.de (mout1.freenet.de [195.4.92.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B352D184C
	for <git@vger.kernel.org>; Sun, 31 Dec 2023 09:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freenet.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freenet.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freenet.de header.i=@freenet.de header.b="Y/PtGsbl"
Received: from [195.4.92.119] (helo=sub0.freenet.de)
	by mout1.freenet.de with esmtpa (ID soekkle@freenet.de) (port 25) (Exim 4.94.2 #2)
	id 1rJrsK-000SBx-4a; Sun, 31 Dec 2023 10:12:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=freenet.de;
	s=mjaymdexmjqk; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=U0Vgp5pxZB49S/vTa5nljdfqhz27Ywbpf1YKD+Njaog=; b=Y/PtGsblPW6uzAteRUB+Uc/+/W
	VZ8cqos4GP4/yz3pbRHjt/z2FYG+6mx7m5W941JXiCT5EimwGsAChuAmjer03g1zGDlRbO2fgcjoG
	DIObg9c9E3K4Gzv5r3JHO3ogbkM4/R4EompmWvjPCNJIk/viVRK4C3prGuQQbRCs/mZjomlVBN6Y2
	jRrILV53RAxvujV76lBA8XzcQSwe+lNDWhj5AOf7P6RUzriDLZsKnKUIWHizsjXzVbGMRr5Poz0Eq
	lIAX29KzycSY5XTCP3boLijQXHVgvJUcYh7AtOT/luIG0wAsl5++RSrQakWwGNAgN1G/7qg8z1JRN
	HCcpPWaw==;
Received: from p200300e2e7202b00dacb8afffee0ca63.dip0.t-ipconnect.de ([2003:e2:e720:2b00:dacb:8aff:fee0:ca63]:50650 helo=soren-pc.lan)
	by sub0.freenet.de with esmtpsa (ID soekkle@freenet.de) (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (port 465) (Exim 4.94.2 #2)
	id 1rJrsJ-00BgXI-Rq; Sun, 31 Dec 2023 10:12:51 +0100
From: =?UTF-8?q?S=C3=B6ren=20Krecker?= <soekkle@freenet.de>
To: git@vger.kernel.org
Cc: sunshine@sunshineco.com,
	=?UTF-8?q?S=C3=B6ren=20Krecker?= <soekkle@freenet.de>
Subject: [PATCH V3 0/1] Replace SID with domain/username on Windows
Date: Sun, 31 Dec 2023 10:12:44 +0100
Message-Id: <20231231091245.2853-1-soekkle@freenet.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <CAPig+cT4jy4MkyGxtSOZj6U3vUxLaRa-4wr7PON-EebAjT8pwQ@mail.gmail.com>
References: <CAPig+cT4jy4MkyGxtSOZj6U3vUxLaRa-4wr7PON-EebAjT8pwQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-FN-MUUID: 170401397124D450576935O
X-Originated-At: 2003:e2:e720:2b00:dacb:8aff:fee0:ca63!50650
X-Scan-TS: Sun, 31 Dec 2023 10:12:51 +0100

I improve the commit message with example of old and new error output.

Thanks to Eric Sunshine.

Sören Krecker (1):
  Replace SID with domain/username

 compat/mingw.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)


base-commit: e79552d19784ee7f4bbce278fe25f93fbda196fa
-- 
2.39.2

