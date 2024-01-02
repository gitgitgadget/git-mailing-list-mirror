Received: from mout0.freenet.de (mout0.freenet.de [195.4.92.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD10815AE7
	for <git@vger.kernel.org>; Tue,  2 Jan 2024 19:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freenet.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freenet.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freenet.de header.i=@freenet.de header.b="KhSWlSy2"
Received: from [195.4.92.125] (helo=sub6.freenet.de)
	by mout0.freenet.de with esmtpa (ID soekkle@freenet.de) (port 25) (Exim 4.94.2 #2)
	id 1rKkEU-00Ax8f-HE; Tue, 02 Jan 2024 20:15:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=freenet.de;
	s=mjaymdexmjqk; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HEa/ay7DKq98HpZDjt6XemXbz0B4PF9+HQ1A36TXeRo=; b=KhSWlSy2PCipb9Kk6Cw0TjfJ43
	vU8f3RvSyG3/P0myMu0w2uy+MuzcM2D/c/1WoXLf0XFbNimSk9vEBsH8Iw3XJArIGO+mjsDwkp0y/
	ybVunT3NWQGi1WZtRVKA6KEQbSX/+fW14MG2zz/pzeaIzH2K1CDfMlXWP4BwZDVWGz6LuuPpVbF/B
	kzaSMgVJZLnn2ZPSfpextrINqM6x/kTF77gi81NPR+hPcpVSMCrMJ5SxHuXRxH2itffCteIr13v0P
	vqzQnMtSfhncjaXOOJS/mUOuwWUP/D+im4AVqIUwOTCHoHSUafv8WARvEkgOxLQ6qpYeRSdTlxsjM
	7frYv37Q==;
Received: from p200300e2e7202b00dacb8afffee0ca63.dip0.t-ipconnect.de ([2003:e2:e720:2b00:dacb:8aff:fee0:ca63]:60616 helo=soren-pc.lan)
	by sub6.freenet.de with esmtpsa (ID soekkle@freenet.de) (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (port 465) (Exim 4.94.2 #2)
	id 1rKkEU-00HPxr-8A; Tue, 02 Jan 2024 20:15:22 +0100
From: =?UTF-8?q?S=C3=B6ren=20Krecker?= <soekkle@freenet.de>
To: git@vger.kernel.org
Cc: sunshine@sunshineco.com,
	=?UTF-8?q?S=C3=B6ren=20Krecker?= <soekkle@freenet.de>
Subject: [PATCH V4 0/1] Replace SID with domain/username on Windows
Date: Tue,  2 Jan 2024 20:15:13 +0100
Message-Id: <20240102191514.2583-1-soekkle@freenet.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <xmqqsf3feilq.fsf@gitster.g>
References: <xmqqsf3feilq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-FN-MUUID: 1704222922713300CB22DFO
X-Originated-At: 2003:e2:e720:2b00:dacb:8aff:fee0:ca63!60616
X-Scan-TS: Tue, 02 Jan 2024 20:15:22 +0100

Hi everone,

I improve the commit message with information from Microsoft, fixes a memmory access error and the message in case of an error.

Vielen dank für die Hinweise von Junio C Hamano.

Sören Krecker (1):
  Replace SID with domain/username

 compat/mingw.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)


base-commit: e79552d19784ee7f4bbce278fe25f93fbda196fa
-- 
2.39.2

