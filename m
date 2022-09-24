Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC71FC07E9D
	for <git@archiver.kernel.org>; Sat, 24 Sep 2022 03:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233190AbiIXDiA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Sep 2022 23:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233207AbiIXDhp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2022 23:37:45 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04363139F4D
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 20:37:42 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 792E61B0310;
        Fri, 23 Sep 2022 23:37:42 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=sasl; bh=aZHFdu8c9M/N9+diyN2GlG4gmUEuDq1y5CotlYE1Ebg=; b=Zcku
        HBFel/XEGJl11DwQkHojDth1CdzARLLTP3YLBB5URDPzDtxcW4akr7bDCzYQwTm/
        SOB25p+skEbY1SWG4lvs2tswSaC6O/n+jNbPw90iICFMxV+GpUk5s/6QZR/wmiBR
        kXrVtYEUvISCRE4Hoa6oKVD8z4PgETCbOiIZ39I=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 744D71B030F;
        Fri, 23 Sep 2022 23:37:42 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from morphine.teonanacatl.net (unknown [47.204.171.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CF3801B030E;
        Fri, 23 Sep 2022 23:37:37 -0400 (EDT)
        (envelope-from tmz@pobox.com)
From:   Todd Zullinger <tmz@pobox.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [filter-repo PATCH] fix links to git-fast-import
Date:   Fri, 23 Sep 2022 23:37:08 -0400
Message-Id: <20220924033708.2409170-1-tmz@pobox.com>
X-Mailer: git-send-email 2.38.0.rc1
MIME-Version: 1.0
X-Pobox-Relay-ID: 3C577FEE-3BBA-11ED-8F5F-B31D44D1D7AA-09356542!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The name of the html and man page for `git-fast-import` is missing the
`git-` prefix.  Add it where appropriate.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
Hi Elijah,

I noticed the link to git-fast-import.html in git-filter-repo.html was
missing the `git-` prefix.  The man page similarly lacked it when
referencing it.

 html/git-filter-repo.html | 2 +-
 man1/git-filter-repo.1    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/html/git-filter-repo.html b/html/git-filter-repo.html
index 3143fd9..5119fa2 100644
--- a/html/git-filter-repo.html
+++ b/html/git-filter-repo.html
@@ -2167,7 +2167,7 @@ that filter-repo uses bytestrings (see
 instead of strings.</p></div>
 <div class=3D"paragraph"><p>There are four callbacks that allow you to o=
perate directly on raw
 objects that contain data that&#8217;s easy to write in
-<a href=3D"fast-import.html">fast-import(1)</a> format:</p></div>
+<a href=3D"git-fast-import.html">git-fast-import(1)</a> format:</p></div=
>
 <div class=3D"listingblock">
 <div class=3D"content">
 <pre><code>--blob-callback
diff --git a/man1/git-filter-repo.1 b/man1/git-filter-repo.1
index 188fd2a..9f9bbfc 100644
--- a/man1/git-filter-repo.1
+++ b/man1/git-filter-repo.1
@@ -1512,7 +1512,7 @@ def foo_callback(foo):
 .sp
 Thus, you just need to make sure your \fIBODY\fR modifies and returns \f=
Ifoo\fR appropriately\&. One important thing to note for all callbacks is=
 that filter\-repo uses bytestrings (see \m[blue]\fBhttps://docs\&.python=
\&.org/3/library/stdtypes\&.html#bytes\fR\m[]) everywhere instead of stri=
ngs\&.
 .sp
-There are four callbacks that allow you to operate directly on raw objec=
ts that contain data that\(cqs easy to write in \fBfast-import\fR(1) form=
at:
+There are four callbacks that allow you to operate directly on raw objec=
ts that contain data that\(cqs easy to write in \fBgit-fast-import\fR(1) =
format:
 .sp
 .if n \{\
 .RS 4
--=20
2.38.0.rc1

