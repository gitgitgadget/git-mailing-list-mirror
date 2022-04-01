Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7992EC43219
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 14:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346936AbiDAO3B (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 10:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346967AbiDAO2U (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 10:28:20 -0400
Received: from b-painless.mh.aa.net.uk (b-painless.mh.aa.net.uk [IPv6:2001:8b0:0:30::52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F07D1C3485
        for <git@vger.kernel.org>; Fri,  1 Apr 2022 07:26:30 -0700 (PDT)
Received: from [195.110.77.193] (helo=red.nvidia.com)
        by painless-b.tch.aa.net.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <jholdsworth@nvidia.com>)
        id 1naIEP-009TW3-CT; Fri, 01 Apr 2022 15:26:28 +0100
From:   Joel Holdsworth <jholdsworth@nvidia.com>
To:     git@vger.kernel.org, Luke Diamand <luke@diamand.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Cc:     Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>,
        Joel Holdsworth <jholdsworth@nvidia.com>
Subject: [PATCH v5 22/22] git-p4: sort imports
Date:   Fri,  1 Apr 2022 15:25:04 +0100
Message-Id: <20220401142504.58995-23-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.35.GIT
In-Reply-To: <20220401142504.58995-1-jholdsworth@nvidia.com>
References: <20220401142504.58995-1-jholdsworth@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
This version of the patch adds a missing Signed-off-by label.

 git-p4.py | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index c3239cdabc..ea1d09f69f 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -30,26 +30,28 @@
 # pylint: disable=wrong-import-order
 # pylint: disable=wrong-import-position
 #
+
 import sys
 if sys.version_info.major < 3 and sys.version_info.minor < 7:
     sys.stderr.write("git-p4: requires Python 2.7 or later.\n")
     sys.exit(1)
-import os
-import optparse
+
+import ctypes
+import errno
 import functools
+import glob
 import marshal
-import subprocess
-import tempfile
-import time
+import optparse
+import os
 import platform
 import re
 import shutil
 import stat
+import subprocess
+import tempfile
+import time
 import zipfile
 import zlib
-import ctypes
-import errno
-import glob
 
 # On python2.7 where raw_input() and input() are both availble,
 # we want raw_input's semantics, but aliased to input for python3
-- 
2.35.GIT

