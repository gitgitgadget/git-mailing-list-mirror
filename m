From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH] Add "install-html" rule to top level Makefile
Date: Tue, 19 Feb 2008 09:25:07 -0500
Message-ID: <1203431107-60128-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 19 15:26:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRTPr-0000Q7-4b
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 15:25:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755254AbYBSOZO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 09:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754677AbYBSOZO
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 09:25:14 -0500
Received: from an-out-0708.google.com ([209.85.132.241]:7898 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754355AbYBSOZL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 09:25:11 -0500
Received: by an-out-0708.google.com with SMTP id d31so501331and.103
        for <git@vger.kernel.org>; Tue, 19 Feb 2008 06:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:cc:mime-version:content-type:content-transfer-encoding;
        bh=43lPdyKSYATYeqh/m+XXg1e5U2fL5gSR5iZGgWd/cD0=;
        b=fPotrdmpF/h7Kio97pJvlbYDb+k+W1gnClwnZxTWsctYC/FahA1mH6ad9krOPX4/zrA/Ja0IYKeMQo1aHOsnixLDlJV7lPL6dLkxDUy1HYNg2DnERwvc5d+KUHPqiw3ovHTjtzL2o1W4hy1Uf6xurCxdPlxgK5SFp5ON31IxsDU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=NvYoWqx6ToCmV582k13rA2sFwn0XOmhmZZzxuXVE+HfxWTOPDwpe+8DdlqEDsL7j4DsmVUqIeMc6UyLdqDhm0Jy4cxoZQIIAHqKPf45li+ARkQKL8RfMP1zuL2dtNXk2CVoSwd2k8JQ9m72ytwscJVI6srnNyRMIpkH+UJCjM/8=
Received: by 10.100.195.15 with SMTP id s15mr14284934anf.61.1203431110578;
        Tue, 19 Feb 2008 06:25:10 -0800 (PST)
Received: from localhost ( [75.189.159.45])
        by mx.google.com with ESMTPS id c9sm13313831ana.35.2008.02.19.06.25.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Feb 2008 06:25:09 -0800 (PST)
X-Mailer: git-send-email 1.5.4.2.203.g1b97.dirty
CC: Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74411>

Add "install-html" rule to top level Makefile

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 Makefile |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 554e29f..8db0361 100644
--- a/Makefile
+++ b/Makefile
@@ -1093,6 +1093,8 @@ install-info:
 quick-install-doc:
 	$(MAKE) -C Documentation quick-install
 
+install-html:
+	$(MAKE) -C Documentation install-html
 
 
 ### Maintainer's dist rules
-- 
1.5.4.2.203.g1b97.dirty
