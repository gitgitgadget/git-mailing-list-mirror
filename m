Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE3A6FBF
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 06:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711001176; cv=none; b=XYI/fL9caYjfobcHyANDMmQIb2o9JruEaEG3P+jL3Vb+AwIp/0k9Lz//qrIKMzJ+Q5JxzCPWXUr7vr/zIZqaikZLwh58pIiF/H/aWSed/YR+/5rquQoZkOOHPOgT4BkjmJTmYRZLHrNu5WfvQvZPOfuGRS6x9YRIHlpZYGtdObM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711001176; c=relaxed/simple;
	bh=PbPk3NIMzhXiXJyVumbNcXJRGAfseVYC20zykUn6q6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R7r6szam7xxyJcN0iTvhUnjNTGmZGAkzd7u1MVZ36wYPNSvFmsZxWfz02uQTC3fLklpQbx3LzBP5g6Hr9CM+sB/SflHM9yxsybJDMX0Tu7uYBNmGFHsP1x5zNHyvtcsAQVEbrbY6D3dr7v2ooNbNZ4Yqe1v7VX6akbL7YyembOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=doBLsCQ0; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="doBLsCQ0"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1711001171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z/LBknPH1gaLtWwQGAzbT3Yk44YXNyWf55DbrqK7VoE=;
	b=doBLsCQ0FCrG5YK+MOZHQFo+N2U+kcZMv9UbCigwynSEylwIiGEROuXLfn5UBLRBXgRSAn
	IHRibnGT4lHWRcWo+SFhz3EEW7TMqfjPzYM5zCxdJbvo11cQYLxCMpo0eFBxTU5hcUcZNU
	CFaKPOwlJ5gJLzODFfQEE7Ir7fqnAJTsjD3QS9sJxj8AHPrT9UQAbWc7EdcEZg4wuGLj3b
	w+iCq2oxO4tUx8rzOij79BCYa69q1EEBOhHJfoMJv/1xRMrjf7d8Gghw+nRpVjONMGIxah
	BnoyCcnTzRD2q2mCMGc14HoaihRDF7+qDunRUF2PyF40ho48KbZyHFFQoxjzCg==
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	rsbecker@nexbridge.com,
	github@seichter.de,
	sunshine@sunshineco.com
Subject: [PATCH v5 1/4] config: minor addition of whitespace
Date: Thu, 21 Mar 2024 07:06:05 +0100
Message-Id: <dda81fedd9f38cb57658f1343f803a339c9116e3.1711001016.git.dsimic@manjaro.org>
In-Reply-To: <cover.1711001016.git.dsimic@manjaro.org>
References: <cover.1711001016.git.dsimic@manjaro.org>
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
    Changes in v5:
        - No changes were introduced
    
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
