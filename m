Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9767C1F4BD
	for <e@80x24.org>; Sat,  5 Oct 2019 12:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbfJEM5r (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Oct 2019 08:57:47 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:50795 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727788AbfJEM5r (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Oct 2019 08:57:47 -0400
X-Originating-IP: 1.186.12.44
Received: from localhost.localdomain (unknown [1.186.12.44])
        (Authenticated sender: me@yadavpratyush.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 9C233240003;
        Sat,  5 Oct 2019 12:57:44 +0000 (UTC)
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] Documentation: update the location of the git-gui repo
Date:   Sat,  5 Oct 2019 18:27:42 +0530
Message-Id: <20191005125742.3753-1-me@yadavpratyush.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191004222956.12341-1-me@yadavpratyush.com>
References: <20191004222956.12341-1-me@yadavpratyush.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Pratyush Yadav <me@yadavpratyush.com>
---

Changes in v2:
- Only link the repo, instead of having instructions to "clone" and
  "browse online".

Do note that I am using single quotes around git gui instead of
backticks like you suggested because the rest of the man page does the
same.

Interdiff against v1:
  diff --git a/Documentation/git-gui.txt b/Documentation/git-gui.txt
  index 98337b69f1..c9d7e96214 100644
  --- a/Documentation/git-gui.txt
  +++ b/Documentation/git-gui.txt
  @@ -112,11 +112,9 @@ Other
   versions are distributed as part of the Git suite for the convenience
   of end users.

  -A 'git gui' development repository can be obtained from:
  +The official repository of the 'git gui' project can be found at:

  -  git clone https://github.com/prati0100/git-gui.git
  -
  -or browsed online at https://github.com/prati0100/git-gui[].
  +  https://github.com/prati0100/git-gui.git/

   GIT
   ---

 Documentation/git-gui.txt | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-gui.txt b/Documentation/git-gui.txt
index 5f93f8003d..c9d7e96214 100644
--- a/Documentation/git-gui.txt
+++ b/Documentation/git-gui.txt
@@ -112,15 +112,9 @@ Other
 versions are distributed as part of the Git suite for the convenience
 of end users.

-A 'git gui' development repository can be obtained from:
+The official repository of the 'git gui' project can be found at:

-  git clone git://repo.or.cz/git-gui.git
-
-or
-
-  git clone http://repo.or.cz/r/git-gui.git
-
-or browsed online at http://repo.or.cz/w/git-gui.git/[].
+  https://github.com/prati0100/git-gui.git/

 GIT
 ---
--
2.21.0

