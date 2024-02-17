Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF061CD1F
	for <git@vger.kernel.org>; Sat, 17 Feb 2024 16:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708187918; cv=none; b=NixgeqV2ZwFRTpuaO+V9jinM8Efl7qQ7Di6AhSo5a/JVCjoUBOGMILdYx+TZY44QozZjr12oDJJ+kEuusPnArmILFIaV3MlIykTCrRs+qT4TpHbNNbwae70+VUl0vuHwqW7XE7jRBzXWwPqAd5JVqJUsV3bd7JPEibdIkB5N5vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708187918; c=relaxed/simple;
	bh=k3+9o6aJMbuAx1Bn3/IVKTGAabpJN+eT7JXnhSXIesw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rspUXCKsk4730icQZs1hfW9B/Bd8A+fqq8emPkP/Mp8DNSQdOLl77cYfpCbWHQJAhlUkCcPNgYv+kWhZBW0klaENmEaHtYjrwAfbjoevTbeFC0hgDYMWbAwAsXHqQ1aOgo34AGAUvEwXu41brv22w8E6K1BAhyV6xI+eJhRoy24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=FbTBxHRK; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FbTBxHRK"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0FAC21EE2CD;
	Sat, 17 Feb 2024 11:38:36 -0500 (EST)
	(envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=k3+9o6aJMbuAx1Bn3/IVKTGAa
	bpJN+eT7JXnhSXIesw=; b=FbTBxHRKsxvhpLFCzuXBtkCYW/6jULBDV8ly8Jm9T
	8OQu107UuEFmOKfmfSRY+ijL0T6UiXCSXwb0p/8a+nLxWUrclWXL+4TZRBTiuawB
	aYKsJRM1ne6t5mhUjSfTSL1FD7wlEJFUfU7Fz44FUHPYhu/VLsELiJ8j1szthK+s
	24=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 07EEB1EE2CC;
	Sat, 17 Feb 2024 11:38:36 -0500 (EST)
	(envelope-from tmz@pobox.com)
Received: from morphine.paradise.teonanacatl.net (unknown [47.204.171.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4FA0C1EE2CB;
	Sat, 17 Feb 2024 11:38:35 -0500 (EST)
	(envelope-from tmz@pobox.com)
From: Todd Zullinger <tmz@pobox.com>
To: Kousik Sanagavarapu <five231003@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Subject: [PATCH v2] RelNotes: minor typo fixes in 2.44.0 draft
Date: Sat, 17 Feb 2024 11:37:45 -0500
Message-ID: <20240217163753.301384-1-tmz@pobox.com>
X-Mailer: git-send-email 2.44.0.rc1
In-Reply-To: <ZdAX1Sfiq6gJCoEk@five231003>
References: <ZdAX1Sfiq6gJCoEk@five231003>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 FEA16B60-CDB2-11EE-8F74-25B3960A682E-09356542!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
Kousik Sanagavarapu wrote:
> Todd Zullinger <tmz@pobox.com> wrote:
>=20
>> - * When $HOME/.gitignore is missing but XDG config file available, we
>> + * When $HOME/.gitconfig is missing but XDG config file available, we
>=20
> s/file available/file is available

Good point, thanks. :)

 Documentation/RelNotes/2.44.0.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/RelNotes/2.44.0.txt b/Documentation/RelNotes/2=
.44.0.txt
index 7dd8d75844..7cee544eee 100644
--- a/Documentation/RelNotes/2.44.0.txt
+++ b/Documentation/RelNotes/2.44.0.txt
@@ -3,7 +3,7 @@ Git v2.44 Release Notes
=20
 Backward Compatibility Notes
=20
- * "git chekcout -B <branch>" used to allow switching to a branch that
+ * "git checkout -B <branch>" used to allow switching to a branch that
    is in use on another worktree, but this was by mistake.  The users
    need to use "--ignore-other-worktrees" option.
=20
@@ -54,7 +54,7 @@ UI, Workflows & Features
    gitweb behaved as if the file did not exist at all, but now it
    errors out.  This is a change that may break backward compatibility.
=20
- * When $HOME/.gitignore is missing but XDG config file available, we
+ * When $HOME/.gitconfig is missing but XDG config file is available, we
    should write into the latter, not former.  "git gc" and "git
    maintenance" wrote into a wrong "global config" file, which have
    been corrected.
--=20
2.44.0.rc1

