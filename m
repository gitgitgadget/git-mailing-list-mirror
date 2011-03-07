From: Adam Monsen <haircut@gmail.com>
Subject: [PATCH v3] Documentation fix: git log -p does not imply -c.
Date: Mon,  7 Mar 2011 13:57:43 -0800
Message-ID: <1299535063-1020-1-git-send-email-haircut@gmail.com>
References: <20110307191218.GA20930@sigill.intra.peff.net>
Cc: Jeff King <peff@peff.net>, Junio Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Adam Monsen <haircut@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 07 22:58:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwiRZ-0005pF-PT
	for gcvg-git-2@lo.gmane.org; Mon, 07 Mar 2011 22:58:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756373Ab1CGV6Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2011 16:58:16 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:34981 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756260Ab1CGV6P (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Mar 2011 16:58:15 -0500
Received: by ywj3 with SMTP id 3so1764742ywj.19
        for <git@vger.kernel.org>; Mon, 07 Mar 2011 13:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=f1jVGYl9LEolWtAlF3FTI953yZLiiwnohkvpUOAQjaI=;
        b=LYlmS1y2A+CM4hxcssT5aYEUvFdoRb/FoFKjQ/2Thq2X5zSXfwzSUoaK1IZzBGifNS
         sR8N+BBxUlBo9wXhsm9xRsIuzh20/7Z6bp6COybeEocwrtfi9UE5jje+pUgdNsTHtkOf
         F0EePo6DblrGZnj3YTDSEXB/wFwZQtr44tfNE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=LYzOFpgz+TM5hau665gG1DOy1GIUGAJlzB0/zyFlT0gyhzq7VTa0emp0E0siDiarrF
         fzE6A578R1QP6keMaocCmYvTRr34lHUsL1aqrjjVSnNK8vGLnyygKjOQeWxKUEPpZr9o
         6l2cZtKhbHxcFrHVr3iswcuDYawFB1AiXrDOY=
Received: by 10.150.95.6 with SMTP id s6mr5088938ybb.321.1299535094659;
        Mon, 07 Mar 2011 13:58:14 -0800 (PST)
Received: from localhost.localdomain (c-67-183-136-182.hsd1.wa.comcast.net [67.183.136.182])
        by mx.google.com with ESMTPS id f2sm183386ybh.7.2011.03.07.13.58.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 07 Mar 2011 13:58:13 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <20110307191218.GA20930@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168613>

Relates to the thread with subject "frustrated forensics: hard to find
diff that undid a fix" on the git mailing list.

    http://thread.gmane.org/gmane.comp.version-control.git/168481

I don't wish for anyone to repeat my bungled forensics episode.
Hopefully this will help others git along happily.

Signed-off-by: Adam Monsen <haircut@gmail.com>
---
This is really Peff's patch, I
* fixed a typo (vie -> view)
* am sending it as an acutal patch in case that's easier to apply than
  a diff in an email

I wasn't sure what "Author:" should be, go ahead and change it to the
most appropriate person.

Hope this helps,
-Adam

 Documentation/diff-generate-patch.txt |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/diff-generate-patch.txt b/Documentation/diff-generate-patch.txt
index 3ac2bea..5d478c1 100644
--- a/Documentation/diff-generate-patch.txt
+++ b/Documentation/diff-generate-patch.txt
@@ -74,10 +74,12 @@ separate lines indicate the old and the new mode.
 combined diff format
 --------------------
 
-"git-diff-tree", "git-diff-files" and "git-diff" can take '-c' or
-'--cc' option to produce 'combined diff'.  For showing a merge commit
-with "git log -p", this is the default format; you can force showing
-full diff with the '-m' option.
+Any diff-generating command can take the `-c` or `--cc` option to
+produced a 'combined diff' when showing a merge. This is the default
+format when showing merge conflicts with linkgit:git-diff[1] or a merge
+commit with linkgit:git-show[1]. Note also that you can view the full
+diff with the `-m` option.
+
 A 'combined diff' format looks like this:
 
 ------------
-- 
1.7.2.3
