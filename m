From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] checkout: mention '--' in the docs
Date: Wed, 23 Jul 2008 13:49:21 +0200
Message-ID: <1216813762-23511-1-git-send-email-szeder@ira.uka.de>
References: <1216808133-31919-2-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pierre Habouzit <madcoder@debian.org>, gitster@pobox.com,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 13:50:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLcrg-0008K5-4K
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 13:50:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752043AbYGWLtZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jul 2008 07:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751061AbYGWLtZ
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 07:49:25 -0400
Received: from francis.fzi.de ([141.21.7.5]:50665 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751390AbYGWLtY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 07:49:24 -0400
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 23 Jul 2008 13:49:22 +0200
X-Mailer: git-send-email 1.6.0.rc0.35.gb83a7
In-Reply-To: <1216808133-31919-2-git-send-email-madcoder@debian.org>
X-OriginalArrivalTime: 23 Jul 2008 11:49:22.0117 (UTC) FILETIME=[25BB6750:01C8ECBA]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89634>

'git checkout' uses '--' to separate options from paths, but it was not
mentioned in the documentation

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
And here are two small changes related to 'git checkout --'.

 Documentation/git-checkout.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkou=
t.txt
index 2abfbda..5aa69c0 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git checkout' [-q] [-f] [[--track | --no-track] -b <new_branch> [-l]]=
 [-m] [<branch>]
-'git checkout' [<tree-ish>] <paths>...
+'git checkout' [<tree-ish>] [--] <paths>...
=20
 DESCRIPTION
 -----------
--=20
1.6.0.rc0.35.gb83a7
