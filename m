Received: from server54-1.web-hosting.com (server54-1.web-hosting.com [198.54.126.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FBF3016E2
	for <git@vger.kernel.org>; Wed, 18 Mar 2026 21:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.126.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773870219; cv=none; b=QnaA5W6fnlehQ60uFuXBpiSFYTZae/0/bkiRA3hi9rrAdNfIzVt8i9I/oXsthejxLTxpv9MyQYdB6BKst+CD2UM4r6VxUXLwYoqnoEpY+4VBZHWj+jKa1QmAgI7/mrxqPgZuxlZo91NJuCRoONzdTrKc7R5bStLRvXS520Bay4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773870219; c=relaxed/simple;
	bh=iSH0fDwtvkGqMllhCKlhOX5fnwZ8bY10BO47/RDh2NA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YCfBNl8GTAgv3tyjmq8fl8GIYbqel31IGsfuEQQSL3axXN5vMgkv//ETTe9Zaz2pVDa3IFgyvFGfwCZS6XqZsOV2ggjPcYsbkCsknwsU8CXwH5IcEc0GaST/GVGhJczCy6K8R6OLRibnk3oSsi4R+7aGQv2bZYqfOLNlld2wXPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gabl.ink; spf=pass smtp.mailfrom=gabl.ink; dkim=pass (2048-bit key) header.d=gabl.ink header.i=@gabl.ink header.b=HCP3TM2S; arc=none smtp.client-ip=198.54.126.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gabl.ink
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gabl.ink
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gabl.ink header.i=@gabl.ink header.b="HCP3TM2S"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gabl.ink;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=GLi6Z1B3ToRNRdMsQ+Y0qHxl2EyWMDtaWpeAVbos1ZQ=; b=HCP3TM2SZX1+zKO3RCL0c++0O2
	RV+OWvXhI+ZuUgvGomfHW4j63DGAXd1FSwLm/MNhdE9B4NOpIwCJWDR0MNG7Kr5acmQnMflEOsAdg
	yz/QBXdMpUALIq81LVSBcfLx3PJfcv8Em+0+MiJYTcV2PX9xX2B7QMGBdK6xz7YytkPESLwUhviBc
	+Qtt3v4bgEtDPpVxCMht8rW8oap3SFFSi9KXSghW2BH33ciZs69sBisA0sAEta7Nd8jy64E5BiwJN
	oneDxV+iY5uh8Qz9T+3zqYfOq2BnqmshVi9jVgy3pNCMUu4ZrNYChyk8xH95ZFV47p59fmuePygTW
	WfjCr9Yw==;
Received: from [69.145.228.41] (port=57228 helo=gabou.search.charter.net)
	by server54.web-hosting.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.1)
	(envelope-from <gabl@gabl.ink>)
	id 1w2y0a-000000059UC-149R;
	Wed, 18 Mar 2026 17:00:52 -0400
From: =?UTF-8?q?Gabriel=20=E2=80=9Cgabldotink=E2=80=9D?= <gabl@gabl.ink>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Gabriel=20=E2=80=9Cgabldotink=E2=80=9D?= <gabl@gabl.ink>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] doc: add missing space on git-config page
Date: Wed, 18 Mar 2026 15:00:19 -0600
Message-ID: <20260318210020.759128-1-gabl@gabl.ink>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server54.web-hosting.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - gabl.ink
X-Get-Message-Sender-Via: server54.web-hosting.com: authenticated_id: gabl@gabl.ink
X-Authenticated-Sender: server54.web-hosting.com: gabl@gabl.ink
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-From-Rewrite: unmodified, already matched

Signed-off-by: Gabriel “gabldotink” <gabl@gabl.ink>
---
 Documentation/git-config.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-config.adoc b/Documentation/git-config.adoc
index 5300dd4..00545b2 100644
--- a/Documentation/git-config.adoc
+++ b/Documentation/git-config.adoc
@@ -221,7 +221,7 @@ Use `--no-value` to unset _<pattern>_.
 +
 Valid `<type>`'s include:
 +
-- 'bool': canonicalize values `true`, `yes`,`on`, and positive
+- 'bool': canonicalize values `true`, `yes`, `on`, and positive
   numbers as "true", and values `false`, `no`, `off` and `0` as
   "false".
 - 'int': canonicalize values as simple decimal numbers. An optional suffix of
-- 
2.53.0

