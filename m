Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04D81429F
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 20:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706560125; cv=none; b=WOYAQJf8l5YAsd8L9/ovqx/yUMgVPoTy/V5bFIBQIlzFiXINLnZijZSf7j/kswqKKeK+BP5qlGzRTCMESVC3cIPa0N7zekhi1pdQcw3W4pruJpNriEFAuQJt8ti3vwG3wEXclX64sICkfr3qQ/6QThlT7cMRZTlPY+xdfmppnOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706560125; c=relaxed/simple;
	bh=PYcws/UpTgyYq2C0UEuyPg4UmpO0dNWvVnjetIfMkLM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BWNMrFyy2fZsooXiDNHR7CpGC9CS3RlV2yyyGsDc7iMaqBJTv2amRXMa1Uw6jBvhDRf9WnS6YhhCZzIOTERQJLXqxvgzSzCjp39h2BdhHvK3/mGhm5wAQ3dPEO5fTDXzvJUOkcbEQiJgbcLRxPOv7A/QMmDXfBdecwe+2OHzr2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=noVZEKbC; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="noVZEKbC"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 748371D8570;
	Mon, 29 Jan 2024 15:28:42 -0500 (EST)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=PYcws/UpTgyYq2C0UEuyPg4Um
	pO0dNWvVnjetIfMkLM=; b=noVZEKbCSvF1D6W7bbqL4fNzA6QvpaUIIt8xJ8apU
	jk/0Ft/Uz/YiD4DkW3PJLRddDiMp5WMjYiwc82Gu3mtbOCTs7LpWqIqMnoIJORmy
	Lv2eeYIBp3F1R1LZJIQCGosIaKzdYzaOOyLbjccVwAydQ9GFPkFRrEWvJ97aODHc
	aw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 64EE81D856F;
	Mon, 29 Jan 2024 15:28:42 -0500 (EST)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D72711D856E;
	Mon, 29 Jan 2024 15:28:41 -0500 (EST)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 1/3] builtin/worktree: comment style fixes
Date: Mon, 29 Jan 2024 12:28:37 -0800
Message-ID: <20240129202839.2234084-2-gitster@pobox.com>
X-Mailer: git-send-email 2.43.0-440-gb50a608ba2
In-Reply-To: <20240129202839.2234084-1-gitster@pobox.com>
References: <20240129202839.2234084-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 FE09E65A-BEE4-11EE-AFE0-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/worktree.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 6d7da11746..9c76b62b02 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -848,21 +848,21 @@ static int add(int ac, const char **av, const char =
*prefix)
 		const char *s =3D worktree_basename(path, &n);
 		new_branch =3D xstrndup(s, n);
 	} else if (opts.orphan) {
-		// No-op
+		; /* no-op */
 	} else if (opts.detach) {
-		// Check HEAD
+		/* Check HEAD */
 		if (!strcmp(branch, "HEAD"))
 			can_use_local_refs(&opts);
 	} else if (ac < 2 && new_branch) {
-		// DWIM: Infer --orphan when repo has no refs.
+		/* DWIM: Infer --orphan when repo has no refs. */
 		opts.orphan =3D dwim_orphan(&opts, !!opt_track, 0);
 	} else if (ac < 2) {
-		// DWIM: Guess branch name from path.
+		/* DWIM: Guess branch name from path. */
 		const char *s =3D dwim_branch(path, &new_branch);
 		if (s)
 			branch =3D s;
=20
-		// DWIM: Infer --orphan when repo has no refs.
+		/* DWIM: Infer --orphan when repo has no refs. */
 		opts.orphan =3D (!s) && dwim_orphan(&opts, !!opt_track, 1);
 	} else if (ac =3D=3D 2) {
 		struct object_id oid;
--=20
2.43.0-440-gb50a608ba2

