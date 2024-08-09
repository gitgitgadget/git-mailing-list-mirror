Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D18639851
	for <git@vger.kernel.org>; Fri,  9 Aug 2024 17:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723223633; cv=none; b=pl0WjsDdKJRpNHVtbZ4vFy9kWP51DTPDee7j8kSuTrI9eFE4sQ21SetFlGdmFHTYhs1hjYZ6q/RHFQzjQovXMjx0XNtHeOEFx0h9SrLd7HYatfoTrYWUvU6lveO0XcIe9DpNrAbCTj1d/iC7wdpYLFcWSw04KuWkLbPB5x8rPg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723223633; c=relaxed/simple;
	bh=mH6HgE4rETkx0np2sgWlTP5k8wFk2R52vdmPYn0zyGM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qa+U+OA818j7qjpjDM+zF71SoHucXCgD4t6FSIHpmzwAv+m90nMMTwnRg7ShWE70i6SYz86gL3mdg7r2dK9ywnCNAxBBwRPRmpSXecjTmBrEuL8PXqSZjX3sISUchQ1EmYBbHBQWntLtxKm4uZXONFzKBbQqG8dD+3aa+iT1wqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=jAiPT6pO; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jAiPT6pO"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1DFE02D19A;
	Fri,  9 Aug 2024 13:13:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=m
	H6HgE4rETkx0np2sgWlTP5k8wFk2R52vdmPYn0zyGM=; b=jAiPT6pO4Ir+TaHOx
	3TXLsPP4qw4jobXCA5TAGbSUb6+0hnnUCaCW3FM48hF95sAybfk5ga7JnaiLPRzM
	LMc8ola6mjYQNNaS0JtraQrAX6T/XS0jmxCT5vpK9wl57tkh17JnIoc08hDPO0rt
	O+UiSG1A7wRuu/tlmbxLA8g9Q4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 16D572D199;
	Fri,  9 Aug 2024 13:13:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7C8D92D198;
	Fri,  9 Aug 2024 13:13:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: furkanakkurt9285@gmail.com
Subject: [PATCH] tutorial: grammofix
Date: Fri, 09 Aug 2024 10:13:49 -0700
Message-ID: <xmqqjzgpei0i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BF2A4EAE-5672-11EF-A0F5-9B0F950A682E-77302942!pb-smtp2.pobox.com

We say "these", so "range notations" must be plural.

Reported-by: Furkan Akkurt
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Resurrected from a pull request to a preformatted manual pages
   repository at https://github.com/gitster/git-manpages

 Documentation/gittutorial.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gittutorial.txt b/Documentation/gittutorial.txt
index 0e0b863105..8b5b15ce05 100644
--- a/Documentation/gittutorial.txt
+++ b/Documentation/gittutorial.txt
@@ -361,7 +361,7 @@ $ gitk HEAD...FETCH_HEAD
 This means "show everything that is reachable from either one, but
 exclude anything that is reachable from both of them".
 
-Please note that these range notation can be used with both gitk
+Please note that these range notations can be used with both gitk
 and "git log".
 
 After inspecting what Bob did, if there is nothing urgent, Alice may
-- 
2.46.0-316-ga5b7e061b1

