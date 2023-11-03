Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FB71A27D
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 14:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FS4dNZ8m"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17091BC
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 07:18:34 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 6A4023FBA4;
	Fri,  3 Nov 2023 10:18:34 -0400 (EDT)
	(envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=0v4SUUhhat4gqQCC6b3vTkvl6
	E3BIbVXVm009DnBGRg=; b=FS4dNZ8m1lGD3c7jG1gm4+jSme3i6R9khO+id2Zxk
	0lUNJ1kw5VVVM9agfJI6KxvNVva50UkPElJvQwdDTGlbjzZGHf97hYVZN1kxETBs
	3XqjkY+MY5SpjMfFjBAQmmKqCKdXXIvaw6fAwWKtEe9HdkbNuLbf0m8PdZOAo4fy
	jc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 635A63FBA3;
	Fri,  3 Nov 2023 10:18:34 -0400 (EDT)
	(envelope-from tmz@pobox.com)
Received: from morphine.paradise.teonanacatl.net (unknown [47.204.171.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5F0893FBA2;
	Fri,  3 Nov 2023 10:18:28 -0400 (EDT)
	(envelope-from tmz@pobox.com)
From: Todd Zullinger <tmz@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: [PATCH 1/2] RelNotes: minor typo fixes in 2.43.0 draft
Date: Fri,  3 Nov 2023 10:17:50 -0400
Message-ID: <20231103141759.864875-2-tmz@pobox.com>
X-Mailer: git-send-email 2.43.0.rc0
In-Reply-To: <20231103141759.864875-1-tmz@pobox.com>
References: <20231103141759.864875-1-tmz@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 DC8ACE70-7A53-11EE-B04A-F515D2CDFF5E-09356542!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 Documentation/RelNotes/2.43.0.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/RelNotes/2.43.0.txt b/Documentation/RelNotes/2=
.43.0.txt
index ad3b82fe0a..e66d691f4e 100644
--- a/Documentation/RelNotes/2.43.0.txt
+++ b/Documentation/RelNotes/2.43.0.txt
@@ -16,7 +16,7 @@ Backward Compatibility Notes
    rule is that "--not" given from the command line only affects revs
    given from the command line that comes but not revs read from the
    standard input, and "--not" read from the standard input affects
-   revs given from the stanrdard input and not revs given from the
+   revs given from the standard input and not revs given from the
    command line.
=20
 UI, Workflows & Features
@@ -62,7 +62,7 @@ UI, Workflows & Features
    describe complex "revert of revert of revert" situation better in
    their own words.
=20
- * The command-line complation support (in contrib/) learned to
+ * The command-line completion support (in contrib/) learned to
    complete "git commit --trailer=3D" for possible trailer keys.
=20
  * "git update-index" learns "--show-index-version" to inspect
--=20
2.43.0.rc0

