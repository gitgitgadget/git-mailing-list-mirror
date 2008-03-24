From: Guanqun Lu <guanqun.lu@gmail.com>
Subject: [PATCH] Fix the wrong output of `git-show v1.3.0~155^2~4` in documentation.
Date: Mon, 24 Mar 2008 15:27:28 +0800
Message-ID: <1206343648-8003-1-git-send-email-Guanqun.Lu@Gmail.com>
Cc: Guanqun Lu <Guanqun.Lu@Gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 23 16:22:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdS1o-0002Ea-GX
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 16:22:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbYCWPVs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 11:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754933AbYCWPVs
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 11:21:48 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:55196 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750995AbYCWPVr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 11:21:47 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2888399wah.23
        for <git@vger.kernel.org>; Sun, 23 Mar 2008 08:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:to:cc:subject:date:message-id:x-mailer:from;
        bh=MBpigZHkrL05c0eoPMo/9jLnpvp2Lls8VZ5Q7apklUA=;
        b=Ll1J1Gm0BI3blFRoAakNOtMoMlnNikPziVTANHb1KC8L8REpylnwhpZRhZFSXfJv+aaBLIC+EDpTIZ+S0H1mEvF1jZBCncHw6fLAcFxnm+XN4j3klARmaugC/jN0tvVbC5DJJRi0un5V6OPfc+iUxfD3XktnkLsZdBrvvxCZarI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=to:cc:subject:date:message-id:x-mailer:from;
        b=ckVsStWaFdFcdVjTQdg8ny6mZnDdzYkCIYN/2681EwEs+fHQwwoAYZ48dNX6IxKAF/gWZNiuEkmAFlRGorBrwTCSCtgq6P2FF52P+bpllxmDQJuldPH7FmDm/MsHb8ZUXzBzRxKcSUXbKQH/dajMBaTfMTeI39B4z5c1XNkm/hg=
Received: by 10.114.132.5 with SMTP id f5mr3477190wad.125.1206285707370;
        Sun, 23 Mar 2008 08:21:47 -0700 (PDT)
Received: from localhost ( [202.120.224.18])
        by mx.google.com with ESMTPS id a8sm11805627poa.2.2008.03.23.08.21.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 23 Mar 2008 08:21:42 -0700 (PDT)
X-Mailer: git-send-email 1.5.4.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77915>

Texts between ~ and ~ will be subscripted during the asciidoc translation.

Signed-off-by: Guanqun Lu <Guanqun.Lu@Gmail.com>
---
 Documentation/user-manual.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 40b0de0..565aeb9 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -4144,7 +4144,7 @@ commits one by one with the function `get_revision()`.
 
 If you are interested in more details of the revision walking process,
 just have a look at the first implementation of `cmd_log()`; call
-`git-show v1.3.0~155^2~4` and scroll down to that function (note that you
+`git-show v1.3.0{tilde}155^2{tilde}4` and scroll down to that function (note that you
 no longer need to call `setup_pager()` directly).
 
 Nowadays, `git log` is a builtin, which means that it is _contained_ in the
-- 
1.5.4.GIT
