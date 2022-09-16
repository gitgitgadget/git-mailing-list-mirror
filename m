Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BF8ECAAD8
	for <git@archiver.kernel.org>; Fri, 16 Sep 2022 06:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbiIPGXb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Sep 2022 02:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiIPGX2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2022 02:23:28 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0AB9BB5E
        for <git@vger.kernel.org>; Thu, 15 Sep 2022 23:23:26 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 375F41BD19B;
        Fri, 16 Sep 2022 02:23:26 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=sasl; bh=9XBVHeQKYfk3Vff+3ahEGukXQt6KDMztY7Fg+j827yc=; b=upJc
        Bis6GkJZ6s3pgukdq65fmeXsLdhPzLOwM4ELAJKKn9wIT1Y1aR3aH6O7s7S8qhFy
        i3upaidOQ+wEU97LqEzMVA/pNFCtACJekyniNYjx/sseq0swSmxDmBIo4MPFMNiy
        8byznvWp+Mczwnvae4tVL02IBtLV/oSSwPPVrXw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2EF0A1BD19A;
        Fri, 16 Sep 2022 02:23:26 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from morphine.teonanacatl.net (unknown [47.204.171.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 864161BD199;
        Fri, 16 Sep 2022 02:23:21 -0400 (EDT)
        (envelope-from tmz@pobox.com)
From:   Todd Zullinger <tmz@pobox.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] docs: fix a few recently broken links
Date:   Fri, 16 Sep 2022 02:23:02 -0400
Message-Id: <20220916062303.3736166-1-tmz@pobox.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
X-Pobox-Relay-ID: 0FF33A16-3588-11ED-A11C-C2DA088D43B2-09356542!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some links were broken in the recent move of various technical docs
c0f6dd49f1 (Merge branch 'ab/tech-docs-to-help', 2022-08-14).

Fix them.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 Documentation/gitprotocol-capabilities.txt | 4 ++--
 Documentation/gitprotocol-v2.txt           | 4 ++--
 Documentation/technical/bundle-uri.txt     | 3 +--
 Documentation/user-manual.txt              | 2 +-
 4 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/Documentation/gitprotocol-capabilities.txt b/Documentation/g=
itprotocol-capabilities.txt
index c6dcc7d565..0fb5ea0c1c 100644
--- a/Documentation/gitprotocol-capabilities.txt
+++ b/Documentation/gitprotocol-capabilities.txt
@@ -388,8 +388,8 @@ the server as well.
 Session IDs should be unique to a given process. They must fit within a
 packet-line, and must not contain non-printable or whitespace characters=
. The
 current implementation uses trace2 session IDs (see
-link:api-trace2.html[api-trace2] for details), but this may change and u=
sers of
-the session ID should not rely on this fact.
+link:technical/api-trace2.html[api-trace2] for details), but this may ch=
ange
+and users of the session ID should not rely on this fact.
=20
 GIT
 ---
diff --git a/Documentation/gitprotocol-v2.txt b/Documentation/gitprotocol=
-v2.txt
index c9c0f9160b..59bf41cefb 100644
--- a/Documentation/gitprotocol-v2.txt
+++ b/Documentation/gitprotocol-v2.txt
@@ -544,8 +544,8 @@ the server as well.
 Session IDs should be unique to a given process. They must fit within a
 packet-line, and must not contain non-printable or whitespace characters=
. The
 current implementation uses trace2 session IDs (see
-link:api-trace2.html[api-trace2] for details), but this may change and u=
sers of
-the session ID should not rely on this fact.
+link:technical/api-trace2.html[api-trace2] for details), but this may ch=
ange
+and users of the session ID should not rely on this fact.
=20
 object-info
 ~~~~~~~~~~~
diff --git a/Documentation/technical/bundle-uri.txt b/Documentation/techn=
ical/bundle-uri.txt
index c25c42378a..85c6a7fc7c 100644
--- a/Documentation/technical/bundle-uri.txt
+++ b/Documentation/technical/bundle-uri.txt
@@ -3,8 +3,7 @@ Bundle URIs
=20
 Git bundles are files that store a pack-file along with some extra metad=
ata,
 including a set of refs and a (possibly empty) set of necessary commits.=
 See
-linkgit:git-bundle[1] and link:bundle-format.txt[the bundle format] for =
more
-information.
+linkgit:git-bundle[1] and linkgit:gitformat-bundle[5] for more informati=
on.
=20
 Bundle URIs are locations where Git can download one or more bundles in
 order to bootstrap the object database in advance of fetching the remain=
ing
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.tx=
t
index ca9decdd95..dc9c6a663a 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -3133,7 +3133,7 @@ those "loose" objects.
 You can save space and make Git faster by moving these loose objects in
 to a "pack file", which stores a group of objects in an efficient
 compressed format; the details of how pack files are formatted can be
-found in link:gitformat-pack[5].
+found in linkgit:gitformat-pack[5].
=20
 To put the loose objects into a pack, just run git repack:
=20
