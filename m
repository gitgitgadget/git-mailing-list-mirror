From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 19/21] remote-hg: document location of stored hg repository
Date: Thu, 11 Apr 2013 07:23:15 -0500
Message-ID: <1365682997-11329-20-git-send-email-felipe.contreras@gmail.com>
References: <1365682997-11329-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Simon Ruderich <simon@ruderich.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 11 14:25:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQGZQ-0008SZ-8U
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 14:25:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161557Ab3DKMZe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 08:25:34 -0400
Received: from mail-qa0-f43.google.com ([209.85.216.43]:46908 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161537Ab3DKMZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 08:25:26 -0400
Received: by mail-qa0-f43.google.com with SMTP id i13so236780qae.9
        for <git@vger.kernel.org>; Thu, 11 Apr 2013 05:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=iJWcgKk46V1EOUJp1SjdlQzWmYXNuJXGV+WwobN0ifE=;
        b=CYzyb3zeYtQXgOMnbkEmQeWHojyDTdKWjW1y+C1G7EExPcfbWXDSsdSbOOJCUsJK1D
         DgturLi0EBeSX0htnG1Ah381xSj5D08CineRcaea+KPlPiH2T9AntLzlpUylNGSe5Tms
         L+NccmpNLwbcmqgiMbMe+EsyU5IsHSpxfx+9z1u4LoRxk/rjQ7O97hj28/HGwOCg41Ow
         DFxFbyn4KhHWkJ/fp7+8UgKTvNZCbvaG9mIWCy92a+uLvWVqzz9vKLCZpazKIK624T+O
         tpE0MPsd8O1Uot3cPhe3KIkqmlJ6pwaDUZdToH+WDnP5wzDjFxsqkjQJAvgZTVpDRiPx
         +MOw==
X-Received: by 10.224.181.2 with SMTP id bw2mr6898662qab.64.1365683125641;
        Thu, 11 Apr 2013 05:25:25 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id t3sm6288629qen.5.2013.04.11.05.25.23
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 11 Apr 2013 05:25:24 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1365682997-11329-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220871>

From: Simon Ruderich <simon@ruderich.org>

Signed-off-by: Simon Ruderich <simon@ruderich.org>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index e3d7f77..0db4cca 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -8,6 +8,9 @@
 # Just copy to your ~/bin, or anywhere in your $PATH.
 # Then you can clone with:
 # git clone hg::/path/to/mercurial/repo/
+#
+# For remote repositories a local clone is stored in
+# "$GIT_DIR/hg/origin/clone/.hg/".
 
 from mercurial import hg, ui, bookmarks, context, util, encoding, node, error
 
-- 
1.8.2.1
