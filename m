Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A45AC433E0
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 14:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05A442053B
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 14:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mkoskar.com header.i=mk@mkoskar.com header.b="i0txR80F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732869AbgFWOkX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 10:40:23 -0400
Received: from sender4-of-o56.zoho.com ([136.143.188.56]:21691 "EHLO
        sender4-of-o56.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732738AbgFWOkW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 10:40:22 -0400
X-Greylist: delayed 903 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Jun 2020 10:40:22 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1592922317; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=RY1cJGXO4uGl4OY1xzbbhHyg1nNDtqOmPAMIIYm+l2zNeMvncrx1mSPepfEofPQ6WZG+g/8GMCocpWEoOZbqvD+poyCx4q7ekLCc3EW7sR88oMoOcW/LTqQKFY118JlNN32ds7qGrs9bXL5F5tPApBRy7XbscWyqFYYPAic84+s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1592922317; h=Content-Type:Content-Transfer-Encoding:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=ln6AT/yKCCP7krlUk0W4k4PD277HrScaHB3LeKLEegM=; 
        b=QNb90eC2cnyljjbQ0AvcX5ODsQv7SM0IWn0U7A59e4r6aSOOyzLaaCGYCmbDE7MuX/GGO2fy81e9vFXENQwlo/kCiQAHgDctWekIXtr1KHjRpj9v0dDIig63fpTzz9OXlwa7RA+OGpqfj+8/sZYPc7ZdYbnSZ88JXDQYRBz7TUc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=mkoskar.com;
        spf=pass  smtp.mailfrom=mk@mkoskar.com;
        dmarc=pass header.from=<mk@mkoskar.com> header.from=<mk@mkoskar.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1592922317;
        s=zoho; d=mkoskar.com; i=mk@mkoskar.com;
        h=From:To:Message-ID:Subject:Date:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=ln6AT/yKCCP7krlUk0W4k4PD277HrScaHB3LeKLEegM=;
        b=i0txR80FsHMa8OJrF/0zS778Tp55N1jHQRCMS1kF7cEoFgJtZ/l+qcCPI5EmL9Q9
        IKbXygOmBdD1HJ1Z+UaFj6vt1r7JDLDQJYOafyv/IsXeay8+3wnzh2fVO+JLIZk/aHa
        Bf8ZFxA6fy/lEFx3E4wmyUv7SIHASq3kzN4MI1SA=
Received: from localhost (baobab.mkoskar.com [185.8.165.229]) by mx.zohomail.com
        with SMTPS id 1592922313782271.69103381083994; Tue, 23 Jun 2020 07:25:13 -0700 (PDT)
From:   =?UTF-8?q?Miroslav=20Ko=C5=A1k=C3=A1r?= <mk@mkoskar.com>
To:     git@vger.kernel.org
Message-ID: <20344c64ecfd40e5ea2eb964f93eb1d27fea323c.1592922271.git.mk@mkoskar.com>
Subject: [PATCH] doc: fix author vs. committer copy/paste error
Date:   Tue, 23 Jun 2020 16:24:43 +0200
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Miroslav Ko=C5=A1k=C3=A1r <mk@mkoskar.com>
---
 Documentation/pretty-formats.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-format=
s.txt
index 547a552463..84bbc7439a 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -196,8 +196,8 @@ The placeholders are:
 '%ce':: committer email
 '%cE':: committer email (respecting .mailmap, see
 =09linkgit:git-shortlog[1] or linkgit:git-blame[1])
-'%cl':: author email local-part (the part before the '@' sign)
-'%cL':: author local-part (see '%cl') respecting .mailmap, see
+'%cl':: committer email local-part (the part before the '@' sign)
+'%cL':: committer local-part (see '%cl') respecting .mailmap, see
 =09linkgit:git-shortlog[1] or linkgit:git-blame[1])
 '%cd':: committer date (format respects --date=3D option)
 '%cD':: committer date, RFC2822 style
--=20
2.27.0


