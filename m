From: Ian Hilt <ian.hilt@gmail.com>
Subject: [PATCH] Rephrased git-describe description
Date: Wed, 14 May 2008 10:22:27 -0400
Message-ID: <1210774947-27995-1-git-send-email-ian.hilt@gmail.com>
Cc: Ian Hilt <ian.hilt@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 14 16:23:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwHsz-00016i-Vt
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 16:23:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754577AbYENOWW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 10:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753748AbYENOWW
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 10:22:22 -0400
Received: from an-out-0708.google.com ([209.85.132.248]:19244 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752830AbYENOWV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 10:22:21 -0400
Received: by an-out-0708.google.com with SMTP id d40so688095and.103
        for <git@vger.kernel.org>; Wed, 14 May 2008 07:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=mO2sQjWaVmkrIc3FQYzw32OqPLvH4de6dCjCffMEqSA=;
        b=uRzyTRRTg2bzWvoqv0TPFPH6hhSRyvAmd7un1ueRjA+IjW+1dpDbg1Kvu0CvkFRnCpl7zmIvitg1OqSdGwEEb5u2XbHDE38gxAwwR0OdoFXKZAOJA3ciD/v5wwJLfrOMSFqL/4av9Gh29q81OBYeOddLz6nZ3MtxK9Fop0O5VhA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=kjaFC6U4MHVEhLiP9zD8WR4N65ZGqn9YsPupGU5V+XURF8g1MWKZ5t6HeDikzYUFgaZd15W8TO88l+zzJXNB7R5r3JYG9N7sufL/VMdqAbRRi92OFLCuNIg4Nj/YXz15OFzRspZbYsCQMl9G9CrIlHaubuI8KgblvjrXGPjkZmw=
Received: by 10.100.229.12 with SMTP id b12mr1284926anh.60.1210774938186;
        Wed, 14 May 2008 07:22:18 -0700 (PDT)
Received: from sys-0 ( [75.185.208.72])
        by mx.google.com with ESMTPS id b19sm2359920ana.19.2008.05.14.07.22.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 14 May 2008 07:22:16 -0700 (PDT)
Received: by sys-0 (sSMTP sendmail emulation); Wed, 14 May 2008 10:22:27 -0400
X-Mailer: git-send-email 1.5.3.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82099>

Made description more readable.

Signed-off-by: Ian Hilt <ian.hilt@gmail.com>
---
 Documentation/git-describe.txt |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index d9aa2f2..f3f07e4 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -13,9 +13,10 @@ SYNOPSIS
 DESCRIPTION
 -----------
 The command finds the most recent tag that is reachable from a
-commit, and if the commit itself is pointed at by the tag, shows
-the tag.  Otherwise, it suffixes the tag name with the number of
-additional commits and the abbreviated object name of the commit.
+commit.  If the tag points to the commit, then only the tag is
+shown.  Otherwise, the number of additional commits on top of the
+tagged object and the abbreviated object name of the most recent
+commit are suffixed to the tag name.
 
 
 OPTIONS
-- 
1.5.3.7
