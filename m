From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH 04/10] Docs: git tag: other's -> the other person's
Date: Mon, 28 Mar 2011 14:51:20 +0000
Message-ID: <1301327622-8595-5-git-send-email-mfwitten@gmail.com>
References: <1301327622-8595-1-git-send-email-mfwitten@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 17:55:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4EmZ-0004Wa-IC
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 17:55:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754721Ab1C1Pyj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 11:54:39 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:49622 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754696Ab1C1Pyh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 11:54:37 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1202218eyx.19
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 08:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:message-id:x-mailer
         :in-reply-to:references:date;
        bh=9kJbHhp1vHsQGNHtejRxT6zf3b98CKg+sAoE3wLaQjY=;
        b=fhbl4AhmXblLdcvQ4ovOyiNGxSpRpr7lmYh4oj6OTh3pXaeJ1mIhJtQzcQLBsj+PZy
         GhMksfBna7buREmq2d/6jVSqgWrifhnbj7sV4/Ug1o8i5vEId4riUKj13v+CI/b+gtRy
         ASACZhptiW7zublq/wHZx+SXxl9hNlNPmN258=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:message-id:x-mailer:in-reply-to:references:date;
        b=DCF0fzSbhtaF2Km3Q0V5Gp2pd1y62bnDa0yFhk12zO440NNnvyiYZe5jwq4RR4NDP+
         X3ldxY+KGgW5EgXfmYWcbOTCPClV6yzqMZpGf89UiFyk1+EXg/dv3yrcRXYdnbZTzXYe
         6VTvbS9SGo9zIkqtW/LRe3W96vLCHVvyy+Crs=
Received: by 10.14.53.78 with SMTP id f54mr1835688eec.67.1301327677009;
        Mon, 28 Mar 2011 08:54:37 -0700 (PDT)
Received: from localhost.localdomain ([174.143.243.243])
        by mx.google.com with ESMTPS id v1sm2878807eeh.6.2011.03.28.08.54.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 Mar 2011 08:54:36 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.18.g68fe8
In-Reply-To: <1301327622-8595-1-git-send-email-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170142>

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 Documentation/git-tag.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 68eebee..b348c3d 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -208,8 +208,8 @@ becomes:
 $ git pull git://git..../proj.git master
 ------------
 
-In such a case, you do not want to automatically follow other's
-tags.
+In such a case, you do not want to automatically follow the other
+person's tags.
 
 One important aspect of git is it is distributed, and being
 distributed largely means there is no inherent "upstream" or
-- 
1.7.4.18.g68fe8
