From: =?utf-8?q?Santi=20B=C3=A9jar?= <santi@agolina.net>
Subject: [PATCHv2 3/4] Documentation: branch.*.merge can also afect 'git-push'
Date: Mon, 30 Mar 2009 12:11:42 +0200
Message-ID: <1238407903-28020-4-git-send-email-santi@agolina.net>
References: <1238407903-28020-1-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 30 12:15:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoEW1-0007Mz-B4
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 12:14:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757601AbZC3KMO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Mar 2009 06:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758590AbZC3KMN
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 06:12:13 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:44348 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758693AbZC3KML (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 06:12:11 -0400
Received: by mail-bw0-f169.google.com with SMTP id 17so1837526bwz.37
        for <git@vger.kernel.org>; Mon, 30 Mar 2009 03:12:09 -0700 (PDT)
Received: by 10.223.108.74 with SMTP id e10mr3785897fap.35.1238407928949;
        Mon, 30 Mar 2009 03:12:08 -0700 (PDT)
Received: from localhost (p5B0D60BE.dip.t-dialin.net [91.13.96.190])
        by mx.google.com with ESMTPS id z15sm2241694fkz.11.2009.03.30.03.12.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 30 Mar 2009 03:12:08 -0700 (PDT)
X-Mailer: git-send-email 1.6.1.258.g7ff14
In-Reply-To: <1238407903-28020-1-git-send-email-santi@agolina.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115129>


Signed-off-by: Santi B=C3=A9jar <santi@agolina.net>
---
 Documentation/config.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 7ae584f..38ab785 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -480,7 +480,7 @@ branch.<name>.remote::
 branch.<name>.merge::
 	It defines, together with branch.<name>.remote, the upstream branch
 	for the given branch. It tells 'git-fetch'/'git-pull' which
-	branch to merge.
+	branch to merge and can also afect 'git-push' (see push.default).
 	When in branch <name>, it tells 'git-fetch' the default
 	refspec to be marked for merging in FETCH_HEAD. The value is
 	handled like the remote part of a refspec, and must match a
--=20
1.6.1.258.g7ff14
