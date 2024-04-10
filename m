Received: from mail02.ukr.de (mail02.ukr.de [193.175.194.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3137413CAB4
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 07:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.194.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712734075; cv=none; b=oYUU+Q+4FHiaZgAcwXk8vZeMbkwRu+ID+gSNnmncS0O9WCkDVpt2qO+czaEJrQ+GnfThPSizoMYZKYaGjPrsxRD6PKu4FXkKYXfQTO3DDyLvGzV1tAmpwYjkfbS6VlFLlXbe9ZkISD6E/JBbgkBxkKiV2hr4ug1SbqoOi54eHDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712734075; c=relaxed/simple;
	bh=pnOElpbaiOkKczrRh4MxZSYOc4Bo5mDaBFPc4jXJK7k=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=TAqO+gC2fSwlQG03JA3JiKpOKFTzZ0m7x2csBoztfdh9a3DEmGfVa4dj71lH+GoA5bbWZ6fAbSiwmskfqaobReJ7QTiJbcYm/W/64Vkyy7BuclBVghi51v02ZUtFS6fTIWgcbAZdTQmdlluJEszDaGJwsZ4vfu77JQQbQA76L0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ukr.de; spf=pass smtp.mailfrom=ukr.de; arc=none smtp.client-ip=193.175.194.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ukr.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ukr.de
X-CSE-ConnectionGUID: dC+6TydgQpebvqmjGBbp+g==
X-CSE-MsgGUID: vgIW7sXTSR6TWSPSyPquqw==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="732415"
X-IronPort-AV: E=Sophos;i="6.07,190,1708383600"; 
   d="scan'208";a="732415"
Received: from unknown (HELO ukr-excmb02.ukr.local) ([172.24.6.62])
  by dmz-infcsg02.ukr.dmz with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 09:27:50 +0200
Received: from ukr-excmb03.ukr.local (172.24.6.63) by ukr-excmb02.ukr.local
 (172.24.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.37; Wed, 10 Apr
 2024 09:27:49 +0200
Received: from ukr-excmb03.ukr.local ([fe80::1cb4:6e0c:6da4:a8a0]) by
 ukr-excmb03.ukr.local ([fe80::1cb4:6e0c:6da4:a8a0%4]) with mapi id
 15.01.2507.037; Wed, 10 Apr 2024 09:27:49 +0200
From: "Windl, Ulrich" <u.windl@ukr.de>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: "git stash pop -k"
Thread-Topic: "git stash pop -k"
Thread-Index: AdqLGIyhCb+MJtn9TiGgQehp7jLEoQ==
Date: Wed, 10 Apr 2024 07:27:49 +0000
Message-ID: <7192686e00724d5eb4991887c11089b5@ukr.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

KFRoaXMgaXMgYSByZXNlbmQgZnJvbSAyMDI0LTAyLTAxIGFuZCBmcm9tIHRvZGF5KQ0KSGkhDQoN
ClVzaW5nIGdpdC0yLjI2LjIgKHByb2JhYmx5IHF1aXRlIG9sZCksIEkgZnJlcXVlbnRseSBkbzoN
Cg0KZ2l0IGFkZCDigJNpbnRlcmFjdGl2ZQ0KZ2l0IHN0YXNoIC1rDQojIHRlc3Qgd2hldGhlciB0
aGUgc3RhZ2VzIHN0dWZmIGxvb2tzIE9LDQpnaXQgY29tbWl0DQpnaXQgc3Rhc2ggcG9wDQojIHNv
bWV0aW1lcyBJ4oCZbSBnZXR0aW5nIGNvbmZsaWN0IHMgdG8gcmVzb2x2ZSBpbiBzb21lIGZpbGVz
DQojLi4uY29udGludWUgd29ya+KApg0KZ2l0IGFkZCDigJNpbnRlcmFjdGl2ZQ0KZ2l0IGNvbW1p
dA0KDQpVbmZvcnR1bmF0ZWx5IEkgbWFueSBjYXNlcyBJIG92ZXJsb29rZWQgdGhhdCDigJxnaXQg
c3Rhc2ggcG9w4oCdIGRvZXMgY2hhbmdlIHRoZSBpbmRleCAoaS5lLjogaXQgZG9lcyDigJxnaXQg
YWRk4oCdIGZvciBzb21lIGZpbGVzKS4NCkkgZG91YnQgd2hldGhlciB0aGlzIGlzIHVzZWZ1bCBh
dCBhbGwsIGFuZCBzcGVjaWZpY2FsbHkgSSB3b25kZXIgd2h5IEkgY2Fubm90IHVzZSBvcHRpb24g
LWsgZm9yIOKAnGdpdCBzdGFzaCBwb3DigJ0gdG8ga2VlcCB0aGUgaW5kZXgsIHRvby4NCg0KU2Vl
IGFsc28gaHR0cHM6Ly9zdGFja292ZXJmbG93LmNvbS9xLzYzODQzNTUyLzY2MDc0OTcNCg0KU28g
SeKAmW0gc3VnZ2VzdGluZyBhIG5ldyBmZWF0dXJlIPCfmIkNCg0KS2luZCByZWdhcmRzLA0KVWxy
aWNoDQoNCg==
