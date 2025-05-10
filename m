Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8745B42AB4
	for <git@vger.kernel.org>; Sat, 10 May 2025 12:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746880476; cv=none; b=aj7lrH87FRtfgYT6sWeZFI2DsQK2nOXDZlcFVX8izZ0ad8X+pD0/UFMUeWIWNKzY7kwWJiPCljR//ILZ4EBVCyjnO7lPEUeVWHWP4OQQu+2QZyejeRDXrnkQOymcj+TmvLlgCRbIgnzsNcVwuzheH7VziZQBfcESmlDZeCeQ5hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746880476; c=relaxed/simple;
	bh=GVN9bwbU1ebUhj4TSmtSLo9v3+nGHUTsneYoG7UzEW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZajbIJRkYcksVfEWtQ4wI9/+vaFo+0JHic+JtpH9gJ8+NrmmMytaloh/znI+WFEgC+C+btHBlduJkclJ/Y9gMb2zQpwaDs/xx/BjRREiNJ3gOlepltuJK23bpjev/8zTeQJjSSkbIWTANw7m4jd6gF5l+ldpzt3xMzsdM3OvYG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; arc=none smtp.client-ip=212.27.42.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from cayenne.. (unknown [IPv6:2a01:e0a:d1:f360:c2d2:c7d2:a4cd:bda7])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 1D81113F86E;
	Sat, 10 May 2025 14:34:24 +0200 (CEST)
From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH v3 0/4] Additional changes
Date: Sat, 10 May 2025 14:33:13 +0200
Message-ID: <20250510123346.20927-1-jn.avila@free.fr>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250501213414.370514-1-gitster@pobox.com>
References: <20250501213414.370514-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series is just applying additional 'new style' changes on top of the
previous versions. Another patch is added to fix $ENV_VAR vs ENV_VAR misuse.

Jean-Noël Avila (1):
  git-var doc: fix usage of $ENV_VAR vs ENV_VAR

Junio C Hamano (3):
  git-daemon doc: update mark-up of synopsis option descriptions
  git-{var,write-tree} docs: update mark-up of synopsis option
    descriptions
  git-verify-* doc: update mark-up of synopsis option descriptions

 Documentation/git-daemon.adoc        | 181 ++++++++++++++-------------
 Documentation/git-var.adoc           |  46 ++++---
 Documentation/git-verify-commit.adoc |  16 ++-
 Documentation/git-verify-pack.adoc   |  28 ++---
 Documentation/git-verify-tag.adoc    |  16 ++-
 Documentation/git-write-tree.adoc    |  18 +--
 6 files changed, 148 insertions(+), 157 deletions(-)

-- 
2.48.0

