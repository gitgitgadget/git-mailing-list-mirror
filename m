From: =?utf-8?q?Santi=20B=C3=A9jar?= <santi@agolina.net>
Subject: [PATCH] tutorial-2: Update with the new "git commit" ouput
Date: Tue, 20 Jan 2009 12:29:04 +0100
Message-ID: <1232450944-6873-1-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 20 12:30:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPEoZ-0005d8-Bb
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 12:30:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758716AbZATL3O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jan 2009 06:29:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758428AbZATL3O
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 06:29:14 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:61027 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757968AbZATL3M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 06:29:12 -0500
Received: by bwz14 with SMTP id 14so10304704bwz.13
        for <git@vger.kernel.org>; Tue, 20 Jan 2009 03:29:11 -0800 (PST)
Received: by 10.223.108.211 with SMTP id g19mr2200124fap.39.1232450950547;
        Tue, 20 Jan 2009 03:29:10 -0800 (PST)
Received: from localhost (p5B0D718A.dip.t-dialin.net [91.13.113.138])
        by mx.google.com with ESMTPS id k29sm11376921fkk.16.2009.01.20.03.29.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 20 Jan 2009 03:29:09 -0800 (PST)
X-Mailer: git-send-email 1.6.1.258.g7ff14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106471>

Commit
c5ee71f (commit: more compact summary and without extra quotes, 2009-01=
-19)
changed the "git commit" output when creating a commit.
This patch updates the example session in the tutorial.

Signed-off-by: Santi B=C3=A9jar <santi@agolina.net>
---
 Documentation/gittutorial-2.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/gittutorial-2.txt b/Documentation/gittutoria=
l-2.txt
index a057b50..dc8fc3a 100644
--- a/Documentation/gittutorial-2.txt
+++ b/Documentation/gittutorial-2.txt
@@ -32,12 +32,12 @@ Initialized empty Git repository in .git/
 $ echo 'hello world' > file.txt
 $ git add .
 $ git commit -a -m "initial commit"
-[master (root-commit)] created 54196cc: "initial commit"
+[master (root-commit) 54196cc] initial commit
  1 files changed, 1 insertions(+), 0 deletions(-)
  create mode 100644 file.txt
 $ echo 'hello world!' >file.txt
 $ git commit -a -m "add emphasis"
-[master] created c4d59f3: "add emphasis"
+[master c4d59f3] add emphasis
  1 files changed, 1 insertions(+), 1 deletions(-)
 ------------------------------------------------
=20
--=20
1.6.1.258.g7ff14
