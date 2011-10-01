From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] name-rev: split usage string
Date: Sat, 01 Oct 2011 19:04:44 +0200
Message-ID: <4E87482C.30001@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 01 19:05:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RA2zn-0004Pi-PX
	for gcvg-git-2@lo.gmane.org; Sat, 01 Oct 2011 19:05:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754130Ab1JARFA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Oct 2011 13:05:00 -0400
Received: from india601.server4you.de ([85.25.151.105]:55670 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753722Ab1JARE6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Oct 2011 13:04:58 -0400
Received: from [192.168.2.104] (p4FFD8E7C.dip.t-dialin.net [79.253.142.124])
	by india601.server4you.de (Postfix) with ESMTPSA id 6DBEA2F803A;
	Sat,  1 Oct 2011 19:04:57 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0) Gecko/20110922 Thunderbird/7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182566>

Give each mode of operation (all, from stdin, given commits) its own usage
line to make it easier to see that they are mutually exclusive.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 builtin/name-rev.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 31f5c1c..7864056 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -172,7 +172,9 @@ static void show_name(const struct object *obj,
 }
 
 static char const * const name_rev_usage[] = {
-	"git name-rev [options] ( --all | --stdin | <commit>... )",
+	"git name-rev [options] <commit>...",
+	"git name-rev [options] --all",
+	"git name-rev [options] --stdin",
 	NULL
 };
 
-- 
1.7.7
