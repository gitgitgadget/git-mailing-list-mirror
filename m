From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 2/2] mingw: remove unnecessary definition
Date: Sat, 7 May 2016 08:45:09 +0200 (CEST)
Message-ID: <fc2b034244a6f63de354c91d41ecc82d4ef40420.1462603453.git.johannes.schindelin@gmx.de>
References: <17d30bb680a0452efd7b3c4f42e2f94478a86273.1462372716.git.johannes.schindelin@gmx.de> <cover.1462603453.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 07 08:45:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayvzd-0000Zb-EA
	for gcvg-git-2@plane.gmane.org; Sat, 07 May 2016 08:45:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751741AbcEGGpd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 May 2016 02:45:33 -0400
Received: from mout.gmx.net ([212.227.17.22]:63258 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751072AbcEGGpc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2016 02:45:32 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MGzwE-1av8Lo36oM-00DmkF; Sat, 07 May 2016 08:45:06
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1462603453.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:ecmG597XZgghe137LtT9NOC+ydL6S5boedZmFJtlarXs/HnZ3Ck
 Z+xjJ9mWaPHSV1qtO/ZzTkUKNX+kAiA6P9YbLEo/SngMzF4jtBQGPxTlAzQ1awf9BL+t6fk
 aCwX3KBvdnrWiKxjN6DzyDhedim8qt2O913TE+dbmGtqp4llDC/8+F5KDChSOPx96xkBsPt
 d58O1oy8MOcPnvHhnSRpw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Igv4+qjDG1Y=:3rqmmW/UALL8DMQ3G8knR1
 d4brsLXPj36y5vb0zTr2OxqcHDiyY9QGA/NW5fjEavWkCQn4Nx0lz3U0GaKcpEQb4GDESxrTb
 pGjNLoYE2O0SZTHDr2f8bI4KR8A9r4TKv496dYLUNpN8OPfv/OQDeNd/C6/N2Eaz0bKfLpf6+
 5lwynsKMt+IeOvZnzPRy8M1EyC+3plfkVC0oGI3JN+RIjnvFwCXt14q51inw6yTOsYyayNF/3
 MZxNvejORicSEW82eglmHJH/lJJh7oCvLsjbwSTj1fqbtrFrZu4HJ+kBHlcWn/7XPP8R4b/qd
 1RqKSsPmcFzYj1GtAnVVxj22hgKk929xmQucf8TNfUSJfbWouMf5tx5E1CtDtQOvcTbdcnPSp
 T7m3zt3jUht9MsNorzKf3O1cFTutAXApCNaHSF4Ov/4ih4xA7xXvt6ZGv2fDjdGhjeKf5e78y
 39ffAUjVB++2epn4iRGj4M8TY48CBna5BC1Se3I4h2wDTJWnHPGn0jlKLKBMVvRcHA1U1sGic
 N+Kx0ciCiLg1P4jz6gTWau2wxRUCUAPCca8cAhtHRjMIpfuMcJWU3CvNROTU6HFuNBGZ+q7Ur
 F/YW8YbQw01suzoxaeOFhz8eQ6gq2kJHRmqSvhXatjnAQLY+21gRObnkwTlcP+AzXZRPKlHG4
 skeO5jR3dMJlW17AfSTMRboXx0lMc1Q1SSIufsoGVk2DoaTO71NZsTRAZRGuZmxXQluiacgAr
 2WwVdgpRqsEZST1aZAujvudNT1Gk2iTKdM6UBJz60eVqexRQkaa6PoduJPfnUE6QVgLAJkgk 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293885>

For some reason, the definition of the MINGW version of
`mark_as_git_dir()` slipped into this developer's patch series to
support building Git for Windows.

As the `mark_as_git_dir()` function is not needed at all anymore (it was
used originally to support the core.hideDotFiles = gitDirOnly setting,
but we now use a different method to support that case), let's just
remove it.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/compat/mingw.h b/compat/mingw.h
index 1de70ff..a1808b4 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -416,9 +416,6 @@ int mingw_offset_1st_component(const char *path);
 void mingw_open_html(const char *path);
 #define open_html mingw_open_html
 
-void mingw_mark_as_git_dir(const char *dir);
-#define mark_as_git_dir mingw_mark_as_git_dir
-
 /**
  * Converts UTF-8 encoded string to UTF-16LE.
  *
-- 
2.8.2.463.g99156ee
