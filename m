From: Lars Hjemli <hjemli@gmail.com>
Subject: [RFC/PATCH 2/3] archive.c: enable traversal of submodules
Date: Mon, 12 Jan 2009 00:45:54 +0100
Message-ID: <1231717555-10559-3-git-send-email-hjemli@gmail.com>
References: <1231717555-10559-1-git-send-email-hjemli@gmail.com>
 <1231717555-10559-2-git-send-email-hjemli@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 12 01:20:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMAXU-0006t2-DJ
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 01:20:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752306AbZALASz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 19:18:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752281AbZALASz
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 19:18:55 -0500
Received: from mail43.e.nsc.no ([193.213.115.43]:40585 "EHLO mail43.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752188AbZALASy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 19:18:54 -0500
Received: from localhost.localdomain (ti0025a380-2268.bb.online.no [80.213.203.224])
	by mail43.nsc.no (8.13.8/8.13.5) with ESMTP id n0BNjuv5029874;
	Mon, 12 Jan 2009 00:45:59 +0100 (MET)
X-Mailer: git-send-email 1.6.1.83.g408d2
In-Reply-To: <1231717555-10559-2-git-send-email-hjemli@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105260>

The option --submodules can be used to activate traversal of sub-
modules when creating archives.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 archive.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/archive.c b/archive.c
index 9ac455d..973dde4 100644
--- a/archive.c
+++ b/archive.c
@@ -262,6 +262,8 @@ static int parse_archive_args(int argc, const char **argv,
 		OPT_STRING(0, "format", &format, "fmt", "archive format"),
 		OPT_STRING(0, "prefix", &base, "prefix",
 			"prepend prefix to each pathname in the archive"),
+		OPT_BOOLEAN(0, "submodules", &traverse_gitlinks,
+			"include reacheable submodules"),
 		OPT__VERBOSE(&verbose),
 		OPT__COMPR('0', &compression_level, "store only", 0),
 		OPT__COMPR('1', &compression_level, "compress faster", 1),
-- 
1.6.1.81.g1df1.dirty
