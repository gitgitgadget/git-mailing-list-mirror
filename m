From: Techlive Zheng <techlivezheng@gmail.com>
Subject: [PATCH/RFC v2 3/8] contrib/subtree: Ignore testing directory
Date: Mon, 14 Jan 2013 11:52:16 +0800
Message-ID: <1358135541-10349-4-git-send-email-techlivezheng@gmail.com>
References: <1358041958-1998-1-git-send-email-techlivezheng@gmail.com>
 <1358135541-10349-1-git-send-email-techlivezheng@gmail.com>
Cc: apenwarr@gmail.com, greened@obbligato.org,
	Techlive Zheng <techlivezheng@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 14 04:59:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TubCk-0006Wq-R0
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 04:59:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755340Ab3AND6f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2013 22:58:35 -0500
Received: from mail-pa0-f53.google.com ([209.85.220.53]:57094 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754758Ab3AND6d (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 22:58:33 -0500
Received: by mail-pa0-f53.google.com with SMTP id hz1so1983292pad.26
        for <git@vger.kernel.org>; Sun, 13 Jan 2013 19:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=UUsAa2LTT7GUU+5e/yE5c3Y9+UggYxTMx/08MwvtChk=;
        b=ZQLDwHMMY5ezV2duO/Ioo7QXEv2Zg9nMNP5yJyxPhQSLJuSe9TRakt4dz4EiwkJjkU
         Fam5l+EIgWPlzdaeqG9WiN98WLWDgnRVXkWxuz6uf7Qp+q6cUq2csSfUerS0Pqx3ocT5
         dS9Cb63TO6q//G+x+64eUz+UQWVQIjy7esbzfkZoYxeIhsW2ogxltDqQG6PX8eIZ4zfJ
         AQV4E/SLl1ppLxBShs4PIB9v4f56IHVVzYmO/4OBQ1zRwMfXeU6IuKYXO8rXk0Ugr8eG
         4l3UkSzk8RfYA5bWD66Irt079cs0jJ6wZO+D1aS+XjSGP6O+Cvp5I4vJ3d7MkLUmEJ7i
         hRVA==
X-Received: by 10.66.88.37 with SMTP id bd5mr228778707pab.75.1358135912545;
        Sun, 13 Jan 2013 19:58:32 -0800 (PST)
Received: from home.techlive.me ([122.244.159.146])
        by mx.google.com with ESMTPS id kl3sm7400598pbc.15.2013.01.13.19.58.27
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 13 Jan 2013 19:58:31 -0800 (PST)
X-Mailer: git-send-email 1.8.1
In-Reply-To: <1358135541-10349-1-git-send-email-techlivezheng@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213423>

Signed-off-by: Techlive Zheng <techlivezheng@gmail.com>
---
 contrib/subtree/.gitignore | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/contrib/subtree/.gitignore b/contrib/subtree/.gitignore
index 91360a3..59aeeb4 100644
--- a/contrib/subtree/.gitignore
+++ b/contrib/subtree/.gitignore
@@ -1,6 +1,5 @@
 *~
 git-subtree
-git-subtree.xml
 git-subtree.1
-mainline
-subproj
+git-subtree.xml
+t/trash\ directory.*
-- 
1.8.1
