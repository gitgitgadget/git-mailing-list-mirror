Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B57C433DB
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 20:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3848864E20
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 20:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235269AbhBXU1d (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 15:27:33 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61480 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234346AbhBXU1b (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 15:27:31 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EC563117E2B;
        Wed, 24 Feb 2021 15:26:49 -0500 (EST)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=/bl8DfMvwCptDHKW+aQtJrXip
        CU=; b=GxOeVu99ZP4Tfz3XKP1Y9QO7cCuD6WJCCHQhUS2F6zk76THD8WK0TNPK3
        YJRyuPY7GSBkpOfdrC/Nt1NZEhZGyvfM9ZMEg49ZtT5fBWL9UC2OzSV8kEY+lHSl
        NR5FuxOJJoQ8ZEEL1r2kmTkn0dQpDdzDRV8y6KudTwrln5sdxI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=UiCmkMyiEG9K5VBhrI7
        tWjZs45izQpQwDmLhy4SWOFZetO919WbU1Hpkf1v6yj/I9UJtZlV8RxXCnvHO9/i
        8hZ4dY9ZOisOFwxiOCrX0GfSRQGrp3U3Q1qL+HELiWcAckLbZSyeo1v9QabnW8Qo
        TvEQNd1Q2t74vfOlVmN914q8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E5215117E29;
        Wed, 24 Feb 2021 15:26:49 -0500 (EST)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 30209117E25;
        Wed, 24 Feb 2021 15:26:47 -0500 (EST)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>
Subject: [PATCH v3 1/3] i18n.txt: camel case and monospace "i18n.commitEncoding"
Date:   Wed, 24 Feb 2021 12:26:39 -0800
Message-Id: <20210224202641.913770-2-gitster@pobox.com>
X-Mailer: git-send-email 2.30.1-826-g07a034c5ea
In-Reply-To: <20210224202641.913770-1-gitster@pobox.com>
References: <xmqqlfbe1sim.fsf@gitster.g>
 <20210224202641.913770-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 9E180F02-76DE-11EB-9346-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Denton Liu <liu.denton@gmail.com>

In 95791be750 (doc: camelCase the i18n config variables to improve
readability, 2017-07-17), the other i18n config variables were
camel cased. However, this one instance was missed.

Camel case and monospace "i18n.commitEncoding" so that it matches the
surrounding text.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
[jc: fixed 3 other mistakes that are exactly the same]
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-am.txt       | 2 +-
 Documentation/git-mailinfo.txt | 4 ++--
 Documentation/i18n.txt         | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 06bc063542..decd8ae122 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -79,7 +79,7 @@ OPTIONS
 	Pass `-u` flag to 'git mailinfo' (see linkgit:git-mailinfo[1]).
 	The proposed commit log message taken from the e-mail
 	is re-coded into UTF-8 encoding (configuration variable
-	`i18n.commitencoding` can be used to specify project's
+	`i18n.commitEncoding` can be used to specify project's
 	preferred encoding if it is not UTF-8).
 +
 This was optional in prior versions of git, but now it is the
diff --git a/Documentation/git-mailinfo.txt b/Documentation/git-mailinfo.=
txt
index 7a6aed0e30..d343f040f5 100644
--- a/Documentation/git-mailinfo.txt
+++ b/Documentation/git-mailinfo.txt
@@ -53,7 +53,7 @@ character.
 	The commit log message, author name and author email are
 	taken from the e-mail, and after minimally decoding MIME
 	transfer encoding, re-coded in the charset specified by
-	i18n.commitencoding (defaulting to UTF-8) by transliterating
+	`i18n.commitEncoding` (defaulting to UTF-8) by transliterating
 	them.  This used to be optional but now it is the default.
 +
 Note that the patch is always used as-is without charset
@@ -61,7 +61,7 @@ conversion, even with this flag.
=20
 --encoding=3D<encoding>::
 	Similar to -u.  But when re-coding, the charset specified here is
-	used instead of the one specified by i18n.commitencoding or UTF-8.
+	used instead of the one specified by `i18n.commitEncoding` or UTF-8.
=20
 -n::
 	Disable all charset re-coding of the metadata.
diff --git a/Documentation/i18n.txt b/Documentation/i18n.txt
index 7e36e5b55b..6c6baeeeb7 100644
--- a/Documentation/i18n.txt
+++ b/Documentation/i18n.txt
@@ -38,7 +38,7 @@ mind.
   a warning if the commit log message given to it does not look
   like a valid UTF-8 string, unless you explicitly say your
   project uses a legacy encoding.  The way to say this is to
-  have i18n.commitencoding in `.git/config` file, like this:
+  have `i18n.commitEncoding` in `.git/config` file, like this:
 +
 ------------
 [i18n]
--=20
2.30.1-826-g07a034c5ea

