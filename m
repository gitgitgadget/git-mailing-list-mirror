Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4584C330641
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 18:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781117534; cv=none; b=YOfYtvcbIW910oq0eBMax7jE3x6bZY3O15zga4b1fsEaLseKA6JEijy7Ta28ERRGdAUibvtovotdrVc+nEv+QIgm68kw601yPUG2k5EzkL6WIc2BFv6CJZnoEUjyc3cmWDI1QMtLuY+alyevY4S1SYGdMQcmsA2OKtJdvauc7/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781117534; c=relaxed/simple;
	bh=o76T4ptEL8G53rpKZzsiHg9sap+b6kb7p1QTpLbj+tE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EmOqcHe/ZvmSDIC/+xVbtboGBZ8E/j6gQqm1EW+BXTyMryynCP0Am84yIU1fmui80wUShhROXj4ZHy+hIGlwZVlVrafJg0wKRmHl4RP8hQWZUzT3wE32HHorE/Kt7NJkQsx4dmBRDkfSm+FskFitrMzGXfdX5xhsCBstFsgK7Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=d0fdAIdk; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="d0fdAIdk"
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 65AIq22J012519-65AIq22L012519
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 21:52:02 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1wXO1y-00EeLd-3E
	for git@vger.kernel.org;
	Wed, 10 Jun 2026 21:52:02 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 10 Jun
 2026 21:52:01 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 5b04377f;
	Wed, 10 Jun 2026 18:52:01 +0000 (UTC)
From: Tuomas Ahola <taahol@utu.fi>
To: <git@vger.kernel.org>
CC: Tuomas Ahola <taahol@utu.fi>
Subject: [PATCH 2/3] doc: config/sideband: fix typo in adoc markup
Date: Wed, 10 Jun 2026 21:51:47 +0300
Message-ID: <20260610185148.23920-3-taahol@utu.fi>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260610185148.23920-1-taahol@utu.fi>
References: <20260610185148.23920-1-taahol@utu.fi>
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
 BxoPSFhIWkhZXEhZW1hGWltaRlpYX0ZcX0hQSFhIWEhZSFhIWEhYSFlRSA8BHCgeDw0aRgMNGgYNBEYHGg9IWA==
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:references:mime-version:content-type;
 bh=eKZniczrb0cL5rJHYIYG0aQvgQOZRVIbqxOv6fLs2Fo=;
 b=d0fdAIdkeE/rqQIcGlIsHWkq7FrcOCfyAYWinHpkgRpy3L++HaVCoDPMDmO6wHbuuH2/Ej4ytt46
	1x2M/8LHTN0Q2FQ7QpRKlqjZfTTSxp177VVyj+Gxb0g5mrAjFl7MAIzlz2eDte3MrgWFE7eD6onl
	DZ+Trl/0hka3ZvECSQZ95x++NmHJ1o9fIouvrLex7zuyMIEZTqkoptXpySP1GWR7GsEX0X18dskh
	KADVmP3O4Nd3+fkEoL3LnIjXufts5DSyAqTDVGvQo+/+uUu9bceaqylaqpxCGNyZy9bDYACr/4Py
	k32HQb7dKFOYNhIADVG11AIvLBPE+dWel9APfQ==

Fix a simple typo in AsciiDoc markup.

Signed-off-by: Tuomas Ahola <taahol@utu.fi>
---
 Documentation/config/sideband.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config/sideband.adoc b/Documentation/config/sideband.adoc
index 96fade7f5f..06de0d5c07 100644
--- a/Documentation/config/sideband.adoc
+++ b/Documentation/config/sideband.adoc
@@ -9,7 +9,7 @@ sideband.allowControlCharacters::
 	`color`::
 		Allow ANSI color sequences, line feeds and horizontal tabs,
 		but mask all other control characters. This is the default.
-	`cursor:`:
+	`cursor`::
 		Allow control sequences that move the cursor. This is
 		disabled by default.
 	`erase`::
-- 
2.30.2

