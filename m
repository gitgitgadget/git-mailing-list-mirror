From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH] Add "install-html" rule to top level Makefile
Date: Fri, 25 Jul 2008 12:55:27 -0400
Message-ID: <1217004927-75826-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 25 18:56:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMQan-0004sj-1U
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 18:56:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbYGYQzd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 12:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbYGYQzc
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 12:55:32 -0400
Received: from wr-out-0506.google.com ([64.233.184.236]:9461 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146AbYGYQzc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 12:55:32 -0400
Received: by wr-out-0506.google.com with SMTP id 69so2448785wri.5
        for <git@vger.kernel.org>; Fri, 25 Jul 2008 09:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=tsclo/Qc3fXrqRJhcjbqZiaUQ3FA/+aSZ0IwYvWSiYM=;
        b=M+POjzG6W+k2cpEowHTRxi+htFuwcMwGh/g5O8+MH0BskFzZkCPPK4U10dG6Fmqemr
         6rGihMnqaxMle3jlqYVa7HBCj2xE1R4gSKeb6/WqXbsebhIR59FebWM6PdCgcKbgNt00
         KOX3+EJ9VO8LKCRYssXF+v1l+DytXtXKQShiQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=sATD4oHGiBSpmzLZxJJKHvPvqyyCvWimnAUJRVkDdbo9/onx5hvV3bDT46Db5o50Qv
         1mStu39RSms5h7z9OIf9BTRIYhFqF88RBkZCe081WuJZlBnsr3AMnw5zsE9Z8mc/HOha
         xxx2kPHpdxOt1PvJVgbcqEURIXF9QMKYt4Gik=
Received: by 10.100.46.10 with SMTP id t10mr3344775ant.22.1217004931088;
        Fri, 25 Jul 2008 09:55:31 -0700 (PDT)
Received: from localhost ( [75.189.159.45])
        by mx.google.com with ESMTPS id 27sm11381986wra.32.2008.07.25.09.55.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 25 Jul 2008 09:55:30 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.rc0.155.g4fcc6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90071>

Add "install-html" rule to top level Makefile

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 Makefile |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index d029be3..74b6106 100644
--- a/Makefile
+++ b/Makefile
@@ -1355,6 +1355,8 @@ install-info:
 quick-install-doc:
 	$(MAKE) -C Documentation quick-install
 
+install-html:
+	$(MAKE) -C Documentation install-html
 
 
 ### Maintainer's dist rules
-- 
1.6.0.rc0.155.g4fcc6
