From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2 04/16] git-merge-one-file: use a lowercase "usage:" string
Date: Sat, 23 Feb 2013 16:50:12 -0800
Message-ID: <1361667024-49776-5-git-send-email-davvid@gmail.com>
References: <1361667024-49776-1-git-send-email-davvid@gmail.com>
 <1361667024-49776-2-git-send-email-davvid@gmail.com>
 <1361667024-49776-3-git-send-email-davvid@gmail.com>
 <1361667024-49776-4-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 01:51:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9PoH-0007hj-RR
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 01:51:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759451Ab3BXAup (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2013 19:50:45 -0500
Received: from mail-pb0-f54.google.com ([209.85.160.54]:46508 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759390Ab3BXAun (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2013 19:50:43 -0500
Received: by mail-pb0-f54.google.com with SMTP id rr4so1058511pbb.27
        for <git@vger.kernel.org>; Sat, 23 Feb 2013 16:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=4aQU03BoUZRrhFYY7PHhJY8TURRTbFjhkpVPJVb6uPE=;
        b=ut0kSiu8i9ureoeTME9RQnB4xtrOcBv7d9pxf48G7ozqAbUfXz3DK1DjFMIz4QRhGQ
         1GyGPb30EK/14GVdm1d7dAwERFMAMO1NTmE/JdE3qXkS5r8zOaQuUCScrGZnIRK+C1Ej
         GBJ1EJaLpP0/aRVa9OToC286NDpaIslU7g1zkXR5JMD6B1kHPFZAp56XegwzsW5cUvn4
         LcVK+Vym6xAdww/WnajPjWRxgba6IK9owY2YBLVeMBOBAQvbQdUs93J/P3jnC4/xinCp
         IfKlJeNVLiC1TzPtCK77olz9NHXJi51odkRos9+eUZNHoxkFVY/VxI0zq4fyAcFNOf/B
         z22Q==
X-Received: by 10.66.8.138 with SMTP id r10mr11519930paa.211.1361667043174;
        Sat, 23 Feb 2013 16:50:43 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (remote-11.disneyanimation.com. [198.187.190.11])
        by mx.google.com with ESMTPS id a4sm8190345paw.21.2013.02.23.16.50.40
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 23 Feb 2013 16:50:42 -0800 (PST)
X-Mailer: git-send-email 1.8.2.rc0.263.g20d9441
In-Reply-To: <1361667024-49776-4-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216962>

Make the usage string consistent with Git.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-merge-one-file.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-merge-one-file.sh b/git-merge-one-file.sh
index f612cb8..3373c04 100755
--- a/git-merge-one-file.sh
+++ b/git-merge-one-file.sh
@@ -18,7 +18,7 @@
 
 USAGE='<orig blob> <our blob> <their blob> <path>'
 USAGE="$USAGE <orig mode> <our mode> <their mode>"
-LONG_USAGE="Usage: git merge-one-file $USAGE
+LONG_USAGE="usage: git merge-one-file $USAGE
 
 Blob ids and modes should be empty for missing files."
 
-- 
1.8.2.rc0.263.g20d9441
