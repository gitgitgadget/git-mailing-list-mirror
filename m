From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: [PATCH] compile fixes for solaris: include limits.h one more time
Date: Wed, 18 May 2005 18:46:53 +0200
Message-ID: <20050518164653.GB4738@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="x+6KMIRAuhnl3hBn"
X-From: git-owner@vger.kernel.org Wed May 18 19:12:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYS3k-0005EM-2i
	for gcvg-git@gmane.org; Wed, 18 May 2005 19:10:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262339AbVERQvE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 May 2005 12:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262312AbVERQrk
	(ORCPT <rfc822;git-outgoing>); Wed, 18 May 2005 12:47:40 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:50103 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262281AbVERQq5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2005 12:46:57 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j4IGkrS8019320
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 18 May 2005 16:46:53 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j4IGkrtq019319
	for git@vger.kernel.org; Wed, 18 May 2005 18:46:53 +0200 (CEST)
To: GIT <git@vger.kernel.org>
Mail-Followup-To: GIT <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

[PATCH] compile fixes for solaris: include limits.h one more time

Signed-off-by: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>

--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=diff

--- a/checkout-cache.c
+++ b/checkout-cache.c
@@ -34,6 +34,7 @@
  */
 #include <sys/types.h>
 #include <dirent.h>
+#include <limits.h>
 #include "cache.h"
 
 static int force = 0, quiet = 0, not_new = 0;

--x+6KMIRAuhnl3hBn--
