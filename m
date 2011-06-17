From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] sh-i18n--envsubst.c: do not #include getopt.h
Date: Fri, 17 Jun 2011 11:19:26 -0700
Message-ID: <kRqfchEd_hGmm2-6DxLIF_ZcWaZwm2iR22QJo3x5ntYrK5NZzsgLexeDbn1dSo9BMP8SLjkiTqiNION3P1CL0w@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jun 17 20:20:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXdeF-00023N-Bn
	for gcvg-git-2@lo.gmane.org; Fri, 17 Jun 2011 20:20:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932399Ab1FQST5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jun 2011 14:19:57 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:49806 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932107Ab1FQST5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2011 14:19:57 -0400
Received: by mail.nrlssc.navy.mil id p5HIJgIF020275; Fri, 17 Jun 2011 13:19:43 -0500
X-OriginalArrivalTime: 17 Jun 2011 18:19:43.0540 (UTC) FILETIME=[21722F40:01CC2D1B]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175957>

From: Brandon Casey <drafnel@gmail.com>

The getopt.h header file is not used.  It's inclusion is left over from the
original version of this source.  Additionally, getopt.h does not exist on
all platforms (SunOS 5.7) and will cause a compilation failure.  So, let's
remove it.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 sh-i18n--envsubst.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/sh-i18n--envsubst.c b/sh-i18n--envsubst.c
index 2eb0ee4..9d2e971 100644
--- a/sh-i18n--envsubst.c
+++ b/sh-i18n--envsubst.c
@@ -51,7 +51,6 @@
    Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.  */
 
 #include <errno.h>
-#include <getopt.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-- 
1.7.6.rc1.3.g600a62
