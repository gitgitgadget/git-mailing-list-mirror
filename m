From: Dennis Stosberg <dennis@stosberg.net>
Subject: [PATCH 1/6] Solaris has strlcpy() at least since version 8
Date: Tue, 15 Aug 2006 11:01:20 +0200
Message-ID: <20060815090120.5223.47263.stgit@leonov.stosberg.net>
References: <20060815090031.5223.27458.stgit@leonov.stosberg.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Tue Aug 15 11:01:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCunp-0001xX-WA
	for gcvg-git@gmane.org; Tue, 15 Aug 2006 11:01:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932750AbWHOJB2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Aug 2006 05:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932766AbWHOJB2
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Aug 2006 05:01:28 -0400
Received: from ncs.stosberg.net ([89.110.145.104]:62143 "EHLO ncs.stosberg.net")
	by vger.kernel.org with ESMTP id S932750AbWHOJB1 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Aug 2006 05:01:27 -0400
Received: from leonov.stosberg.net (p213.54.74.221.tisdip.tiscali.de [213.54.74.221])
	by ncs.stosberg.net (Postfix) with ESMTP id D24DDAEBA02E
	for <git@vger.kernel.org>; Tue, 15 Aug 2006 11:01:19 +0200 (CEST)
Received: from leonov.stosberg.net (leonov.stosberg.net [127.0.0.1])
	by leonov.stosberg.net (Postfix) with ESMTP id B953F12173A
	for <git@vger.kernel.org>; Tue, 15 Aug 2006 11:01:20 +0200 (CEST)
To: git@vger.kernel.org
In-Reply-To: <20060815090031.5223.27458.stgit@leonov.stosberg.net>
User-Agent: StGIT/0.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25448>

See http://docs.sun.com/app/docs/doc/816-3321/6m9k23sjk?a=view

Signed-off-by: Dennis Stosberg <dennis@stosberg.net>
---

 Makefile |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 66c4fcc..495631a 100644
--- a/Makefile
+++ b/Makefile
@@ -338,7 +338,6 @@ ifeq ($(uname_S),SunOS)
 	NEEDS_NSL = YesPlease
 	SHELL_PATH = /bin/bash
 	NO_STRCASESTR = YesPlease
-	NO_STRLCPY = YesPlease
 	ifeq ($(uname_R),5.8)
 		NEEDS_LIBICONV = YesPlease
 		NO_UNSETENV = YesPlease
