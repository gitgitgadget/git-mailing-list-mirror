From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] index-pack: fix trivial typo in usage string
Date: Sat,  1 May 2010 20:35:59 +0200
Message-ID: <ea91a4320bf70e3bb4acee0c9b134338c1f36d51.1272555727.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 01 20:36:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8HY0-0000Fl-It
	for gcvg-git-2@lo.gmane.org; Sat, 01 May 2010 20:36:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755904Ab0EASgJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 May 2010 14:36:09 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:37927 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755504Ab0EASgH (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 May 2010 14:36:07 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 95CA8F17F8;
	Sat,  1 May 2010 14:36:01 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Sat, 01 May 2010 14:36:01 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id; s=smtpout; bh=2K/f1q4OpqwOzHYpwhdqDz6Byg4=; b=RmDiEMNvP0fZhksGaslq9khqSd+O3d/eQ2bMT0wokXtlGrWmZpDf346ZxiRY4/kHCA8eUuBLDdE4UZZf1Z2IdrGoqql0zcVIKhN16EwnqrEd8ueBBnMEHvIuCx9iNpRhev6wp9O9ZLfemrVKMHJ5hPj9BCOstSw5h3xCYIXTzTg=
X-Sasl-enc: LBymtupWjfqu5PxrhwuGktFR1zYF6NeEk3+enSZ3s32d 1272738960
Received: from localhost (p5DCC08EA.dip0.t-ipconnect.de [93.204.8.234])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 97D7A188BE;
	Sat,  1 May 2010 14:36:00 -0400 (EDT)
X-Mailer: git-send-email 1.7.1.328.g9993c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146107>

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 builtin/index-pack.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 7f32084..a89ae83 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -11,7 +11,7 @@
 #include "exec_cmd.h"
 
 static const char index_pack_usage[] =
-"git index-pack [-v] [-o <index-file>] [{ ---keep | --keep=<msg> }] [--strict] { <pack-file> | --stdin [--fix-thin] [<pack-file>] }";
+"git index-pack [-v] [-o <index-file>] [{ --keep | --keep=<msg> }] [--strict] { <pack-file> | --stdin [--fix-thin] [<pack-file>] }";
 
 struct object_entry
 {
-- 
1.7.1.328.g9993c
