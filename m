From: William Pursell <bill.pursell@gmail.com>
Subject: [PATCH] Fix error in user manual
Date: Tue, 03 Feb 2009 22:41:14 +0000
Message-ID: <4988C80A.4080203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 03 23:43:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUTyh-0001JM-Vj
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 23:42:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752065AbZBCWlW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 17:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751966AbZBCWlV
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 17:41:21 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:37429 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751981AbZBCWlV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 17:41:21 -0500
Received: by ewy14 with SMTP id 14so2944222ewy.13
        for <git@vger.kernel.org>; Tue, 03 Feb 2009 14:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=cuJU8wx9HdktmIgTXI0S8blM2kK4DvuoW3rlne65Rt0=;
        b=kTk4vO3gNhxe+rGsgVrsMTCaOxeJtO2XSWwyM0no6ScSiEDbeRMBwjugmzzYsQaQEF
         Px+jisXVgJLVUY3TySX+E+mOtoI2BanvWaVkhzCxoFPJwvGjh8+FK8C0034QTk8DszQ1
         l1p/0Rg8tdLhS2tJardYM3UF5umGbrs2Tuw/I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=oXzhn3ZH0mpEVYOlKAMelz+vEOYmv2UG1JVWIfIh+Jqvy/EcYdk/qtF6RkS2PYVxB9
         YdHBmwN746q4snBK2Sywi7YqzU+FnhRs52M8OtnLGHMIppanGqRe8F/EEwozcbhciYDc
         tPIkLAsV6JtR6TG56VOEl+wt91ZggwEF21eY0=
Received: by 10.211.196.13 with SMTP id y13mr3491818ebp.79.1233700879559;
        Tue, 03 Feb 2009 14:41:19 -0800 (PST)
Received: from clam.local (5ad36962.bb.sky.com [90.211.105.98])
        by mx.google.com with ESMTPS id j8sm1100978gvb.33.2009.02.03.14.41.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 03 Feb 2009 14:41:18 -0800 (PST)
User-Agent: Thunderbird 2.0.0.19 (Macintosh/20081209)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108257>

Fix error in user manual

Signed-off-by: William Pursell <bill.pursell@gmail.com>
---
 Documentation/user-manual.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 19f571a..96af897 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1507,7 +1507,7 @@ so on a different branch and then coming back), unstash the
 work-in-progress changes.

 ------------------------------------------------
-$ git stash "work in progress for foo feature"
+$ git stash save "work in progress for foo feature"
 ------------------------------------------------

 This command will save your changes away to the `stash`, and
-- 
1.6.1.2.461.g5bad6


-- 
William Pursell
