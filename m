Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Greylist: delayed 471 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 25 Nov 2023 01:53:25 PST
Received: from outbound.soverin.net (outbound.soverin.net [IPv6:2a10:de80:1:4091:b9e9:2212:0:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB38F10D8
	for <git@vger.kernel.org>; Sat, 25 Nov 2023 01:53:25 -0800 (PST)
Received: from smtp.freedom.nl (c04cst-smtp-frd01.int.sover.in [10.10.4.107])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by outbound.soverin.net (Postfix) with ESMTPS id 4Scn5m1YmFzvV;
	Sat, 25 Nov 2023 09:45:32 +0000 (UTC)
Received: from smtp.freedom.nl (smtp.freedom.nl [10.10.4.107]) by freedom.nl (Postfix) with ESMTPSA id 4Scn5m0BB9z1g;
	Sat, 25 Nov 2023 09:45:32 +0000 (UTC)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=freedom.nl;
	s=default; t=1700905532;
	h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:in-reply-to:
	 references; bh=QdBv7exknrqdKiL5+4t0lzwhsEj7HWkJ1DP1pXULHJk=;
	b=UWOLC42WvIrD9G/XY5qDOd7Z399SR0mburcHRWb6LM7AsN59yOuHApdVX+f2A4bbIdu8Jz
	lEDkW7OQ5V02dvuYWc+t8fpJ6r17TzP4koOx8s1frJ5f4OCk4OOGRRmYPgnkNLK81mm8yt
	ZyaqXmeX8AxyJ49Y1MwHgSw77mT3q5Q=
ARC-Seal: i=1; s=default; d=freedom.nl; t=1700905532; a=rsa-sha256;
	cv=none;
	b=sBQIiO+hIW2um2yrFUjDsNos7EEd7aM5TTKCFcy697nNYRoooTR9vO7bHyYr7rINcfa8wZ
	g1hiu37lUenU+xss0gemJALJbAbAt1ZtWGQjgUp7AEqmUkCSTg/HWJDQYKo36/XCxfQu/2
	76E2r/X4dthLjc+CdaLo9vnh6IKbMh8=
ARC-Authentication-Results: i=1;
	smtp.freedom.nl;
	auth=pass smtp.mailfrom=merijn@tux.freedom.nl
Received: by tux (Postfix, from userid 203)
	id EBA3C8CACD8CC; Sat, 25 Nov 2023 10:45:31 +0100 (CET)
X-Soverin-Authenticated: true
From: "H.Merijn Brand - Tux" <linux@tux.freedom.nl>
To: git@vger.kernel.org
Cc: "H.Merijn Brand - Tux" <linux@tux.freedom.nl>
Subject: [PATCH 0/1] git-send-email causes failures because of wrong option specifications
Date: Sat, 25 Nov 2023 10:44:28 +0100
Message-ID: <20231125094429.12025-1-linux@tux.freedom.nl>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

*** BLURB HERE ***

H.Merijn Brand - Tux (1):
  git-send-email causes failures because of wrong option specifications

 git-send-email.perl | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

-- 
2.43.0

