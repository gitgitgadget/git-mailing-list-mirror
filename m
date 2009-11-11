From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] gitk: Document the $GITK_TMPDIR variable
Date: Tue, 10 Nov 2009 17:49:09 -0800
Message-ID: <1257904149-44381-2-git-send-email-davvid@gmail.com>
References: <1257904149-44381-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: paulus@samba.org
X-From: git-owner@vger.kernel.org Wed Nov 11 02:49:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N82L4-0000oj-9e
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 02:49:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756549AbZKKBtW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2009 20:49:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756537AbZKKBtW
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 20:49:22 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:45361 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756506AbZKKBtV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2009 20:49:21 -0500
Received: by yxe17 with SMTP id 17so577013yxe.33
        for <git@vger.kernel.org>; Tue, 10 Nov 2009 17:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=7Dpaqvj2OL/jwR4LoCxsAVgPGWT7IVEYcitfey9VOsk=;
        b=VbtJA7LHAbcXWMPz/R044NM6FFyVcVErbeR0WO7yYysj4FKtkGDtmoucSfYdrLmRDn
         BWU/EGaLGETrQDJuivqawom8E4c2YVWpz6Kyzw0bdB2gJxPTJqrHCvPRLsIORbWIWa4m
         NlyZOOKqQcZuv81YjOaJIqA2WXO1w4Q7+reVE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=u3MDgroy7rHl6zzzvW2gdVlnwsWm91TCVFc/ZOuZt72kFlobe6eJgqzRqKYEjYIRuS
         CATTc7TOPp7dbC1frBSGbBAqP1KTTgOLulQwl5enyMJmXXDqMhJLzlJTRrFVdgIPazGt
         JEJ4/NzHjvprDPp6KStM6phyxK9pUY8GAypSM=
Received: by 10.150.56.1 with SMTP id e1mr1568171yba.225.1257904167062;
        Tue, 10 Nov 2009 17:49:27 -0800 (PST)
Received: from localhost (wdas-1.disneyanimation.com [12.188.26.1])
        by mx.google.com with ESMTPS id 13sm613690gxk.9.2009.11.10.17.49.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 10 Nov 2009 17:49:26 -0800 (PST)
X-Mailer: git-send-email 1.6.5.2.180.gc5b3e
In-Reply-To: <1257904149-44381-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132610>

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 Documentation/gitk.txt |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
index cf465cb..7e184f3 100644
--- a/Documentation/gitk.txt
+++ b/Documentation/gitk.txt
@@ -100,6 +100,11 @@ Files
 Gitk creates the .gitk file in your $HOME directory to store preferences
 such as display options, font, and colors.
 
+Environment Variables
+---------------------
+Gitk honors the $GITK_TMPDIR environment when creating temporary
+files and directories.
+
 SEE ALSO
 --------
 'qgit(1)'::
-- 
1.6.5.2.180.gc5b3e
