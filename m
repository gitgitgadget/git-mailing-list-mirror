From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: [PATCH] Adding limits.h to cache.h in order to compile under Solaris
Date: Sat, 21 May 2005 11:13:55 +0200
Message-ID: <20050521091355.GA11436@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat May 21 11:12:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZQ2P-0002Nm-Nl
	for gcvg-git@gmane.org; Sat, 21 May 2005 11:12:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbVEUJN6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 May 2005 05:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261700AbVEUJN6
	(ORCPT <rfc822;git-outgoing>); Sat, 21 May 2005 05:13:58 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:32685 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261706AbVEUJN4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2005 05:13:56 -0400
Received: from faui04a.informatik.uni-erlangen.de (faui04a.informatik.uni-erlangen.de [131.188.30.117])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j4L9DtS7011190
	for <git@vger.kernel.org>; Sat, 21 May 2005 09:13:55 GMT
Received: (from sithglan@localhost)
	by faui04a.informatik.uni-erlangen.de (8.12.10+Sun/8.12.5/Submit) id j4L9DtW4011467
	for git@vger.kernel.org; Sat, 21 May 2005 11:13:55 +0200 (CEST)
To: GIT <git@vger.kernel.org>
Mail-Followup-To: GIT <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

diff-tree 1ede81fa79aa5bd656f2b2aae3541719d306698d (from 559967c6d4fa3bab269d4a22d2db23f70e0156b7)
Author: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Date:   Sat May 21 10:50:22 2005 +0200
    
    Adding limits.h to cache.h in order to compile under Solaris

diff --git a/cache.h b/cache.h
--- a/cache.h
+++ b/cache.h
@@ -2,6 +2,7 @@
 #define CACHE_H
 
 #include <unistd.h>
+#include <limits.h>
 #include <stdio.h>
 #include <sys/stat.h>
 #include <fcntl.h>
