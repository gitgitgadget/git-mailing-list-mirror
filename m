Received: from mail.kubajecminek.cz (mail.kubajecminek.cz [144.91.101.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2D544C63
	for <git@vger.kernel.org>; Sun, 29 Jun 2025 19:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.91.101.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751224075; cv=none; b=fQV4asSvq0Jaiec8VqkmS7pUpmMkTaCYmdOSUdnwdlijxbZlrkqqdV427EOEMfWD8UgJ/rAppl4JYQWa5Aw+LsfbavKJAdPATDpjaGaVgaL9s4swg4hIiz2M+loCIWhGymh0cHiVsCwWbnpSY7607oGShdzp0spmMl1BJp673YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751224075; c=relaxed/simple;
	bh=x4oWpDsofActZGTA7zRGWTuzCcUgHhg5npjFC2bjmec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i0L2/CzEvF04qqy6Mo06urnu48kBQ6P8KAJedP6Yi2KNsEzbUm9EGXEtwgv5KGoZwYSolqxNJnn1u++GtVSWqNHJE70nApfE/0qBi7I/0t1cyZwcWlbBLeK8+O/47e1qw3PFfh0LF3pwk1aac8R1EVXMVOzyTeeAnPpLauQiI5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kubajecminek.cz; spf=pass smtp.mailfrom=kubajecminek.cz; dkim=pass (2048-bit key) header.d=kubajecminek.cz header.i=@kubajecminek.cz header.b=hbVgGyE6; dkim=permerror (0-bit key) header.d=kubajecminek.cz header.i=@kubajecminek.cz header.b=kal1kufo; arc=none smtp.client-ip=144.91.101.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kubajecminek.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kubajecminek.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kubajecminek.cz header.i=@kubajecminek.cz header.b="hbVgGyE6";
	dkim=permerror (0-bit key) header.d=kubajecminek.cz header.i=@kubajecminek.cz header.b="kal1kufo"
DKIM-Signature: v=1; a=rsa-sha256; s=202503r; d=kubajecminek.cz; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1751223943; bh=zQ0Z8cJ/ZsQUf4Xy0i0Eho9
	nx8K+dG8eKsAGRugxwc4=; b=hbVgGyE6SUm0CduNPiNdq04jVm3B6+SiJ9xl4ahb7/PcuT+xfn
	yxSBjwU31pJs7pMFTylNDiMB7ZPjq5L8/o7lWkCrJu2aY5yTX+xWp0GrdfVd0DGpXFc9DHimAd9
	Bs4OmN5TAjkRPm+kHacLnnAnmP2yDnZ5fn8w1wUwOd5awTxmonDkD0tdBWUUnRlSCy8gQbpW6LQ
	Q1Dg3rUxuZnNFfbQt32gBTgpQ8lx0Q/Gs2vBTALNSS4VbZ/lW2GtH4LjPFXeRTStwfuYckF54Ug
	JozzEBYTIIpjNopngR8Zdm/Q2GXkK8N3sAChvxP7Ka1La15ZSfZWlj7kRo2sB1xM1zQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202503e; d=kubajecminek.cz; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1751223943; bh=zQ0Z8cJ/ZsQUf4Xy0i0Eho9
	nx8K+dG8eKsAGRugxwc4=; b=kal1kufolqprEJuZBGitEbDxzPcfnqRjhv9uAgH0lN4ozv/q3j
	VRRWNg7+eJCEzlTELirzMbC7jn3nwd11p7Ag==;
From: =?UTF-8?q?Jakub=20Je=C4=8Dm=C3=ADnek?= <kuba@kubajecminek.cz>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Jakub=20Je=C4=8Dm=C3=ADnek?= <kuba@kubajecminek.cz>
Subject: [PATCH] doc: improve formatting in branch section
Date: Sun, 29 Jun 2025 21:04:45 +0200
Message-ID: <20250629190445.10185-1-kuba@kubajecminek.cz>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The 'branch' section of the git-config documentation was missing
inline code formatting and emphasis for the <name> placeholder.

Both changes improve readability, especially when viewed online.

Signed-off-by: Jakub Ječmínek <kuba@kubajecminek.cz>
---
 Documentation/config/branch.adoc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/branch.adoc b/Documentation/config/branch.adoc
index e35ea7ac64..a4db9fa5c8 100644
--- a/Documentation/config/branch.adoc
+++ b/Documentation/config/branch.adoc
@@ -69,9 +69,9 @@ This option defaults to `never`.
 	`git fetch`) to lookup the default branch for merging. Without
 	this option, `git pull` defaults to merge the first refspec fetched.
 	Specify multiple values to get an octopus merge.
-	If you wish to setup `git pull` so that it merges into <name> from
+	If you wish to setup `git pull` so that it merges into _<name>_ from
 	another branch in the local repository, you can point
-	branch.<name>.merge to the desired branch, and use the relative path
+	`branch.<name>.merge` to the desired branch, and use the relative path
 	setting `.` (a period) for `branch.<name>.remote`.
 
 `branch.<name>.mergeOptions`::
-- 
2.49.0

