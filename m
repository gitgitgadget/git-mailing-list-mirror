From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 19/20] remote-hg: document location of stored hg repository
Date: Mon,  8 Apr 2013 12:13:33 -0500
Message-ID: <1365441214-21096-20-git-send-email-felipe.contreras@gmail.com>
References: <1365441214-21096-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>, Simon Ruderich <simon@ruderich.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 08 19:16:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPFft-0005gW-7y
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 19:16:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934850Ab3DHRPo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 13:15:44 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:40656 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760775Ab3DHRPn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 13:15:43 -0400
Received: by mail-oa0-f50.google.com with SMTP id n1so6511692oag.9
        for <git@vger.kernel.org>; Mon, 08 Apr 2013 10:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=h0PpNeJksfRTJ1o7KyRgPFybA2xTLxBdb7sdLUlbfM8=;
        b=L6L4EUqWDwe8uldhOS8O/0/2GTMXTS/wnljClWSczFr6TvKnggCzqmRwlifwJ2fMMa
         CE96wGYsQetpDKzdWkoYAYxPik3XGbFa/D7CrC+qgDWv/Gc/+QYrxHoumWcpeLNVVXJ7
         d/d7cq0lhsMNTnl+cXk4gFPUBGeZNBk9ljKJ1DjLEJnwFS6Nl551PLzF86I6jdfL1lTN
         E04DnUUO9RBlHEdHhbJwRKara+spHrb4h+D/2GWMGN1Puy6iHpb07nHUA/AxwDXNHaAi
         TijtPx8AoTQ/3KW/mY2gxmvNVWuYd31Z4e1lhE/hTBUx3r74MA1Ts0K6nCBbpT7aTwGw
         Y4nA==
X-Received: by 10.182.125.132 with SMTP id mq4mr4499890obb.79.1365441342552;
        Mon, 08 Apr 2013 10:15:42 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id sb6sm1820780obb.11.2013.04.08.10.15.40
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Apr 2013 10:15:41 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1365441214-21096-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220459>

From: Simon Ruderich <simon@ruderich.org>

Signed-off-by: Simon Ruderich <simon@ruderich.org>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index a02ec68..37e6aec 100755
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
1.8.2
