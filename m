From: Dan McGee <dpmcgee@gmail.com>
Subject: [PATCH] git-format-patch(1)- add note about creating patch for single commit
Date: Sat, 18 Oct 2008 23:54:44 -0500
Message-ID: <1224392084-12956-1-git-send-email-dpmcgee@gmail.com>
Cc: Dan McGee <dpmcgee@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 19 07:02:29 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrQQs-0007Iv-LR
	for gcvg-git-2@gmane.org; Sun, 19 Oct 2008 07:02:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbYJSEyy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2008 00:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750745AbYJSEyx
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Oct 2008 00:54:53 -0400
Received: from wx-out-0506.google.com ([66.249.82.224]:57812 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750739AbYJSEyx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2008 00:54:53 -0400
Received: by wx-out-0506.google.com with SMTP id h27so551548wxd.4
        for <git@vger.kernel.org>; Sat, 18 Oct 2008 21:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=Q/IpU9tQ4xKWSVzgdPaB0BaNcg3AGKnG0+fIZ4cAGWo=;
        b=scS2gQjGiekzVCrtntx9Cx6r9aHFtpEKif0wdNO+3LrbiLxom2PPP5/IR1dANtrZ6z
         Iwd+F7CkUI3cfMTaWe6Jt7ffLK4Lx8Ox0t32aJcq4jBkYjYXI1YboSpjgrrqAjhET5Fq
         hinXio1AvaHkLUH48l/AvMQEdkeBh7sW3JiGE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=GLHNrVUv2SBCHJD+wfKt/OjPoYClC8DS1Lf9g3iA9PBLq3+5GvrGG0gMTI+eOsgxJ1
         VtelvKLgi94zmh+8XHWydo3ToQdIqqy1OTEkMXgXWr1dXaV8t0QT93g5abbWCImBAA9k
         TzA6yJIUKdH6yfEkhWF5pJV9BOgC5dgUrY9gc=
Received: by 10.65.114.4 with SMTP id r4mr3170496qbm.21.1224392086907;
        Sat, 18 Oct 2008 21:54:46 -0700 (PDT)
Received: from localhost (adsl-76-197-197-221.dsl.chcgil.sbcglobal.net [76.197.197.221])
        by mx.google.com with ESMTPS id k27sm789067qba.10.2008.10.18.21.54.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 18 Oct 2008 21:54:46 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
---

I thought this would be helpful because it took me the beter part of an hour
to find a solution instead of specifying C~1..C or other crazy things. The
current documentation just leaves you hanging when what you really want is
just one formatted patch.

If there any suggestions on better wording, feel free to resubmit or whatever-
I just felt like this should be documented somewhere.

 Documentation/git-format-patch.txt |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index adb4ea7..8518c33 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -46,7 +46,9 @@ applies to that command line and you do not get "everything
 since the beginning of the time".  If you want to format
 everything since project inception to one commit, say "git
 format-patch \--root <commit>" to make it clear that it is the
-latter case.
+latter case.  If you want to format only a single commit, say "git
+format-patch <commit>^!" (which excludes all parent revisions of the
+specified commit).
 
 By default, each output file is numbered sequentially from 1, and uses the
 first line of the commit message (massaged for pathname safety) as
-- 
1.6.0.2
