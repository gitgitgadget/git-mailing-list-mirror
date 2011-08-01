From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 2/2] Use specific diff rules for repo files
Date: Mon,  1 Aug 2011 12:37:49 +0200
Message-ID: <1312195069-10782-3-git-send-email-giuseppe.bilotta@gmail.com>
References: <1312195069-10782-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 01 12:38:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnptC-0008VH-2S
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 12:38:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753998Ab1HAKiT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 06:38:19 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:39829 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753981Ab1HAKiR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 06:38:17 -0400
Received: by mail-ww0-f44.google.com with SMTP id 5so5480638wwe.1
        for <git@vger.kernel.org>; Mon, 01 Aug 2011 03:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=twEabNXHDaQH7FJmFVI3ChHeYx/bRT/BaETVqiB575s=;
        b=EJAWpbjHK5C3nBAyl6nuz1Vedm+5eFjG2Dun+jKRigStyOh1Ivl9vZ8VTUbN276G9c
         hPeWikUcRnrcgPffOTsTm5XdLQG+BWqiDthXR2pwellQdIY44/q/4KkMNTC17gwsvH2q
         SRldKswyi20qukHh9MFvHh2CVrisX/go14O6w=
Received: by 10.216.69.130 with SMTP id n2mr548249wed.53.1312195096721;
        Mon, 01 Aug 2011 03:38:16 -0700 (PDT)
Received: from localhost ([151.54.121.1])
        by mx.google.com with ESMTPS id j54sm3234619wed.23.2011.08.01.03.38.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 01 Aug 2011 03:38:15 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.451.gcb935.dirty
In-Reply-To: <1312195069-10782-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178327>

Let's eat our own dogfood. (Also, this makes word diff much nicer on
git's own repo.)

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 .gitattributes |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/.gitattributes b/.gitattributes
index 5e98806..16930e6 100644
--- a/.gitattributes
+++ b/.gitattributes
@@ -1,3 +1,4 @@
 * whitespace=!indent,trail,space
-*.[ch] whitespace=indent,trail,space
-*.sh whitespace=indent,trail,space
+*.[ch] whitespace=indent,trail,space diff=cpp
+*.sh whitespace=indent,trail,space diff=shell
+*.perl diff=perl
-- 
1.7.6.451.gcb935.dirty
