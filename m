Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81C123AB
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 00:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723593926; cv=none; b=Kc3n15qy9FmrvW1wT+lFZcAy8eFCrvNGtNdg34EDrkMzQJHiuEecu0WOqVAosl53roZ71951p0DKSSxPY+RB1QQrqDbN/Ce0FleuV91Tf8IlmejMmjhB4H0WdhA/3QrUPEGVJ5VuTTGK2AywfC4FoSm7sYFStdn4z11w2Cceu1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723593926; c=relaxed/simple;
	bh=6G2Nar8266I1nPjyXGZYpAgoHSjw5NrWtTfj/oPk/QY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eiwvgQz3/ArsF3lcGiED71Gfq+iQfbpMDGdf/MnJGrMNIwdvsMoZUbLfxci2ZFchFv5htmHqWkQ9aZJ6Bk0PM08a49ozwuTlIZnvaq6nEFC8fv7L0iIRqhywR7t4XvPLt3RpZoOCEue3nzNr+xgpq8Y6lwRLmmWXyxdqkP9dslo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=STMGXgGB; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="STMGXgGB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723593924; x=1755129924;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=6G2Nar8266I1nPjyXGZYpAgoHSjw5NrWtTfj/oPk/QY=;
  b=STMGXgGByxLLT6R8wzqApkOewbiDToPqcEsIo05hfTfQGvdJt/y9d/z1
   JpfYqXwV5C+2X9Lp7n0y2hvCHsMXExsSSf8tiZDd9X1BlHdL8rCJnYje8
   3jJG7xj9XbYbu2s4F49tVai4KqnOS27W3d0T6i+qIZrcr65Nb92gwp9N6
   8qmCCRI6QS7ObnP7fYKo16twWRGF6NrIjXgcVOQeL/BLsUVM+X3/XByod
   ouU+mhWKyVNM0t1ei4nXKTnGa5XjMhm0ST2w9/VK0z4vCFdjlvARHCvci
   pXnEUFKjKOfwmULLzu1luJrvO70c3R+85f/zLLC7JlndiQdBXtNJ91Jbr
   A==;
X-CSE-ConnectionGUID: Pz0kfjUgQfOE3zRJeHiCww==
X-CSE-MsgGUID: sYTYpVHfR2mDIBkBntRfRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="32933071"
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="32933071"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 17:05:18 -0700
X-CSE-ConnectionGUID: SpbRQBKBTPOrfKl0h6Uhcw==
X-CSE-MsgGUID: cSb+Rh8OQ5Slimhb3/9DvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="63767465"
Received: from jekeller-desk.amr.corp.intel.com (HELO localhost.localdomain) ([10.166.241.1])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 17:05:18 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 13 Aug 2024 17:05:10 -0700
Subject: [PATCH v2 2/3] t9001-send-email.sh: update alias list used for
 pine test
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-jk-translate-alias-send-email-v2-2-912db4eb6846@gmail.com>
References: <20240813-jk-translate-alias-send-email-v2-0-912db4eb6846@gmail.com>
In-Reply-To: <20240813-jk-translate-alias-send-email-v2-0-912db4eb6846@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Cc: Jacob Keller <jacob.keller@gmail.com>, 
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>
X-Mailer: b4 0.14.0

From: Jacob Keller <jacob.keller@gmail.com>

The set of aliases used for the pine --dump-aliases test do not
perfectly mesh with the way the pine address book is defined. While
technically all valid, there are some oddities including bob's name
being partially split so that the actual address is returned as
"Bobbyton <bob@example.com". A strict reading of the pine documentation
indicates that the address should either be of the form
"address@domain" or a comma separated list of address, name/address
pairs, or other aliases enclosed by ().

The parsing implementation in git-send-email is not as strict, but it
makes sense to ensure the test data used is. Although the --dump-aliases
test does not make use of the address data, it is helpful to avoid
giving future developers the wrong impression of the file format.

Also add an alias which translates to multiple addresses using the ()
format.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 t/t9001-send-email.sh | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index aa36ace393b7..c96d6955b9f2 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -2093,13 +2093,15 @@ test_dump_aliases '--dump-aliases mailrc format' \
 test_dump_aliases '--dump-aliases pine format' \
 	'pine' \
 	'alice' \
+	'bcgrp' \
 	'bob' \
 	'chloe' \
 	'eve' <<-\EOF
-	alice	Alice W Land	<awol@example.com>
-	eve	Eve	<eve@example.com>
-	bob	Robert	Bobbyton <bob@example.com>
+	alice	Alice W Land	awol@example.com		Friend
+	eve	Eve	eve@example.com
+	bob	Robert Bobbyton	bob@example.com
 	chloe		chloe@example.com
+	bcgrp		(bob, chloe, Other <o@example.com>)
 	EOF
 
 test_dump_aliases '--dump-aliases gnus format' \

-- 
2.46.0.124.g2dc1a81c8933

