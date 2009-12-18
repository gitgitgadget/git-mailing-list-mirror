From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 1/2] api-strbuf.txt: fix typos and document launch_editor()
Date: Thu, 17 Dec 2009 16:05:28 -0800
Message-ID: <1261094729-24128-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 18 01:06:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLQM1-0007zL-GY
	for gcvg-git-2@lo.gmane.org; Fri, 18 Dec 2009 01:05:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751780AbZLRAFf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2009 19:05:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750950AbZLRAFf
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Dec 2009 19:05:35 -0500
Received: from mail-gx0-f211.google.com ([209.85.217.211]:46546 "EHLO
	mail-gx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833AbZLRAFd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2009 19:05:33 -0500
Received: by gxk3 with SMTP id 3so1606121gxk.1
        for <git@vger.kernel.org>; Thu, 17 Dec 2009 16:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=ZloZo8zDY4N/CojVNGCm4CoAhtqHr827fQ5YFTvljTM=;
        b=VIbbyVaRvU5ne17aDfbjkSV4yJphgiSqn7/+EFf/nq9RAbwQDSppN2pB223NDAH2jr
         iqJQePI0R9mPehE+BXuGVgmokrtIX5kt41nKDZu1NKdcQYZA4wgVJ0JpvHOm2vhM17iB
         unRvVzDeHuQLDAXhizPro02DA/pHo1kx4i/+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=dKhaY5hnwvMsIDh4TFbWGdZxk/60ocQdKkFlFZ5ZtleSwYzpXwKkrEw1AHk4IPJR0N
         ma7E7mMeodL6R3LpXUkM4KtU82WZtaMQCBOZYnAPfPkiTEUmtStNtwXwNZxEgFWrD7jv
         RupGdWtDqluTsqZ/FQ5waUOw+nM2DvyPJlrJc=
Received: by 10.90.46.19 with SMTP id t19mr3447264agt.45.1261094732190;
        Thu, 17 Dec 2009 16:05:32 -0800 (PST)
Received: from localhost (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 7sm534658ywc.6.2009.12.17.16.05.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 17 Dec 2009 16:05:31 -0800 (PST)
X-Mailer: git-send-email 1.6.6.rc3.1.g8df51
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135389>

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 Documentation/technical/api-strbuf.txt |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/api-strbuf.txt b/Documentation/technical/api-strbuf.txt
index 7438149..a0e0f85 100644
--- a/Documentation/technical/api-strbuf.txt
+++ b/Documentation/technical/api-strbuf.txt
@@ -12,7 +12,7 @@ strbuf API actually relies on the string being free of NULs.
 
 strbufs has some invariants that are very important to keep in mind:
 
-. The `buf` member is never NULL, so you it can be used in any usual C
+. The `buf` member is never NULL, so it can be used in any usual C
 string operations safely. strbuf's _have_ to be initialized either by
 `strbuf_init()` or by `= STRBUF_INIT` before the invariants, though.
 +
@@ -55,7 +55,7 @@ Data structures
 
 * `struct strbuf`
 
-This is string buffer structure. The `len` member can be used to
+This is the string buffer structure. The `len` member can be used to
 determine the current length of the string, and `buf` member provides access to
 the string itself.
 
@@ -253,3 +253,9 @@ same behaviour as well.
 	comments are considered contents to be removed or not.
 
 `launch_editor`::
+
+	Launch the user preferred editor to edit a file and fill the buffer
+	with the file's contents upon the user completing their editing. The
+	third argument can be used to set the environment which the editor is
+	run in. If the buffer is NULL the editor is launched as usual but the
+	file's contents are not read into the buffer upon completion.
-- 
1.6.6.rc3.1.g8df51
