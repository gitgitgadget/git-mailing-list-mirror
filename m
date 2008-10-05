From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 1/6] Remove unused variable
Date: Sun, 05 Oct 2008 18:01:34 +0200
Message-ID: <20081005160134.19886.40019.stgit@yoghurt>
References: <20081005155450.19886.43748.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 05 18:02:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmW4G-00063u-6F
	for gcvg-git-2@gmane.org; Sun, 05 Oct 2008 18:02:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754473AbYJEQBl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Oct 2008 12:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754475AbYJEQBl
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Oct 2008 12:01:41 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1869 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754448AbYJEQBh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Oct 2008 12:01:37 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1KmW33-0007XI-00; Sun, 05 Oct 2008 17:01:33 +0100
In-Reply-To: <20081005155450.19886.43748.stgit@yoghurt>
User-Agent: StGIT/0.14.3.236.g0c611
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97514>

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 Documentation/Makefile |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)


diff --git a/Documentation/Makefile b/Documentation/Makefile
index 165e222..37df9ee 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -5,12 +5,10 @@ MAN1_TXT=3D stg.txt $(COMMANDS_TXT)
=20
 DOC_HTML=3D$(patsubst %.txt,%.html,$(MAN1_TXT))
=20
-ARTICLES =3D=20
-# with their own formatting rules.
-SP_ARTICLES =3D tutorial
+ARTICLES =3D tutorial
=20
-DOC_HTML +=3D $(patsubst %,%.html,$(ARTICLES) $(SP_ARTICLES))
-DOC_PDF +=3D $(patsubst %,%.pdf,$(ARTICLES) $(SP_ARTICLES))
+DOC_HTML +=3D $(patsubst %,%.html,$(ARTICLES))
+DOC_PDF +=3D $(patsubst %,%.pdf,$(ARTICLES))
=20
 DOC_MAN1=3D$(patsubst %.txt,%.1,$(MAN1_TXT))
=20
