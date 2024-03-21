Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131ACC2E9
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 04:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710994672; cv=none; b=OFmIuX3candnsW0gyXA0lAyYIWUNf52KxMCCIL91J6fz2PYRIvrDnKiRRDK5N/Oni7XtCd2wAniCAL5cPO3KA0KT7ud+c5fsQzsxWwciDlbA/LMDmYvkRS077JXBRVuO6eaAFYRvyI3gmZQjpwfs6Z2VkB6fDIB4P6XaV0t3Zoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710994672; c=relaxed/simple;
	bh=2387iEFjYLtfrV+FuPOa2v/q7VEXquDS4wkXd8cqiQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BZDbmkLUl6jiU10x0Z9MXiTwtCmdap/FrLF0EOzR552eFYj2SIsYH0X+KSFKWOKUVG38AKkGU9vkfc/vNBFwaXOnkd4IcRL/58NVnj2R7lp9bEwns2IuA3G8K4qN0phTR/FJHmjrMtLmfdMw7qYF2lZSzyDmkzdUNafOQOSjAMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=qhucOqX7; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="qhucOqX7"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710994666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nqkODLrSHJZSSn/bLTpVrU0fyyrIfXXIXZjC1t8Ktkc=;
	b=qhucOqX7LBL32qm0TIgQTtnwaqjrDF7xlztyv10A5wX7SLShrYABbEr92li8NelkHifCee
	WZVEbHAt7tHQGPUBETGiGzmZ8GIK7JOtnx0UaREclV92471u1GY6FaMwnHRqwH+18Il0Pd
	Ob/YbPGW4ePMme0YzHJU4Gj3FqHH/l8r7EpzzaIkK3Bag9uLOh5eefTV3sdx6rkx05Q4Zh
	mGrYtoWgOser2Jxre9pQrPr1RGZzGrm/JyTdM2d7RTC/+bTdiebM6k4aKwuD/vn7LLzfSh
	JbwKJ4pIQ8GBo/a+D1b8bTkIlKcwM1iC9gw8kMsur3K+RZ9lVmLVlETd+GStbQ==
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	rsbecker@nexbridge.com,
	github@seichter.de,
	sunshine@sunshineco.com
Subject: [PATCH v4 1/4] config: minor addition of whitespace
Date: Thu, 21 Mar 2024 05:17:40 +0100
Message-Id: <dda81fedd9f38cb57658f1343f803a339c9116e3.1710994548.git.dsimic@manjaro.org>
In-Reply-To: <cover.1710994548.git.dsimic@manjaro.org>
References: <cover.1710994548.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

In general, binary operators should be enclosed in a pair of leading and
trailing space (SP) characters.  Thus, clean up one spotted expression that
for some reason had a "bunched up" operator.

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---

Notes:
    Changes in v4:
        - Junio responded with "will queue" in v3, [1] but this patch hasn't
          reached the "next" branch yet, so resending it as a reminder
        - No changes were introduced
    
    Changes in v3:
        - Patch description was expanded a tiny bit, to make it more accurate
        - No changes to the source code were introduced
    
    Changes in v2:
        - No changes were introduced
    
    [1] https://lore.kernel.org/git/xmqq5xxhl8gs.fsf@gitster.g/

 config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.c b/config.c
index 3cfeb3d8bd99..a86a20cdf5cb 100644
--- a/config.c
+++ b/config.c
@@ -869,7 +869,7 @@ static char *parse_value(struct config_source *cs)
 			continue;
 		}
 		if (c == '"') {
-			quote = 1-quote;
+			quote = 1 - quote;
 			continue;
 		}
 		strbuf_addch(&cs->value, c);
