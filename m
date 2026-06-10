Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF68C34BA24
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 18:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781117533; cv=none; b=GXq34lMpuxgb1uEXluMirmrRbaEBUkifEx/xGc2ooxhhuYqH58uI1gDXvr270jv8DLoD1wlYHYW1CVRUULXKYYrPC339eNkQRMBOyh5PMCwRypPgivtF4DQavTjDJoth3f4lzcwKInPbCLLXC19ru4JLx/iE75q59PWf2GMc6Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781117533; c=relaxed/simple;
	bh=ufKoTgS+TTLELRPoBAQh0QBdA1++FZbMEOB+tgD7lZk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sr8bM8e8mt0efVPMtZ6RezIlq830CPz5/pgJhLnqxR2dDmCWMMnv6OIHxXzfX0GQp5/bK1jglF4tSnNyhza3eNHY0QbRwYfuPyn4TAQO0FGoaD4nQzUvC+rQEssPxfLbhiRKVLnoLjW635H/icfMrWOEAmCVkqCZsklYozYDEos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=MuCuyKQ9; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="MuCuyKQ9"
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 65AIq2H0012525-65AIq2H2012525
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 21:52:02 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1wXO1y-00EeLg-7Z
	for git@vger.kernel.org;
	Wed, 10 Jun 2026 21:52:02 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 10 Jun
 2026 21:52:01 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 60d1f681;
	Wed, 10 Jun 2026 18:52:01 +0000 (UTC)
From: Tuomas Ahola <taahol@utu.fi>
To: <git@vger.kernel.org>
CC: Tuomas Ahola <taahol@utu.fi>
Subject: [PATCH 3/3] doc: git-config: escape erroneous adoc markup
Date: Wed, 10 Jun 2026 21:51:48 +0300
Message-ID: <20260610185148.23920-4-taahol@utu.fi>
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
 bh=fSAb3Rlp/rwFYblOCxYcLIyVPIplVmUP2qCwSxRWvcU=;
 b=MuCuyKQ9f4gilSRAvG5TzoTyzUf3MW4nMkjDi66YqikTHld2ZDG083UeTvznO32d/I8JkNvcVlob
	pmGQ2HLqf/vhEtSgZFdnGVYl6agcsf5LcPljwNX1vA99raMCwVWiCnFr/0gOUaVezolOTgoRz2xJ
	NkoKtL3A+IvrQAFcQFBIGmyF26finG6S+t55pfB7iATcKaFUxM/GBKTx7oAfJ0+6hWDNKhr5Vgjj
	mr4WX9GgSiGRH6b/TE0NXi18F4ZZlXT3ERnzx2sxnHn27CmDnsgoOZjM0iX/qvhlqbXg8Fo7Y89q
	2HEQcChQJour7unnhI8V7lLxPXRX1AD69GG4Pg==

Paired octothorpes are used in AsciiDoc to mark highlighted text,
<mark> being the equivalent HTML tag.  To use the symbol as a literal
character, it can be escaped with a backslash.

Do so in git-config.adoc.

While at it, tweak the text slightly to make it scan better.

Signed-off-by: Tuomas Ahola <taahol@utu.fi>
---
 Documentation/git-config.adoc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-config.adoc b/Documentation/git-config.adoc
index 8439ce97df..708e88cdeb 100644
--- a/Documentation/git-config.adoc
+++ b/Documentation/git-config.adoc
@@ -119,10 +119,10 @@ OPTIONS
 	Append a comment at the end of new or modified lines.
 +
 If _<message>_ begins with one or more whitespaces followed
-by "#", it is used as-is.  If it begins with "#", a space is
+by "\#", it is used as-is.  If it begins with "#", a space is
 prepended before it is used.  Otherwise, a string " # " (a
 space followed by a hash followed by a space) is prepended
-to it.  And the resulting string is placed immediately after
+to it.  The resulting string is placed immediately after
 the value defined for the variable.  The _<message>_ must
 not contain linefeed characters (no multi-line comments are
 permitted).
-- 
2.30.2

