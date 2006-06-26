From: Dennis Stosberg <dennis@stosberg.net>
Subject: [PATCH] Add possibility to pass CFLAGS and LDFLAGS specific to the perl subdir
Date: Tue, 27 Jun 2006 00:23:08 +0200
Message-ID: <20060626222308.G71066338@leonov.stosberg.net>
References: <20060625014703.29304.12715.stgit@machine.or.cz> <7vk676orjy.fsf@assigned-by-dhcp.cox.net> <20060626082428.G52c9608e@leonov.stosberg.net> <20060626082754.G6ec0a61e@leonov.stosberg.net> <7vwtb4i89d.fsf@assigned-by-dhcp.cox.net> <20060626094211.G3b49c5c3@leonov.stosberg.net> <20060626100402.G5761a3ea@leonov.stosberg.net> <7vd5cvj1d0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 27 00:23:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuzUS-00025V-Cw
	for gcvg-git@gmane.org; Tue, 27 Jun 2006 00:23:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbWFZWXN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Jun 2006 18:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbWFZWXN
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jun 2006 18:23:13 -0400
Received: from ncs.stosberg.net ([89.110.145.104]:42981 "EHLO ncs.stosberg.net")
	by vger.kernel.org with ESMTP id S1751212AbWFZWXL (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Jun 2006 18:23:11 -0400
Received: from leonov.stosberg.net (p213.54.83.220.tisdip.tiscali.de [213.54.83.220])
	by ncs.stosberg.net (Postfix) with ESMTP id 3E0EDAEBA065;
	Tue, 27 Jun 2006 00:22:58 +0200 (CEST)
Received: by leonov.stosberg.net (Postfix, from userid 500)
	id 9A8C9110C8D; Tue, 27 Jun 2006 00:23:08 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vd5cvj1d0.fsf@assigned-by-dhcp.cox.net>
OpenPGP: id=1B2F2863BA13A814C3B133DACC2811F494951CAB; url=http://stosberg.net/dennis.asc
User-Agent: mutt-ng/devel-r802 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22682>

Signed-off-by: Dennis Stosberg <dennis@stosberg.net>
---
 Makefile |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index f44fbd3..306025d 100644
--- a/Makefile
+++ b/Makefile
@@ -94,6 +94,8 @@ CFLAGS = -g -O2 -Wall
 LDFLAGS =
 ALL_CFLAGS = $(CFLAGS)
 ALL_LDFLAGS = $(LDFLAGS)
+PERL_CFLAGS =
+PERL_LDFLAGS =
 STRIP ?= strip
 
 prefix = $(HOME)
@@ -119,8 +121,8 @@ ### --- END CONFIGURATION SECTION ---
 
 # Those must not be GNU-specific; they are shared with perl/ which may
 # be built by a different compiler.
-BASIC_CFLAGS =
-BASIC_LDFLAGS =
+BASIC_CFLAGS = $(PERL_CFLAGS)
+BASIC_LDFLAGS = $(PERL_LDFLAGS)
 
 SCRIPT_SH = \
 	git-bisect.sh git-branch.sh git-checkout.sh \
-- 
1.4.1.rc1.g80bff-dirty
