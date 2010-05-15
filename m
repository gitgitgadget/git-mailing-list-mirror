From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: [PATCHv2 GSoC 1/3] gitweb: Set default destination directory for installing gitweb in Makefile
Date: Sun, 16 May 2010 01:28:38 +0530
Message-ID: <1273953520-25990-1-git-send-email-pavan.sss1991@gmail.com>
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 15 21:59:02 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODNVl-00037u-AQ
	for gcvg-git-2@lo.gmane.org; Sat, 15 May 2010 21:59:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752998Ab0EOT64 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 May 2010 15:58:56 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:52141 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751830Ab0EOT6z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 May 2010 15:58:55 -0400
Received: by pwi10 with SMTP id 10so1177682pwi.19
        for <git@vger.kernel.org>; Sat, 15 May 2010 12:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=fW3aXObjrN/xnq3wkKyhFL4Q2g38mMwmp3wpapjEIAc=;
        b=Sqd6rbQT/teGG/0YCNpzF79jYQzov90Ym8GBGU580Xv0/efVlRC2JmaTRMPynbGgiA
         i/6IjisnjGI5086MqERMxTrwksYsrO65WXy+oOTM5JOqvMJlMd+7Ykb/uQCuDbxxZOlF
         LRdnOiNPtMZxCvQGr8AhVc0vr/TdT3UMYeSBQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Kj6DfvKIFmWtXA6nO3NPm4YCGerXM9HDaWZOWXeTodZgMvVfpbRU+2mKQ0uN+u7ocJ
         VlzdS19bowswyYk6x4wQlmSODi3MmnDxmyZ1+fcSzDsU4982xitEiTqt2M8Nfl8NDWrq
         l7b8pSxtemR73MoLYeDpc95NeatBGSE04xbEI=
Received: by 10.114.187.7 with SMTP id k7mr2534896waf.92.1273953534715;
        Sat, 15 May 2010 12:58:54 -0700 (PDT)
Received: from localhost.localdomain ([202.63.112.23])
        by mx.google.com with ESMTPS id v13sm32432688wav.14.2010.05.15.12.58.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 15 May 2010 12:58:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.16.g5d405c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147160>

Currently installing gitweb requires to give a target directory
(via 'gitwebdir' build variable).  Giving it a default value
protects against user errors.

Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
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
1.7.1.16.g5d405c.dirty
