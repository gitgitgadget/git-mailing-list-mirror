Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93107C0B1
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 15:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710258966; cv=none; b=i1iqmBHbiIQy4crqAbFBb0vN5b0ZXc5qiIPlDIYASN2hL6oKeAhSzRINud4M/8PVoMwXgMbk7/ylFdTmmM/WDXtWNOqjf/wyFjFzl33uIKlRgh/KmE61VrtmDEF0MUhxrp1SBWmuL2SEQgYas1zFmX0s6lo1iOJY7h7B1ZzCfc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710258966; c=relaxed/simple;
	bh=29KcRF33IxbK5MZxSNgIpqgLPw+6y2SKM7jHbfEHqMM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dTbJoKU0wazc6CZ29XvdtdfWWKf2iG87Tcna8Nh0W3ggZhSUzZuiZyTORiCWmQLHLV+6jPUJPeB2pl2nnb1bhWHjdaQbFGwvQmkr0Nv2we2o9nF1ave/60avqx6kWJAR/xE8mvddBYbx9fupPkzjevFN1hmMV6j3Nd1G4Ey6B14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=OOrJP4wM; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="OOrJP4wM"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710258955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+WJlvNU/UzRZUIYPMfAJI7eINsbaYYpMABdpOQ5bnHc=;
	b=OOrJP4wMFx2Gy2Bcu4TxJbx/mWe43Q+iSx86OnX/s0MAFrMgIyFCe0/1oVwkSL0avWcWkI
	4zhFPDedSvMmzxcQPAfNJscTXnaOnctxhASVqb+6Zg1nA3sxJbHshGZJ5KtZf2GJyeeKw2
	tPDp6ZDkCcJ1kPSBQ9prpa7VaBypUvRRjTuV3pHEWjV1EtNbqCXD96x0MTBSXETEa+f/Cj
	41OzECKyd6trxodJEBWbbk4ZEGstHRhwl9kqoj78t63N26z8/yqmiTxTtPyoRBcwHFu1Ye
	/BPjyRMfQlqrWkM6yg/iGDUUQQJTvMLs0v1AAoh6Comjx83MvODr0NGHeStNhA==
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	rsbecker@nexbridge.com,
	github@seichter.de
Subject: [PATCH 2/3] config.txt: perform some minor reformatting
Date: Tue, 12 Mar 2024 16:55:45 +0100
Message-Id: <d50c0f22c41ec36b574e1ff67e68485d9a6f2a84.1710258538.git.dsimic@manjaro.org>
In-Reply-To: <cover.1710258538.git.dsimic@manjaro.org>
References: <cover.1710258538.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Reformat a few lines a bit, to utilize the available horizontal space better.
There are no changes to the actual contents of the documentation.

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 Documentation/config.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 4480bb44203b..2fc4a52d8d76 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -58,11 +58,11 @@ compared case sensitively. These subsection names follow the same
 restrictions as section names.
 
 All the other lines (and the remainder of the line after the section
-header) are recognized as setting variables, in the form
-'name = value' (or just 'name', which is a short-hand to say that
-the variable is the boolean "true").
-The variable names are case-insensitive, allow only alphanumeric characters
-and `-`, and must start with an alphabetic character.
+header) are recognized as setting variables, in the form 'name = value'
+(or just 'name', which is a short-hand to say that the variable is the
+boolean "true").  The variable names are case-insensitive, allow only
+alphanumeric characters and `-`, and must start with an alphabetic
+character.
 
 A line that defines a value can be continued to the next line by
 ending it with a `\`; the backslash and the end-of-line are stripped.
