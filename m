From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH] docs: Clarify "preserve" option wording for git-pull
Date: Thu, 26 Mar 2015 12:04:23 +0100
Message-ID: <CAHGBnuMcKAhW+_Ho8X1kzZd3B57ogu2Anb1nuPmKwRQD=OYrZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 26 12:04:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yb5aP-0002qB-FR
	for gcvg-git-2@plane.gmane.org; Thu, 26 Mar 2015 12:04:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581AbbCZLE0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2015 07:04:26 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:36174 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751492AbbCZLEY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2015 07:04:24 -0400
Received: by igbud6 with SMTP id ud6so126549505igb.1
        for <git@vger.kernel.org>; Thu, 26 Mar 2015 04:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=kmCXThMQ07as5CdlHhi/GNdJC1KqjeseONrtQLwC8lY=;
        b=A3sCn1HT8sP0RvnUVXk9nQsj/UAPYn28/R4bQyvpyPX25DHeFlh1KTkGTz2pnv5Wjd
         4Rrs21JbN3tdK04l7uU+ojN3HxYmVLNFPV4CFVJJEIPIdgKhDJ46y/0GVFyTeX8X2urC
         bdnPCRYPsdni8X33rzp9GwyrhBZlqXKfVVr4OjzQ4IoV89nAzmV/cUQcJSo43FMV0Zv3
         8DCltkJvOyidG+FJ4Skj0ioqOUiylgxxsT4PogpWUcBfCL9q5y7uVPNWz9n63tZ0GUQ+
         kFiEx/JYbk9l5ljRW0IGe0J/1n1tIH+x16AfSZLgkbUbRZbfhQgDVk4wsMFX+nWc7fsB
         fM/Q==
X-Received: by 10.50.79.229 with SMTP id m5mr35749074igx.23.1427367863982;
 Thu, 26 Mar 2015 04:04:23 -0700 (PDT)
Received: by 10.107.132.144 with HTTP; Thu, 26 Mar 2015 04:04:23 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266321>

Before this path, the "also" sounded as if "preserve" was doing a rebase
as additional work that "true" would not do. Clarify this by saying
"still" instead of "also".

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 Documentation/git-pull.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index d3d236c..96829be 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -111,8 +111,8 @@ include::merge-options.txt[]
     was rebased since last fetched, the rebase uses that information
     to avoid rebasing non-local changes.
 +
-When preserve, also rebase the current branch on top of the upstream
-branch, but pass `--preserve-merges` along to `git rebase` so that
+When preserve, still rebase the current branch on top of the upstream
+branch, but also pass `--preserve-merges` along to `git rebase` so that
 locally created merge commits will not be flattened.
 +
 When false, merge the current branch into the upstream branch.
-- 
1.9.5.msysgit.1
