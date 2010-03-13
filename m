From: Mark Lodato <lodatom@gmail.com>
Subject: [PATCH/RFC 03/12] fsck docs: remove outdated and useless diagnostic
Date: Fri, 12 Mar 2010 23:52:55 -0500
Message-ID: <1268455984-19061-4-git-send-email-lodatom@gmail.com>
References: <1268455984-19061-1-git-send-email-lodatom@gmail.com>
Cc: Mark Lodato <lodatom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 13 05:54:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqJMg-0007qX-EY
	for gcvg-git-2@lo.gmane.org; Sat, 13 Mar 2010 05:54:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933377Ab0CMExf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Mar 2010 23:53:35 -0500
Received: from mail-qy0-f179.google.com ([209.85.221.179]:41701 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755979Ab0CMExR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Mar 2010 23:53:17 -0500
Received: by qyk9 with SMTP id 9so1844178qyk.5
        for <git@vger.kernel.org>; Fri, 12 Mar 2010 20:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=UZDHUvn458WNTfKdYS4xu21Tw+LiNJQDk2/BXgyFZWQ=;
        b=Aifij/NewFzR1r50TqCCZwrI8wrFqOH48M5yQG0Sdw7EFOoMIaQd7HNpnVF/P1szzq
         GbXyPYzg9/Oz094s7AsH5gpGHizFl7IuACE9QrUvjaciIe3Sr/JACohncd1X7b+nWmPf
         /hd/cIXzGE6nLfRRfvsjF0dGdIj/gwVey7uSE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=x/MxvfJe7EbR+41xf+yVJCyLV1djR1W05pT3DAUNSy8czcPaduVyTeMZeeFLVcha6k
         L3nOU7CNugUFeoFAqXeZGDXRbklSMKNo8G3zJPtT16ml0mxBsliAKj1REZ7MtBacDujU
         Crb+JyfJb+xxOTAWPFkG8ssEUiDf0U8nQxFkE=
Received: by 10.229.129.29 with SMTP id m29mr3123596qcs.33.1268455996095;
        Fri, 12 Mar 2010 20:53:16 -0800 (PST)
Received: from localhost.localdomain (c-68-50-174-152.hsd1.dc.comcast.net [68.50.174.152])
        by mx.google.com with ESMTPS id 22sm1694110qyk.10.2010.03.12.20.53.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Mar 2010 20:53:15 -0800 (PST)
X-Mailer: git-send-email 1.7.0.2
In-Reply-To: <1268455984-19061-1-git-send-email-lodatom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142079>

In git-fsck(1), there was a reference to the warning "<tree> has full
pathnames in it".  This exact wording has not been used since 2005
(commit f1f0d0889e55), when the wording was changed slightly.  More
importantly, the description of that warning was useless, and there were
many other similar warning messages which were not document at all.
Since all these warnings are fairly obvious, there is no need for them
to be in the man page.

Signed-off-by: Mark Lodato <lodatom@gmail.com>
---
 Documentation/git-fsck.txt |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
index 3ad48a6..86f9b2b 100644
--- a/Documentation/git-fsck.txt
+++ b/Documentation/git-fsck.txt
@@ -123,9 +123,6 @@ dangling <type> <object>::
 	The <type> object <object>, is present in the database but never
 	'directly' used. A dangling commit could be a root node.
 
-warning: git-fsck: tree <tree> has full pathnames in it::
-	And it shouldn't...
-
 sha1 mismatch <object>::
 	The database has an object who's sha1 doesn't match the
 	database value.
-- 
1.7.0.2
