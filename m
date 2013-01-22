From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] Makefile: Replace merge-file.h with merge-blobs.h in LIB_H
Date: Tue, 22 Jan 2013 16:47:47 +0000
Message-ID: <50FEC2B3.3010000@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 19:41:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tximy-0008Oj-7G
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 19:41:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753915Ab3AVSlS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 13:41:18 -0500
Received: from mdfmta004.mxout.tbr.inty.net ([91.221.168.45]:47161 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752883Ab3AVSlR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 13:41:17 -0500
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id 7CBBDA0C085;
	Tue, 22 Jan 2013 18:41:15 +0000 (GMT)
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id C8F8CA0C084;	Tue, 22 Jan 2013 18:41:14 +0000 (GMT)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta004.tbr.inty.net (Postfix) with ESMTP;	Tue, 22 Jan 2013 18:41:13 +0000 (GMT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
X-MDF-HostID: 9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214243>


Commit fa2364ec ("Which merge_file() function do you mean?", 06-12-2012)
renamed the files merge-file.[ch] to merge-blobs.[ch], but forgot to
rename the header file in the definition of the LIB_H macro.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 1b30d7b..a786d4c 100644
--- a/Makefile
+++ b/Makefile
@@ -649,7 +649,7 @@ LIB_H += list-objects.h
 LIB_H += ll-merge.h
 LIB_H += log-tree.h
 LIB_H += mailmap.h
-LIB_H += merge-file.h
+LIB_H += merge-blobs.h
 LIB_H += merge-recursive.h
 LIB_H += mergesort.h
 LIB_H += notes-cache.h
-- 
1.8.1
