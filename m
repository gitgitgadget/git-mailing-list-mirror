Received: from avasout-ptp-004.plus.net (avasout-ptp-004.plus.net [84.93.230.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0CD2B2DA
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 00:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758846136; cv=none; b=sWROAj+MosCBiqRegmMkYhq7+/LOJpdTjxGc/sAQeaVtKDI9LvicIh8BClLTbxJQOYJBMNMFk7MpnfceP0YsSEqJ/YeE2bN39HDG0m44ugJzIiPyNkMX/3xkzNFkb6bduv6pTGiARZuqh68Ycje58Chvqmb8VqSsKEVokcj151A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758846136; c=relaxed/simple;
	bh=KxHzgFQxYrsWjcGwyMljz5nucph2fVdDXgYpqRfn8eI=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=keQFTfYup7IHHZfs03Nwpv4QUraPMjQlaE2dzFSvaPVWqMWFYzIcMgV6ABLCIdABMyIF0SnU+w5T7O0yF3Yb5+kT0lQXRYtlqHdJT293PLeY2OH0BV6Ss4182RRBzI5QQtg++K66Qg8+8fKzzEiA1U4ftl5D5Wh554wUbs01cBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=pi1SZadL; arc=none smtp.client-ip=84.93.230.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="pi1SZadL"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id 1wDwvu0FI2D8r1wDyvBSP9; Fri, 26 Sep 2025 01:22:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1758846130; bh=/7kVtx4xNGmqhMQ//ifeYQxGi9TCVlCm9FO9qQmzpP8=;
	h=Date:To:Cc:From:Subject;
	b=pi1SZadLXRD6xKEfgbFm4w/pmMmpumizOf2jcXfegOa/dCOY81dQDxOTH8UwjdbNT
	 ZUqbvPNZVfIFDh+FGsYBiVdGgfdxVFJfWxdUhYKL93AImhalnNHeziD5cI9p2ryf30
	 SdGxbUZ/7AFB4LTRCQuubImCQykIrSgyk4silK8M/T2uW+A4OEAlh6eF8zV3ArDtfR
	 DDqhA9hW8+tswF7TOCOKWFs448Uta1yyVpBhlXDw0oLwmsHH9jKRClnPZrHryOT17A
	 2XV5t1uZfYW7ymxHzHADiPCfP9GBAeAhKl1VVllNyhwciAEzHZqzokn4vK+rwLFfNH
	 42T7EEMn882Pw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=beTIU/PB c=1 sm=1 tr=0 ts=68d5dcb2
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=fGnoxqtQ9Yn6lRRlILMA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <2326e1c8-19a3-4454-ab71-0a6cfa8cf8e9@ramsayjones.plus.com>
Date: Fri, 26 Sep 2025 01:22:08 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>,
 Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 1/4] doc: add some missing technical documents
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfPUFhn1H9PhmSztrhQHgKw4h529m14mlGO+nq8Fg4Ab3DC2hABS12egON2RaYXzyzJep74IhB8BUFsV8YNjK7UnwZkf7OtYiO8I8ebou8X/UMBN10avH
 Z98OyLdStLOh0M85Fzk13TbwHBEqSfBh1A49RwFrHIExHYJfplDYvcWLw/Ja0chjQRFTczsW5KP/ZcbdILw6ybTNTclkP0dDgrc=


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 Documentation/Makefile | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 6fb83d0c6e..a3fbd29744 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -119,18 +119,26 @@ TECH_DOCS += ToolsForGit
 TECH_DOCS += technical/bitmap-format
 TECH_DOCS += technical/build-systems
 TECH_DOCS += technical/bundle-uri
+TECH_DOCS += technical/commit-graph
+TECH_DOCS += technical/directory-rename-detection
 TECH_DOCS += technical/hash-function-transition
 TECH_DOCS += technical/long-running-process-protocol
 TECH_DOCS += technical/multi-pack-index
+TECH_DOCS += technical/packfile-uri
 TECH_DOCS += technical/pack-heuristics
 TECH_DOCS += technical/parallel-checkout
 TECH_DOCS += technical/partial-clone
 TECH_DOCS += technical/platform-support
 TECH_DOCS += technical/racy-git
 TECH_DOCS += technical/reftable
+TECH_DOCS += technical/remembering-renames
+TECH_DOCS += technical/repository-version
+TECH_DOCS += technical/rerere
 TECH_DOCS += technical/scalar
 TECH_DOCS += technical/send-pack-pipeline
 TECH_DOCS += technical/shallow
+TECH_DOCS += technical/sparse-checkout
+TECH_DOCS += technical/sparse-index
 TECH_DOCS += technical/trivial-merge
 TECH_DOCS += technical/unit-tests
 SP_ARTICLES += $(TECH_DOCS)
-- 
2.51.0
