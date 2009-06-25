From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv6 3/8] gitweb: right-align date cell in shortlog
Date: Thu, 25 Jun 2009 12:43:02 +0200
Message-ID: <1245926587-25074-4-git-send-email-giuseppe.bilotta@gmail.com>
References: <1245926587-25074-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1245926587-25074-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1245926587-25074-3-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 25 12:44:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJmQw-0008IK-Gs
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 12:43:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757469AbZFYKnY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2009 06:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757456AbZFYKnV
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 06:43:21 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:47512 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757203AbZFYKnM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2009 06:43:12 -0400
Received: by mail-bw0-f213.google.com with SMTP id 9so1301579bwz.37
        for <git@vger.kernel.org>; Thu, 25 Jun 2009 03:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=GezDM5Jcf4a/qAKIsnpw8I4pw64bv6Rs2IlXFukfhL0=;
        b=greZKHWKV44ZA9b/N22W+4WMQuNk3Q7cAvfXmyRc7yHr6cLSOUkii3zhsPNQtNOeIN
         2mtGHsvGQALjB5UbIDujIfJjZroLKl6eas1phvQU6Why8UnMSVkZKtzi8NVUjpH801mz
         I1thofIYgSBsEttThB3GHCwcSFdXM1e7o8sBQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Ml88szzzUex/lDox7dwt6ocWykS+pGqTrLI5vsLq1kHDBtQ+iQ7cweNmDHxVrMT9Or
         BpVH80lB1Yc80bNtue5+9qd5QVYIgH0Xq+Z9JtvLcOJuS5WJzpnDnzEeqhmzPxu9EqYK
         V7GO8xh3FgjSMVur6jWBknQ4jY8ZtRvkFeSZc=
Received: by 10.204.66.17 with SMTP id l17mr2344260bki.44.1245926595019;
        Thu, 25 Jun 2009 03:43:15 -0700 (PDT)
Received: from localhost (dynamic-adsl-94-37-13-28.clienti.tiscali.it [94.37.13.28])
        by mx.google.com with ESMTPS id p17sm3219452fka.12.2009.06.25.03.43.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Jun 2009 03:43:14 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.rc1.192.gdbfcb
In-Reply-To: <1245926587-25074-3-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122199>

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.css |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index 68b22ff..7240ed7 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -180,6 +180,10 @@ table {
 	border-spacing: 0;
 }
 
+table.shortlog td:first-child{
+	text-align: right;
+}
+
 table.diff_tree {
 	font-family: monospace;
 }
-- 
1.6.3.rc1.192.gdbfcb
