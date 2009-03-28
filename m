From: =?utf-8?q?Santi=20B=C3=A9jar?= <santi@agolina.net>
Subject: [PATCH 3/4] Documentation: branch.*.merge can also afect 'git-push'
Date: Sun, 29 Mar 2009 00:10:03 +0100
Message-ID: <1238281804-30290-4-git-send-email-santi@agolina.net>
References: <1238281804-30290-1-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 29 00:12:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnhhM-00033N-OH
	for gcvg-git-2@gmane.org; Sun, 29 Mar 2009 00:12:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754746AbZC1XKa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Mar 2009 19:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754369AbZC1XK3
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Mar 2009 19:10:29 -0400
Received: from mu-out-0910.google.com ([209.85.134.191]:10007 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754447AbZC1XK1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Mar 2009 19:10:27 -0400
Received: by mu-out-0910.google.com with SMTP id g7so629764muf.1
        for <git@vger.kernel.org>; Sat, 28 Mar 2009 16:10:25 -0700 (PDT)
Received: by 10.103.198.15 with SMTP id a15mr1005169muq.60.1238281825669;
        Sat, 28 Mar 2009 16:10:25 -0700 (PDT)
Received: from localhost (p5B0D7403.dip.t-dialin.net [91.13.116.3])
        by mx.google.com with ESMTPS id j10sm6071932muh.31.2009.03.28.16.10.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 28 Mar 2009 16:10:25 -0700 (PDT)
X-Mailer: git-send-email 1.6.1.258.g7ff14
In-Reply-To: <1238281804-30290-1-git-send-email-santi@agolina.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114991>


Signed-off-by: Santi B=C3=A9jar <santi@agolina.net>
---
 Documentation/config.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 07f88f5..cb392fd 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -480,7 +480,7 @@ branch.<name>.remote::
 branch.<name>.merge::
 	It defines, together with branch.<name>.remote, the tracking branch
 	for the current branch. It tells 'git-fetch'/'git-pull' which
-	branch to merge.
+	branch to merge and can also afect 'git-push' (see push.default).
 	When in branch <name>, it tells 'git-fetch' the default
 	refspec to be marked for merging in FETCH_HEAD. The value is
 	handled like the remote part of a refspec, and must match a
--=20
1.6.1.258.g7ff14
