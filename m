From: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: [PATCH] Makefile: add thread-utils.h to LIB_H
Date: Sat, 25 Feb 2012 03:42:42 +0400
Message-ID: <20120224234242.GA3124@altlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 25 00:51:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S14uw-0007hv-Fd
	for gcvg-git-2@plane.gmane.org; Sat, 25 Feb 2012 00:51:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754383Ab2BXXvI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Feb 2012 18:51:08 -0500
Received: from vint.altlinux.org ([194.107.17.35]:52898 "EHLO
	vint.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754183Ab2BXXvH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2012 18:51:07 -0500
X-Greylist: delayed 504 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 Feb 2012 18:51:07 EST
Received: from wo.int.altlinux.org (wo.int.altlinux.org [192.168.1.4])
	by vint.altlinux.org (Postfix) with ESMTP id 7B338226C0AB;
	Fri, 24 Feb 2012 23:42:42 +0000 (UTC)
Received: by wo.int.altlinux.org (Postfix, from userid 508)
	id 59E2F3F48773; Sat, 25 Feb 2012 03:42:42 +0400 (MSK)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191500>

Starting with commit v1.7.8-165-g0579f91, grep.h includes
thread-utils.h, so the latter has to be added to LIB_H.

Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
 Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 99a7a2b..e4f8e0e 100644
--- a/Makefile
+++ b/Makefile
@@ -615,6 +615,7 @@ LIB_H += streaming.h
 LIB_H += string-list.h
 LIB_H += submodule.h
 LIB_H += tag.h
+LIB_H += thread-utils.h
 LIB_H += transport.h
 LIB_H += tree.h
 LIB_H += tree-walk.h

-- 
ldv
