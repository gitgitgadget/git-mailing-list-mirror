From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 1/4] color-words: fix quoting in t4034
Date: Wed, 14 Jan 2009 23:26:00 +0100
Message-ID: <3ff3ccf6e3c1cd6a002d200aee5df88a197a7bf6.1231971446.git.trast@student.ethz.ch>
References: <alpine.DEB.1.00.0901142104400.3586@pacific.mpi-cbg.de>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	=?utf-8?q?Santi=20B=C3=A9jar?= <santi@agolina.net>,
	Junio C Hamano <junio@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 14 23:27:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNECx-0000bA-BI
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 23:27:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752606AbZANW0K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 17:26:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752460AbZANW0K
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 17:26:10 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:14595 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751835AbZANW0J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 17:26:09 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 14 Jan 2009 23:26:07 +0100
Received: from localhost.localdomain ([84.75.148.62]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 14 Jan 2009 23:26:06 +0100
X-Mailer: git-send-email 1.6.1.142.ge070e
In-Reply-To: <alpine.DEB.1.00.0901142104400.3586@pacific.mpi-cbg.de>
X-OriginalArrivalTime: 14 Jan 2009 22:26:06.0988 (UTC) FILETIME=[17E654C0:01C97697]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105714>

Since the single quotes match the ones used to quote the test text
itself, they'd be dropped.  Use double quotes instead.
---

I'd squash this into Dscho's 4/4, so no SoB.


 t/t4034-diff-words.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index f4810e9..6ad1c1f 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -80,7 +80,7 @@ EOF
 
 test_expect_success 'word diff with a regular expression' '
 
-	word_diff --color-words='[a-z]+'
+	word_diff --color-words="[a-z]+"
 
 '
 
@@ -98,7 +98,7 @@ EOF
 
 test_expect_success "test parsing words for newline" '
 
-	word_diff --color-words='a+'
+	word_diff --color-words="a+"
 
 '
 
-- 
1.6.1.142.ge070e
