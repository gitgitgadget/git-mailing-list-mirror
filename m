From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: [PATCH GSoC 2/4] gitweb: Set default destination directory for installing gitweb in Makefile
Date: Fri, 28 May 2010 11:55:50 +0530
Message-ID: <1275027952-5057-2-git-send-email-pavan.sss1991@gmail.com>
References: <1275027952-5057-1-git-send-email-pavan.sss1991@gmail.com>
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
To: git@vger.kernel.org, chriscool@tuxfamily.org, pasky@ucw.cz,
	jnareb@gmail.com
X-From: git-owner@vger.kernel.org Fri May 28 08:26:47 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHt1l-0002OT-Ap
	for gcvg-git-2@lo.gmane.org; Fri, 28 May 2010 08:26:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752929Ab0E1G0g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 May 2010 02:26:36 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64578 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988Ab0E1G0f (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 May 2010 02:26:35 -0400
Received: by mail-pw0-f46.google.com with SMTP id 3so138208pwi.19
        for <git@vger.kernel.org>; Thu, 27 May 2010 23:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=PVk+UPWKK4gQD5IVGXGa4m56qeOHsBcTCxdzbXAdyzA=;
        b=u5WMzpr/zwYw/9KOETTUpFKMvwg9vUS1sihi15XpAJCMEQTLgwIfPnXhlmV3yluNd8
         zLdAr7uHdD1JQc1eW7GTrsONxCzNbouNoZ3wrN7++jKnEVHzZJSHwEUp6qxu1+F6d95x
         J+IjwxnySsijGJ+/a+cVzyhBQypoW3CWKPzvc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=lfal2SseFW13vV7Yr04eG2didO1j0DNbvXNtg6J/YJoE51LA02g0bP6MelTQEOD37l
         lAo5UuGsHx1laPEt38sryGHBsNkhvUIXE8xE/CxP9ZN4tBG0R2GDFYKsthyxLaL4Ixgf
         5JdvHvo/yzRC/NNP4XEFCqSnkrcGSqsgHq2XA=
Received: by 10.141.188.4 with SMTP id q4mr966812rvp.147.1275027987896;
        Thu, 27 May 2010 23:26:27 -0700 (PDT)
Received: from localhost.localdomain ([202.63.112.23])
        by mx.google.com with ESMTPS id b10sm1802683rvn.3.2010.05.27.23.26.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 27 May 2010 23:26:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.18.gf661c6.dirty
In-Reply-To: <1275027952-5057-1-git-send-email-pavan.sss1991@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147915>

Currently installing gitweb requires to give a target directory
(via 'gitwebdir' build variable).  Giving it a default value
protects against user errors.

Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Petr Baudis <pasky@ucw.cz>
Acked-by: Jakub Narebski <jnareb@gmail.com>
---
 Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index de7f680..caf2f64 100644
--- a/Makefile
+++ b/Makefile
@@ -269,6 +269,7 @@ mandir = share/man
 infodir = share/info
 gitexecdir = libexec/git-core
 sharedir = $(prefix)/share
+gitwebdir = $(sharedir)/gitweb
 template_dir = share/git-core/templates
 htmldir = share/doc/git-doc
 ifeq ($(prefix),/usr)
-- 
1.7.1.18.gf661c6.dirty
