Received: from mout3.freenet.de (mout3.freenet.de [195.4.92.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C986FA7
	for <git@vger.kernel.org>; Sat,  6 Jan 2024 11:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freenet.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freenet.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freenet.de header.i=@freenet.de header.b="PHmeGXwZ"
Received: from [195.4.92.119] (helo=sub0.freenet.de)
	by mout3.freenet.de with esmtpa (ID soekkle@freenet.de) (port 25) (Exim 4.94.2 #2)
	id 1rM4rk-0092K7-LS; Sat, 06 Jan 2024 12:29:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=freenet.de;
	s=mjaymdexmjqk; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=K0mpjiWZqO9j0NOXkhJOuKMlW15bUJy6HLQiIQpPEog=; b=PHmeGXwZqJJa6TD+eS5ojPhgfD
	y1QHedxVzsYzIWsAlJUCwa09YWDkGxV8FSJuQQyO1LF5wvKPF7QUNGCujNyXmR0abECls+mWX4s6G
	tGdLQbG1DRzbw8d0v6wwW2iHQQPo4y2ZDN07ti8X02tas6bQ/6bf5qJMau4ZByBaPXVe4SQR/jQuY
	qw0mTIBLIh7nPHU1/aZHocgyf0RubPcTa7z+UqEr5umdxgAZ/E07rLEyMHPzxhcvokV5khTxB5kus
	Lz14NM5vW2F4E+NcC2foNwka4MODqB7TCkye8Y8x13zUWggixr9UfIYAiF01NIRLgvYAISxwrrjWd
	Wc1rXneg==;
Received: from p200300e2e7033900dacb8afffee0ca63.dip0.t-ipconnect.de ([2003:e2:e703:3900:dacb:8aff:fee0:ca63]:53218 helo=soren-pc.lan)
	by sub0.freenet.de with esmtpsa (ID soekkle@freenet.de) (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (port 465) (Exim 4.94.2 #2)
	id 1rM4rk-007k57-CI; Sat, 06 Jan 2024 12:29:24 +0100
From: =?UTF-8?q?S=C3=B6ren=20Krecker?= <soekkle@freenet.de>
To: git@vger.kernel.org
Cc: sunshine@sunshineco.com,
	=?UTF-8?q?S=C3=B6ren=20Krecker?= <soekkle@freenet.de>
Subject: [PATCH v6 0/1] mingw: give more details about unsafe directory's ownership
Date: Sat,  6 Jan 2024 12:29:16 +0100
Message-Id: <20240106112917.1870-1-soekkle@freenet.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <xmqqbka07te6.fsf@gitster.g>
References: <xmqqbka07te6.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-FN-MUUID: 17045405644BE5026765E6O
X-Originated-At: 2003:e2:e703:3900:dacb:8aff:fee0:ca63!53218
X-Scan-TS: Sat, 06 Jan 2024 12:29:24 +0100

So I change the commit message and the title of this commit.

Thanks for your feedback.

Sören Krecker (1):
  mingw: give more details about unsafe directory's ownership

 compat/mingw.c | 64 ++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 51 insertions(+), 13 deletions(-)


base-commit: e79552d19784ee7f4bbce278fe25f93fbda196fa
-- 
2.39.2

