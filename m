Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0860B4084E
	for <git@vger.kernel.org>; Fri,  9 Aug 2024 17:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723223656; cv=none; b=o3EUf9ieLs7N5B0MyCnnu9pVZmpkPSkzf1NZbehYWMdodJMFuFIgza5gym2itqPQ0GbA50B/+/h0KbGYUf6ZSWiVsw4MwjosmQf+i3rYzM6Hz5blG9o40KJKexAdZDGRixr5kUCpzmR3ky8EFqjUqZMnGyk4Q5PnN0xPkfba5G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723223656; c=relaxed/simple;
	bh=vrmg4pE3X3IQIg5oLk4MExGm54+Bjbh9vU+iicHy3K0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HDFTFK7VaK11SIlVkKemsW/M1USj9GPG3ltmhWvPVOaUJjhfXdIW5jUX4D5yxQ84o7F/Znq+R94ZP2pv8edmsUTJRYm5+pRXuwQOBmVvcURXoiBLtD0lc0wRe8onrS952D0atpVh+s8sKwDdfPirA0CZyhHkBw/VMAdM6RZC0LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=LRzXzytb; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LRzXzytb"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id F3E392D1A8;
	Fri,  9 Aug 2024 13:14:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=v
	rmg4pE3X3IQIg5oLk4MExGm54+Bjbh9vU+iicHy3K0=; b=LRzXzytbaLWlea2v4
	c5ESKxVUmUBEd6j3ZebIInJzEu2UtW9/IRa/avmGauYreocfrZffGvGXVZqEngRX
	LDJHUXsfb+NtwBa18aT6vNPPnAxcyaHRSPpXp/8VqBYcRVZdC49gGnBYfcELaxGC
	Kn9mgRiGudLLoUHsS52taT/moo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EC1942D1A7;
	Fri,  9 Aug 2024 13:14:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 515692D1A5;
	Fri,  9 Aug 2024 13:14:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] doc: grammofix in git-diff-tree
Date: Fri, 09 Aug 2024 10:14:12 -0700
Message-ID: <xmqqed6xehzv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CCC58100-5672-11EF-9618-9B0F950A682E-77302942!pb-smtp2.pobox.com

Describe in present tense what the option does when it is given.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-diff-tree.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tree.txt
index 274d5eaba9..59bdc228e4 100644
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -88,7 +88,7 @@ include::pretty-options.txt[]
 
 --no-commit-id::
 	'git diff-tree' outputs a line with the commit ID when
-	applicable.  This flag suppressed the commit ID output.
+	applicable.  This flag suppresses the commit ID output.
 
 -c::
 	This flag changes the way a merge commit is displayed
-- 
2.46.0-316-ga5b7e061b1

