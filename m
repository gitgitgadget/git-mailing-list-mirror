Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78BE01F859
	for <e@80x24.org>; Fri,  9 Sep 2016 10:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752958AbcIIKKz (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 06:10:55 -0400
Received: from mout.gmx.net ([212.227.17.21]:58952 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751888AbcIIKKy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 06:10:54 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LuKHz-1b168I033X-011iFy; Fri, 09 Sep 2016 12:10:45
 +0200
Date:   Fri, 9 Sep 2016 12:10:44 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>
Subject: [PATCH v3 1/4] cat-file: fix a grammo in the man page
In-Reply-To: <cover.1473415827.git.johannes.schindelin@gmx.de>
Message-ID: <c472ec57ea07584d96e8eea95175be9290d09edc.1473415827.git.johannes.schindelin@gmx.de>
References: <cover.1472041389.git.johannes.schindelin@gmx.de> <cover.1473415827.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:1TIeVMN+svQ0hD+9G3lV/ZtK7shZyRJF+K9UCopqIWf1UxPWPNz
 fNNn47wL6iZfAcZ2yumAeEq5iT2U98GmSveg4v3Zlc7wqVHB/hkTnyWzulUyDB6oIAeG0P9
 awN3sJCAQ4jP6y60sw3wcFO0xNWVe2OJOxmweuNec31GrMLt/r78CbOtA3eNELpffP5lGHS
 mFMhHwowp4Jx1UuGUXOdw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8dUZ8967QqE=:UconhBl/UmjL9dEyMgRQhg
 oEg06lpmpOqPNgf+8cqjxkroDTSzJqLZuXnMA5CfxCpLwAsvKeBn7gjKP7AAkFwhsV3fM/mlw
 4KjnoX2dAl0pR+d4pkU397YMj0cQQmyYJ0JIUM/wOU3Hw3cxOAZnoInGMirl2Iao9OqKQO/4b
 P/TYc+Y6ag7zc4fTwj2JPKt1vyKTKUhBGdl7YQYDYNMIksetjKXN7z3z/6E4R8K7hickF9nkr
 YT8XUKovRIU86nUj2Y8QlYYChsVR0RruGZpetmfW/w4V0fZ1s2cTdPZGZr3MO55k2vuNmEiJq
 pifEg+c8hguJNmxABwtaBnvpas/W/ltM6rSIuUfqLsOMdoqzt+jSQGrj4CLyeXfCG0NY3VDNx
 0QHIqo44bGo8vc4F5clxO5FpCuGZjj9qAWup7E0+OV5S1M3+oALWcmv9E8qDzhS+3u3YNovOz
 zhhLl5/USkZzcqrNAqir3TTO/g8VFp2MX0ff9xtTvQrtcBtf/S9N1blgVeaX8t80sEktThQh0
 UfH1kI/CASwYeXTfxi3VN1+QysPJYh4BNaKYRX7q4DV7TAtB9GY4ewI6FFGTsDGrXio6MGnvp
 I2YZYzqzgCgFlq1EFHj+eN0fPJxt9gK7xfqJeUc5cKG6wwsSxK3+/YsRudHj1rnBcjPp7uyqQ
 VkyIMDNH7lAILe8awCsFxAPVzJKcgyvHbnGLOwdDGn+hgVEAJpZK4aV/ljh9+mKcTUlf7wnpU
 uZN5dbRw68YqORgmRUsqFqg7NTMCaQhZmCJFmPIxhixPpiy/7O9OoVcBirSmiJH7jNpVwJjuQ
 ouTF+xb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"... has be ..." -> "... has to be ..."

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-cat-file.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index 18d03d8..071029b 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -54,8 +54,9 @@ OPTIONS
 
 --textconv::
 	Show the content as transformed by a textconv filter. In this case,
-	<object> has be of the form <tree-ish>:<path>, or :<path> in order
-	to apply the filter to the content recorded in the index at <path>.
+	<object> has to be of the form <tree-ish>:<path>, or :<path> in
+	order to apply the filter to the content recorded in the index at
+	<path>.
 
 --batch::
 --batch=<format>::
-- 
2.10.0.windows.1.10.g803177d


