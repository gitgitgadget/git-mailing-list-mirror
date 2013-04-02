From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 02/13] remote-hg: add missing config variable in doc
Date: Tue,  2 Apr 2013 13:02:51 -0600
Message-ID: <1364929382-1399-3-git-send-email-felipe.contreras@gmail.com>
References: <1364929382-1399-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>, Dusty Phillips <dusty@linux.ca>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 02 21:04:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN6Va-0006r2-On
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 21:04:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106Ab3DBTEG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 15:04:06 -0400
Received: from mail-gg0-f180.google.com ([209.85.161.180]:36072 "EHLO
	mail-gg0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932451Ab3DBTED (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 15:04:03 -0400
Received: by mail-gg0-f180.google.com with SMTP id e5so113899ggk.11
        for <git@vger.kernel.org>; Tue, 02 Apr 2013 12:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=IRdlnoSYQjUg72E63/HMAOwHjomhZsyEAMNKdcOv1z0=;
        b=SYcjdrZKTVTziUmQmru6C3QfX/l33Itm/zNOJdoOmiBi3QYZzNtE+sB5dMKR+rP49q
         sRcktz+yogtb5OLYCrY8/WBgAc/i4TFUnrw3xphVuvcbQrAP5LmN6Q73wQeDBDVKWgf5
         jKttHuoeMFwKqFjsDhHqTLGdvQa2b+gGDPdQLL0CsyXZnGHE6y/5z/adR7XS/QHfG8eo
         qBFyxDl9hIbDpdnKFnhjZONp+qP/BLYs1IvnLKDau8yEaFPYwSpMY/FfJrP6zidyAU0U
         ADqFGk7/eadTgTaxWphyxkTGK9Ohlo0yX9EbGm6Sbo+BsAElLGEHvJSKz6HDb220dbQJ
         NjXg==
X-Received: by 10.236.190.200 with SMTP id e48mr15875149yhn.137.1364929442918;
        Tue, 02 Apr 2013 12:04:02 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id u77sm4760469yhe.27.2013.04.02.12.04.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Apr 2013 12:04:02 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1364929382-1399-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219833>

From: Dusty Phillips <dusty@linux.ca>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index d0dfb1e..844ec50 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -23,6 +23,10 @@ import urllib
 # If you want to switch to hg-git compatibility mode:
 # git config --global remote-hg.hg-git-compat true
 #
+# If you are not in hg-git-compat mode and want to disable the tracking of
+# named branches:
+# git config --global remote-hg.track-branches false
+#
 # git:
 # Sensible defaults for git.
 # hg bookmarks are exported as git branches, hg branches are prefixed
-- 
1.8.2
