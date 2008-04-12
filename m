From: "Clifford Caoile" <piyo@users.sourceforge.net>
Subject: [PATCH] Docs gitk: Explicitly mention -d, --date-order option
Date: Sat, 12 Apr 2008 18:49:13 +0900
Message-ID: <1f748ec60804120249u8d790e0t814f2c675fc4a464@mail.gmail.com>
Reply-To: piyo@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 12 11:50:00 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkcMx-0002lO-Cm
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 11:49:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757521AbYDLJtP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2008 05:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757051AbYDLJtP
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Apr 2008 05:49:15 -0400
Received: from an-out-0708.google.com ([209.85.132.241]:50685 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756918AbYDLJtO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2008 05:49:14 -0400
Received: by an-out-0708.google.com with SMTP id d31so200626and.103
        for <git@vger.kernel.org>; Sat, 12 Apr 2008 02:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        bh=JopSCGOlMdQobcTPvimQ99fFfKyb8Ylb0cFHV8hytLo=;
        b=g2GhN9q9/+fVi68iDMZhbY8mPFmykiFeq0U2EXNTN34ASMFAJUAcLyQCdlwFAdFboTIOLrK/p5gOJCZrLGdS9lm9z8qMqkE9x8ORDLTUkYFv157j/TzGt+t8SizWLZTrh3xb7vOTX8dtX210/tWZutIokPip2a3YGO+WMt9FEFg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=OeP1MCpS5bwggy+d7j7n87edZ75vQCBN7aqiyYq7WpPhepc3EEvhc2EtS0YpLUgP3755TMELLbEu3mMS3kg6MA1JmYGzkH5wpwaqn1u/tuyj3nR9xwRHFrrvcvDUJ64OxWm6Wi+NcBtO2dulvpio8Ir1hMoZ0HK81szU5okD9qk=
Received: by 10.100.249.9 with SMTP id w9mr7381644anh.63.1207993753668;
        Sat, 12 Apr 2008 02:49:13 -0700 (PDT)
Received: by 10.101.1.16 with HTTP; Sat, 12 Apr 2008 02:49:13 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: edc3d97bab4f1a59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79340>

gitk can show the commits in --date-order which is commits sorted by
Committer Date. -d is a gitk feature, which in turn converts to
--date-order, which is a git-log feature. It is useful to mention.

git-branch, a Javascript based git repo viewer, displays in
--date-order.

Signed-off-by: Clifford Caoile <piyo@users.sourceforge.net>
---
 Documentation/gitk.txt |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
index 29edafc..d247d63 100644
--- a/Documentation/gitk.txt
+++ b/Documentation/gitk.txt
@@ -41,6 +41,12 @@ frequently used options.

 	Show all branches.

+-d, --date-order::
+
+	Shows commits by Committer Date order. Note that the date column is
+	Author Date, so it may appear to be out of order. If this option is
+	not set, gitk displays in --topo-order. See linkgit:git-log[1].
+
 <revs>::

 	Limit the revisions to show. This can be either a single revision
-- 
1.5.4.2.1161.g1a6f0
