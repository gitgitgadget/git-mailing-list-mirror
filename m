From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 10/20] Format PackedObjectLoader class
Date: Sun, 15 Jun 2008 23:45:39 +0200
Message-ID: <1213566349-25395-11-git-send-email-marek.zawirski@gmail.com>
References: <1213566349-25395-1-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-2-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-3-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-4-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-5-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-6-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-7-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-8-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-9-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-10-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Jun 15 23:47:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K804o-0001nA-Nc
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 23:47:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753535AbYFOVqh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 17:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753345AbYFOVqh
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 17:46:37 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:49881 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753522AbYFOVqg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 17:46:36 -0400
Received: by fg-out-1718.google.com with SMTP id 19so3137938fgg.17
        for <git@vger.kernel.org>; Sun, 15 Jun 2008 14:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=i6iO47pd+LlNWI7lfO/kpCXYrryraumrq5SDC87Bkns=;
        b=WpzzvbYRnMBGXUKq7zS9IwvKEFo8MDBxxEslOCm1YEk89LhDyCEXdKyobWix7NKadg
         oa78x947KSJ1A/qhYjfuoWTqMFtGmmriMLeYlxNuqqP/DVsu0W07L1I5Wvpw9hzkieZ9
         BpKjHlF/X3e0tecJR2QggfJRN3rxWSTe52Pko=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=AJa5GDM1hnvFIw6sLqGyYIj0ROlzjlu1ZR+UIt+RazrOZaKGJ4N8Lh6yGrdT+K+/tO
         S2IlWq9hJKFtRPVN399hKcMudNulUciCMjFf54ZhAVR+Tg62j3Le4BVtGfgJFWmh5iSz
         Agkvt0pHeyznIwjbMFZYYKP9zevfAPZf5fGmw=
Received: by 10.86.79.19 with SMTP id c19mr7210115fgb.52.1213566395254;
        Sun, 15 Jun 2008 14:46:35 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id 3sm10840592fge.3.2008.06.15.14.46.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 15 Jun 2008 14:46:34 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1213566349-25395-10-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85133>

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../org/spearce/jgit/lib/PackedObjectLoader.java   |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackedObjectLoader.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackedObjectLoader.java
index 743484e..43d43e6 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackedObjectLoader.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackedObjectLoader.java
@@ -41,8 +41,7 @@ package org.spearce.jgit.lib;
 import java.io.IOException;
 
 /**
- * Base class for a set of object loader classes for packed
- * objects.
+ * Base class for a set of object loader classes for packed objects.
  */
 abstract class PackedObjectLoader extends ObjectLoader {
 	protected final PackFile pack;
-- 
1.5.5.1
