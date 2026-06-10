Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51ECE3002D1
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 18:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781117535; cv=none; b=baeKo1LiTgtViHlsCkzEA5hQROsacvgDHBgcxQvmkOA8kzRng1wf3vsGIs/g0Lb2WpZ0rMPaH1RAwF2cgOnX0/6JmGNuGrhLDYhfeDud2zeCcF2bg9E1iYtPjSryC1AUgLTiRXvyZbnjmEElZAS0Y/VMHVSQ38sbtvzLhW9pVK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781117535; c=relaxed/simple;
	bh=nJiWBajZh40ddXuco098amCGM4ZRUQY30GYJXF2GycQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MVt3mCSOg1p0tba9wz6TzrljCrtszTenB01zTme18LkDZ/cGBxS9lnDnAkbQx2TtI04B2tVbdGqdrbNi2KybwmsQkCbyt6LastBgxIE07eCkrCRPf4evOFsPDw0vgqmLTBsP2fYgUIKoTUyLdpeBRyFlNc/neHG6bNjuuLUt3ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=ON3w0fLy; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="ON3w0fLy"
Received: from smtp-03.utu.fi (smtp-03.utu.fi [130.232.207.30])
	by fortymile.utu.fi  with ESMTPS id 65AIq1H9012505-65AIq1HB012505
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 21:52:01 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-03.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1wXO1x-00ECOi-Li
	for git@vger.kernel.org;
	Wed, 10 Jun 2026 21:52:01 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 10 Jun
 2026 21:52:01 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 410f6186;
	Wed, 10 Jun 2026 18:52:01 +0000 (UTC)
From: Tuomas Ahola <taahol@utu.fi>
To: <git@vger.kernel.org>
CC: Tuomas Ahola <taahol@utu.fi>
Subject: [PATCH 0/3] doc: config: fix AsciiDoc glitches
Date: Wed, 10 Jun 2026 21:51:45 +0300
Message-ID: <20260610185148.23920-1-taahol@utu.fi>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ex19-08.utu.fi (130.232.247.48) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhZUUgPARwoHg8NGkYDDRoGDQRG
 BxoPSFhIWkhZXEhZW1hGWltaRlpYX0ZbWEhQSFhIWEhZSFhIWEhYSFlRSA8BHCgeDw0aRgMNGgYNBEYHGg9IWA==
X-FEAS-Client-IP: 130.232.207.30
X-FE-Last-Public-Client-IP: 130.232.207.30
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:mime-version:content-type;
 bh=om++denihhBbGxXVMXcQHlIhU3vbMLH8DS0xjcoFzuo=;
 b=ON3w0fLy6rX5PWk990wsnBUJRBqBTCLIIluB9mWYWT6KVUAdKAp0j/DXFTrKR++rVgKmT+I/YyrU
	v4mQcBMPcWU0f/NzXfiax0aQ3VCGCXdHMujXg7IQQyjtSFZQOJzHIjb2WqUwfe6hxYl/D+vsICni
	KqCrfWa4DwehMAYoQt7aiSzh65F6IcKLHW6lmNvbSi01QdrLhohTeqG9y0ZMnj6cyQeTVPreGXdo
	tWpIm5aBQCWWJDng7cMUqoFa+pKeD6Ih3F2eMj6upckM7u+Wt0BOWpGbKYFkMPMzG1KYULXXYJbL
	6KUQ6wSGDyI1ymvqp5Lqpy4Dr89xm1bbuSCviw==

Fix various markup shortcomings in git-config(1).

Based on 29bd7ed512 (The second batch, 2026-05-12).

Tuomas Ahola (3):
  doc: config: terminate runaway lists
  doc: config/sideband: fix typo in adoc markup
  doc: git-config: escape erroneous adoc markup

 Documentation/config.adoc          | 4 +++-
 Documentation/config/promisor.adoc | 2 ++
 Documentation/config/safe.adoc     | 2 ++
 Documentation/config/sideband.adoc | 2 +-
 Documentation/git-config.adoc      | 6 ++++--
 5 files changed, 12 insertions(+), 4 deletions(-)


base-commit: 29bd7ed5127255713c1ac2f43b7c6f257d7b4594
-- 
2.30.2

