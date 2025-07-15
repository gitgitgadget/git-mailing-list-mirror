Received: from avasout-peh-001.plus.net (avasout-peh-001.plus.net [212.159.14.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2823F1B4F1F
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 23:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752622421; cv=none; b=toXU4VgGJ77wcyN7ft5OBmEV9tS6kDHVBnDH6JjnfYnLcQAqs29JczuK1I5c0e/sRMyBxXJu4Z3YoaWsyieBwSc1Y+xTBVOXNnd2WPWTmvr6crN8JJVv9fONG8IHw+OLhBN0yUz6p6PLrnrHTRJGiQcNJ+VJ22YcovE4Vy7hrZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752622421; c=relaxed/simple;
	bh=eEbFADVVtnChtM79ShqVcDn6jguxmQ0zLar2OoiXGsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jk069uOWMiTwg4oenZkywMBWev6sYtAwlGJGBYAwIOOIvWS/GAYMrqgEuYq8Bjh/OkBESs9GIWj/AA+F/MeYKHkJDYvGQvjvSR7NEDR4+8DvKXfX7QjK0GNl6plEgcRGr05RyjPiqZ4qB0MNqrY2KkKcKCKNn6wK2gsVo8Ifbas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=IXktEHtU; arc=none smtp.client-ip=212.159.14.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="IXktEHtU"
Received: from satellite-LM22 ([80.189.83.109])
	by smtp with ESMTPA
	id bp8quChur7HMwbp9VuU8yh; Wed, 16 Jul 2025 00:33:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1752622417; bh=qVW2Gdvj2u4TXauiF/wFl5C7bcQZ3iwcokrMopRHsjU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IXktEHtUeyyUrJPmBC2+LQQKMZErXCM062iyDUtkrE1SERcWEZre4HqY+NQqV4N9V
	 YGKFQ0VhnaFGMSVJJ/1I7i2jcR42kQ3B14JOyggusoftNpWvlLzv5mRsJbIrOYgI9V
	 GB60lcFCpVMzoBi9otI3BU23lk3iqh5GDtvyg4ZA+pGJJfXeVZtnsvEK5iUREs9WJQ
	 8eYjoYqvFcw57s2RFnCuq31O4E1ANzn8lZ8EM2rlcE2XAJQOaLDsYdQW7Jf5mgcdgZ
	 UFLfmC0dXEi68F0q/Qy7wPrCHu+qxtNJslBV8rYLrN4pbYMPvRQnqRf+9Dr+MZ7/CQ
	 wuuPkERlOifMA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=ZNB0mm7b c=1 sm=1 tr=0 ts=6876e551
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17 a=EBOSESyhAAAA:8
 a=RfHw5oRSbKQckNLaYboA:9 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	irecca.kun@gmail.com,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 2/2] po/meson.build: add missing 'ga' language code
Date: Wed, 16 Jul 2025 00:32:39 +0100
Message-ID: <20250715233239.1539780-3-ramsay@ramsayjones.plus.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250715233239.1539780-1-ramsay@ramsayjones.plus.com>
References: <f614e1c8-91a9-4430-9d60-5aca05170b4a@ramsayjones.plus.com>
 <20250715233239.1539780-1-ramsay@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfBqP20AcFc9vgn7RedFo7eeDkJgHBdjgmQKgcwGI0b5bMiJ+l6H+3zAvzM+LrY7QWHVVwum5FhgTewqw5nZabUYb7qG/lxc2PFag+BK8Mp4MzRoZvT1A
 9ZJZbcT7Fuhy1nI9eZb/8NOwg8KTAon01b0+qZ30EYdpjpWgQ5OoayIT+fU4W1ppcf8b5vZvWl/VPT5RaVcntVgSIN4xxC3EHTM=

Commit bf5ce434db ("l10n: Add full Irish translation (ga.po)", 2025-05-16)
added a new translation to git. In a make build, new 'po' files (ga.po
in this case) are added to the build automatically using a wildcard
pattern. In a meson build you have to add the language code ('ga') to a
list explicitly to have it included in the build. In order to include the
new translation in the meson build, add the 'ga' language code to the
list of translations in the 'po/meson.build' file.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 po/meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/po/meson.build b/po/meson.build
index d7154b6395..de3b4e2c38 100644
--- a/po/meson.build
+++ b/po/meson.build
@@ -8,6 +8,7 @@ translations = i18n.gettext('git',
     'el',
     'es',
     'fr',
+    'ga',
     'id',
     'is',
     'it',
-- 
2.50.0

