Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3A01FB2
	for <git@vger.kernel.org>; Sun, 31 Mar 2024 20:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711918177; cv=none; b=Ha/RQkt40QviWmoJ7wivdF5KHGzTzTNlrecfk0PbExoOx1TnzP04JKAIZVvahC3974UbtO3jAQShbUphsLHOAvEsBVESVK7ALWcWGSc43Y+vaOP121Rgt6KJgA0kDzAo26SJRurOvkTnD9NDNEuy71uodkKU6LWVve3YbzBKw2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711918177; c=relaxed/simple;
	bh=eBUmyx3MBOFgQiytXYAmhTz0mGgEqIMMt+zxYKE9HL4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cDCJDNqmGRQrR8am3pUkmoyfPqlKfy098tCBiiIHqqwWroPA5V5dGwwmtNeDTvYzXc+JthdHwiVRGmadhsEm3ycKJQdG3IM8BKsHq9Ywfdbfb9mhxv9s4RCGmNPG94c8G9OGcVJwyIBCDtB+iiLv/u3Qyv1xMqmqKaxpjodKStI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=e4Eu0RAS; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="e4Eu0RAS"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1711918172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UYth/K0rJ9G660TkJ+OjxnI8hepErhSkPYQYQ/eGrkE=;
	b=e4Eu0RASb+pxQxMl6A2jZS10y8mLrSu6rS7lasmHFQM1vOPtnC765KcwGne/oQpIrzwCn5
	dIvheROKypOXpd8NBhTt9+5tp78Z/VXxMD26M2hJgeZGw0If6MgsBeeTC+tNdMDLeWknNI
	Apj9LMCaQ6QV/gd6nbTNkL3gsf1EwCya1nlEGYW6ktbC18uoNyvidB4Ogl4xk+C5jgf1ut
	EtndhEAsv0sLl3dpm5GPVgAqETrQ5Ah2OFOzi8IuMjeiDQXG3aB+ZAq/BWhNmi8ERyRKsC
	MvoL4lyD0LR7Ckef9XEiqj6kvs1cvnKKEEfQ5jnhj7oLW1wmUiRAsYg5SAr5sA==
To: git@vger.kernel.org
Cc: gitster@pobox.com
Subject: [PATCH v2] config: fix some small capitalization issues, as spotted
Date: Sun, 31 Mar 2024 22:49:30 +0200
Message-Id: <26135b06c48565ee8ac6dcfc1ef5431511e6202c.1711918168.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Fix some small capitalization issues, as spotted while going through the
documentation.  In general, a semicolon doesn't start a new sentence, and
"this" has no meaning of a proper noun in this context.

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---

Notes:
     * Fix some small capitalization issues in the documentation.
    
    Changes in v2:
        - Changed double spacing before the semicolon to single spacing,
          as suggested by Junio [1]
    
    Link to v1: https://lore.kernel.org/git/6f6f821fc090fb59f632fcdbd061154b897b1244.1711772691.git.dsimic@manjaro.org/
    
    [1] https://lore.kernel.org/git/xmqqo7avlaqn.fsf@gitster.g/

 Documentation/config/core.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index 2d4bbdb25fa3..41b071d8851c 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -688,7 +688,7 @@ core.createObject::
 	will not overwrite existing objects.
 +
 On some file system/operating system combinations, this is unreliable.
-Set this config setting to 'rename' there; However, This will remove the
+Set this config setting to 'rename' there; however, this will remove the
 check that makes sure that existing object files will not get overwritten.
 
 core.notesRef::
