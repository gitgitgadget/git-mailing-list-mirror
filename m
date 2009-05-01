From: "Daniel Cheng (aka SDiZ)" <j16sdiz+freenet@gmail.com>
Subject: [PATCH EGIT 2/2] Enable "jgit show-ref"
Date: Fri,  1 May 2009 18:36:12 +0800
Message-ID: <1241174172-19581-2-git-send-email-git@sdiz.net>
References: <1241174172-19581-1-git-send-email-git@sdiz.net>
Cc: git@vger.kernel.org, "Daniel Cheng (aka SDiZ)" <git@sdiz.net>
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri May 01 12:36:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lzq6X-00040b-Mu
	for gcvg-git-2@gmane.org; Fri, 01 May 2009 12:36:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754694AbZEAKgW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2009 06:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754774AbZEAKgV
	(ORCPT <rfc822;git-outgoing>); Fri, 1 May 2009 06:36:21 -0400
Received: from wf-out-1314.google.com ([209.85.200.171]:10552 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753451AbZEAKgU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2009 06:36:20 -0400
Received: by wf-out-1314.google.com with SMTP id 26so1756260wfd.4
        for <git@vger.kernel.org>; Fri, 01 May 2009 03:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=74HRZowVubUpxLMxsTTNia/bAQFIN+SybKp4v7mDaGQ=;
        b=Jm9HWOJiXszd6Vc024+xea/8cs0hUS64OgBBQkrKDfmRKw8Bh+CiRNePw7yXR62XSK
         E3e2KlxJyY4EOHsQae4biTwbRi5469eSbdxLSYsTe4zGn/xqAmnZgdJQR6iBpaVZYWO9
         wsNMDVB+zVTQo7ZTWtywYeDsVY5uI7WYO9tVc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=nFQB9ve9TH0l4iS48Jnclu2KPsqbNfEnLhw7AFo8fr854+FEJh6pVvCz9jWnfsoch3
         oVmXu374gIl59eG0z8v1K46KpQztGcZQb7tuYylAvNRwK55xqngon39Akz3sbDN6Fboe
         83sME7c6YDveuLIUspklWKAUbTieoozXJ40mM=
Received: by 10.142.216.18 with SMTP id o18mr846410wfg.251.1241174180005;
        Fri, 01 May 2009 03:36:20 -0700 (PDT)
Received: from localhost.localdomain (n1164956087.netvigator.com [116.49.56.87])
        by mx.google.com with ESMTPS id 20sm8582236wfi.20.2009.05.01.03.36.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 01 May 2009 03:36:19 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <1241174172-19581-1-git-send-email-git@sdiz.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118074>


Signed-off-by: Daniel Cheng (aka SDiZ) <git@sdiz.net>
---
org.spearce.jgit.pgm.ShowRef exists, but never enabled.
this patch enable this command


 .../services/org.spearce.jgit.pgm.TextBuiltin      |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit.pgm/src/META-INF/services/org.spearce.jgit.pgm.TextBuiltin b/org.spearce.jgit.pgm/src/META-INF/services/org.spearce.jgit.pgm.TextBuiltin
index 7e24516..3a8cc09 100644
--- a/org.spearce.jgit.pgm/src/META-INF/services/org.spearce.jgit.pgm.TextBuiltin
+++ b/org.spearce.jgit.pgm/src/META-INF/services/org.spearce.jgit.pgm.TextBuiltin
@@ -16,6 +16,7 @@ org.spearce.jgit.pgm.RevList
 org.spearce.jgit.pgm.RevParse
 org.spearce.jgit.pgm.Rm
 org.spearce.jgit.pgm.ShowRev
+org.spearce.jgit.pgm.ShowRef
 org.spearce.jgit.pgm.Tag
 org.spearce.jgit.pgm.UploadPack
 org.spearce.jgit.pgm.Version
-- 
1.6.2.1
