From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH] Documentation: update-index: -z applies also to --index-info
Date: Fri,  8 Oct 2010 08:50:20 +0200
Message-ID: <de35ea7e5fe3d3ad9ce184c493dd6022cbf90f92.1286520581.git.bert.wesarg@googlemail.com>
References: <AANLkTimWOWHfLtiP8BkQ8ORMhjiyiAZm7Gn+OmQ2USfT@mail.gmail.com>
Cc: git@vger.kernel.org,
	=?UTF-8?q?=C5=A0t=C4=9Bp=C3=A1n=20N=C4=9Bmec?= <stepnem@gmail.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 08 08:50:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P46mk-0008KX-Dv
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 08:50:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752198Ab0JHGuZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Oct 2010 02:50:25 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42394 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751822Ab0JHGuZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Oct 2010 02:50:25 -0400
Received: by fxm14 with SMTP id 14so254505fxm.19
        for <git@vger.kernel.org>; Thu, 07 Oct 2010 23:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=rBO3ghqEetfKDE7PiB61SLW7qHR3jhQK4lZZZkAJzho=;
        b=BzS2INpP/xZic4y3niz5gGXKV7rs8eVDc3UGNDeAf0zGbVavyxWevi1yMNrsxE4mid
         XVipR2AgBqDNqGYXtNWwxucDU6gn24crG7Z/tV1KCpsVbfDlC49q9eaCLwsvq8n7ELZS
         VJGFdjrIBClNIlFLZm4cCxSQ7msNvfNPUmOX8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=g+4BO5DGXeBlJ/aPWmtM1XR0tOIY/4+oclbZGd6E/6bOVnUuXq/1hi4n0pxA0KyOTY
         mKaBouXoTelRHwZOOT9lOQ5r9+6pq3rp3z+O+Yo7Zzq2uIkK3vtN7TwonZvOSy0kCvOc
         pMk04ErteDdRLfrXG6iVnh3RlhGk+SBTjeEmE=
Received: by 10.223.1.144 with SMTP id 16mr2322048faf.32.1286520623793;
        Thu, 07 Oct 2010 23:50:23 -0700 (PDT)
Received: from localhost (p5B0F732C.dip.t-dialin.net [91.15.115.44])
        by mx.google.com with ESMTPS id m8sm1277222faj.11.2010.10.07.23.50.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 07 Oct 2010 23:50:22 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.1067.g5aeb7
In-Reply-To: <AANLkTimWOWHfLtiP8BkQ8ORMhjiyiAZm7Gn+OmQ2USfT@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158477>

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 Documentation/git-update-index.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 74d1d49..26fd8d0 100644 Documentation/git-update-index.txt
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -144,8 +144,8 @@ you will need to handle the situation manually.
         Report what is being added and removed from index.
 
 -z::
-	Only meaningful with `--stdin`; paths are separated with
-	NUL character instead of LF.
+	Only meaningful with `--stdin` or `--index-info`; paths are
+	separated with NUL character instead of LF.
 
 \--::
 	Do not interpret any more arguments as options.
-- 
1.7.1.1067.g5aeb7
