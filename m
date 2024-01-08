Received: from mout0.freenet.de (mout0.freenet.de [195.4.92.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D282254BC8
	for <git@vger.kernel.org>; Mon,  8 Jan 2024 17:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freenet.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freenet.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freenet.de header.i=@freenet.de header.b="Y+uWi18l"
Received: from [195.4.92.124] (helo=sub5.freenet.de)
	by mout0.freenet.de with esmtpa (ID soekkle@freenet.de) (port 25) (Exim 4.94.2 #2)
	id 1rMtaH-005jYq-6h; Mon, 08 Jan 2024 18:38:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=freenet.de;
	s=mjaymdexmjqk; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LiyIYmi1eHm1bf9DfRc70RWlEB5YQEFkijp/9X8CeDI=; b=Y+uWi18lTPKFhtm3yaU+ZT21qi
	0ieOFYlBzOS77ad411jvoJryzqWiu85fxu7HuYnVJEAOCHZiYP7EcqvdkiaaHgsLln1kSMs9KFWil
	5c3QnkNWL0dsPckkzE2dbPNyqbz0j16fcVK8gMEGTcIi3aoLFvpKHIhHjoTtyqUaXvKyRBDqHsGgG
	fAC/GFqp0oI7O0UuaCCpal4AJ95elkT8SlGZWM4ehOYAFGiSgO+1Rj3LTHOZtWx6TNFK9HQuubBnJ
	yzkD/TPYsrVwAkxjktFAinnMXEcj4SL0gTFOgSZ7bj2zGS/rnDJ+DxF0x2/yp8igEmKozD05ONt7m
	d0yP58TQ==;
Received: from p200300e2e7033900dacb8afffee0ca63.dip0.t-ipconnect.de ([2003:e2:e703:3900:dacb:8aff:fee0:ca63]:60190 helo=soren-pc.lan)
	by sub5.freenet.de with esmtpsa (ID soekkle@freenet.de) (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (port 465) (Exim 4.94.2 #2)
	id 1rMtaG-004xah-U0; Mon, 08 Jan 2024 18:38:44 +0100
From: =?UTF-8?q?S=C3=B6ren=20Krecker?= <soekkle@freenet.de>
To: git@vger.kernel.org
Cc: sunshine@sunshineco.com,
	j6t@kdbg.org,
	=?UTF-8?q?S=C3=B6ren=20Krecker?= <soekkle@freenet.de>
Subject: [PATCH v6 0/1] mingw: give more details about unsafe directory's
Date: Mon,  8 Jan 2024 18:38:36 +0100
Message-Id: <20240108173837.20480-1-soekkle@freenet.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <de9cf40a-1ad6-45fb-8b70-8b0c71a3bfbb@kdbg.org>
References: <de9cf40a-1ad6-45fb-8b70-8b0c71a3bfbb@kdbg.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-FN-MUUID: 17047355240AE0D8EF36BCO
X-Originated-At: 2003:e2:e703:3900:dacb:8aff:fee0:ca63!60190
X-Scan-TS: Mon, 08 Jan 2024 18:38:44 +0100

I have processed the points raised.


Sören Krecker (1):
  mingw: give more details about unsafe directory's ownership

 compat/mingw.c | 70 ++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 57 insertions(+), 13 deletions(-)


base-commit: e79552d19784ee7f4bbce278fe25f93fbda196fa
-- 
2.39.2

