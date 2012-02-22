From: =?UTF-8?q?Philip=20J=C3=A4genstedt?= <philip@foolip.org>
Subject: [PATCH 4/4] completion: use tabs for indentation
Date: Wed, 22 Feb 2012 09:58:13 +0100
Message-ID: <1329901093-24106-5-git-send-email-philip@foolip.org>
References: <20120222001737.GB2228@goldbirke>
 <1329901093-24106-1-git-send-email-philip@foolip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Teemu Likonen <tlikonen@iki.fi>,
	=?UTF-8?q?Philip=20J=C3=A4genstedt?= <philip@foolip.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 22 09:59:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S082P-0006Gb-JO
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 09:59:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754497Ab2BVI6x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Feb 2012 03:58:53 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:54339 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754477Ab2BVI6w (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Feb 2012 03:58:52 -0500
Received: by mail-lpp01m010-f46.google.com with SMTP id u2so8716873lag.19
        for <git@vger.kernel.org>; Wed, 22 Feb 2012 00:58:51 -0800 (PST)
Received-SPF: pass (google.com: domain of philip@foolip.org designates 10.152.148.106 as permitted sender) client-ip=10.152.148.106;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of philip@foolip.org designates 10.152.148.106 as permitted sender) smtp.mail=philip@foolip.org
Received: from mr.google.com ([10.152.148.106])
        by 10.152.148.106 with SMTP id tr10mr22259137lab.41.1329901131583 (num_hops = 1);
        Wed, 22 Feb 2012 00:58:51 -0800 (PST)
Received: by 10.152.148.106 with SMTP id tr10mr18634340lab.41.1329901131519;
        Wed, 22 Feb 2012 00:58:51 -0800 (PST)
Received: from localhost.localdomain (h128n3-g-hn-a11.ias.bredband.telia.com. [217.209.32.128])
        by mx.google.com with ESMTPS id ot2sm24473095lab.3.2012.02.22.00.58.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 22 Feb 2012 00:58:50 -0800 (PST)
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1329901093-24106-1-git-send-email-philip@foolip.org>
X-Gm-Message-State: ALoCoQk1eYLiYWihOkVjfoc4+/5q30y8H7fmg87NsIeLW+Fz+8FbnjMJMCUdazrE5TZ+J8zCrVIy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191240>

CodingGuidlines confidently declares "We use tabs for indentation."
It would be a shame if it were caught lying.

Signed-off-by: Philip J=C3=A4genstedt <philip@foolip.org>
---
 contrib/completion/git-completion.bash |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 48237c8..03f0b8c 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -284,13 +284,13 @@ __git_ps1 ()
 				fi
 			fi
 			if [ -n "${GIT_PS1_SHOWSTASHSTATE-}" ]; then
-			        git rev-parse --verify refs/stash >/dev/null 2>&1 && s=3D"$=
"
+				git rev-parse --verify refs/stash >/dev/null 2>&1 && s=3D"$"
 			fi
=20
 			if [ -n "${GIT_PS1_SHOWUNTRACKEDFILES-}" ]; then
-			   if [ -n "$(git ls-files --others --exclude-standard)" ]; then
-			      u=3D"%"
-			   fi
+				if [ -n "$(git ls-files --others --exclude-standard)" ]; then
+					u=3D"%"
+				fi
 			fi
=20
 			if [ -n "${GIT_PS1_SHOWUPSTREAM-}" ]; then
--=20
1.7.5.4
