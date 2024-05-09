Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097F322091
	for <git@vger.kernel.org>; Thu,  9 May 2024 17:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715275933; cv=none; b=cK31qquupptBSBNirPIbyfCw3yKz91VMewyRqnVpCIw44qMIgd1VBVn/wpyw2FFplGhx3fnn77DHuyN9BEP/rqfnNrvjBBZn5pv/NianVLzwGatAd2bFeuB52EJFRxDSZEcs12aBijsQd/5w2QhB5InA3xQYwx7Zh9qYovwHHhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715275933; c=relaxed/simple;
	bh=bg0POJ+0E0GgZoaf/o6V06vOL31VUAWRNQgN+uG80KQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TeuKrUf7zWLhPOzzSnPJZ4sXBPKQ9lrT356tuJlJbFQ3C6s4HCeA5vnj6sVDug+E3aWBsg6Rw9B7P83+5HdXoKMwLDYH5As8nf1+XpaBj2ZrT1nWgt/mc7r3105MXbIB5PLYEKdhjtMLAhyhMMiBbTvbC3fuuvkvWwMysRe+gpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=SyqojlVJ; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SyqojlVJ"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 016E637D2F;
	Thu,  9 May 2024 13:32:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=bg0POJ+0E0GgZoaf/o6V06vOL
	31VUAWRNQgN+uG80KQ=; b=SyqojlVJxej+WSk2iKrUqLVQSCh51x7GLiwnGWRxP
	DPeL7EkZ6WKQKGHQ/bHFyOgz57i+hsxC9T5xYPs1YKHgF8+shaEakuPGDTgBlZyX
	iJl9iu6RCgoLeVJaBzXiDxcxKaK2ulB2H6NCA7T3f97oA856b5PrNFET+XSfm2Uv
	YY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EE42637D2E;
	Thu,  9 May 2024 13:32:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 68B5237D2D;
	Thu,  9 May 2024 13:32:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <avila.jn@gmail.com>
Subject: [PATCH] SubmittingPatches: advertise git-manpages-l10n project a bit
Date: Thu, 09 May 2024 10:32:09 -0700
Message-ID: <xmqqv83muc12.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 10C37754-0E2A-11EF-806B-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

The project takes our AsciiDoc sources of documentation and actively
maintains the translations to various languages.

Let's give them enhanced visibility to help those who want to
volunteer find them.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/SubmittingPatches | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPa=
tches
index c647c7e1b4..ff31049dce 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -548,6 +548,13 @@ repositories.
=20
 Patches to these parts should be based on their trees.
=20
+- The "Git documentation translations" project, led by Jean-No=C3=ABl
+  Avila, translates our documentation pages.  Their work products are
+  maintained separately from this project, not as part of our tree:
+
+	https://github.com/jnavila/git-manpages-l10n/
+
+
 [[patch-flow]]
 =3D=3D An ideal patch flow
=20
--=20
2.45.0-119-g0f3415f1f8

