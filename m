From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] diff.c: remove duplicate bibtex pattern introduced by merge
 92bb9785
Date: Mon, 29 Sep 2008 16:52:01 -0500
Message-ID: <JQHRn-pjQtWl2uVwYYUaYhDMb4iGr1mbVT_C8PZkoJXkQVnH42a98w@cipher.nrlssc.navy.mil>
References: <ZOivOHIiBa1yoDqFPq18uB0VuTttUsV4lS5k7YcyEsM@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Sep 29 23:53:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkQgT-00026I-Qu
	for gcvg-git-2@gmane.org; Mon, 29 Sep 2008 23:53:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751939AbYI2VwI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2008 17:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751629AbYI2VwH
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Sep 2008 17:52:07 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:58540 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751337AbYI2VwG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2008 17:52:06 -0400
Received: by mail.nrlssc.navy.mil id m8TLq2jC022753; Mon, 29 Sep 2008 16:52:02 -0500
In-Reply-To: <ZOivOHIiBa1yoDqFPq18uB0VuTttUsV4lS5k7YcyEsM@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 29 Sep 2008 21:52:01.0830 (UTC) FILETIME=[9AB0BC60:01C9227D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97055>

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 diff.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index b001d7b..7c982b4 100644
--- a/diff.c
+++ b/diff.c
@@ -1439,8 +1439,6 @@ static const struct funcname_pattern_entry builtin_funcname_pattern[] = {
 	{ "python", "^[ \t]*((class|def)[ \t].*)$", REG_EXTENDED },
 	{ "ruby", "^[ \t]*((class|module|def)[ \t].*)$",
 	  REG_EXTENDED },
-	{ "bibtex", "(@[a-zA-Z]{1,}[ \t]*\\{{0,1}[ \t]*[^ \t\"@',\\#}{~%]*).*$",
-	  REG_EXTENDED },
 	{ "tex",
 	  "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$",
 	  REG_EXTENDED },
-- 
1.6.0.2.323.g7c850
