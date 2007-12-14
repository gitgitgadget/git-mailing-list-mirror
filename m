From: David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [StGit PATCH 03/17] Emacs mode: Add an explanatory header
Date: Fri, 14 Dec 2007 11:56:49 +0100
Message-ID: <20071214105633.18066.49991.stgit@krank>
References: <20071214105238.18066.23281.stgit@krank>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: catalin.marinas@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 14 11:57:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J38Dv-0000QW-RB
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 11:56:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761614AbXLNK4d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Dec 2007 05:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759340AbXLNK4d
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 05:56:33 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:51821 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761503AbXLNK4c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 05:56:32 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id CB44F200A217;
	Fri, 14 Dec 2007 11:56:31 +0100 (CET)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 27584-01-57; Fri, 14 Dec 2007 11:56:31 +0100 (CET)
Received: from krank (dns.vtab.com [62.20.90.195])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 84AB6200A1E8;
	Fri, 14 Dec 2007 11:56:31 +0100 (CET)
Received: from [127.0.1.1] (localhost [127.0.0.1])
	by krank (Postfix) with ESMTP id EDE267B406D;
	Fri, 14 Dec 2007 11:56:49 +0100 (CET)
In-Reply-To: <20071214105238.18066.23281.stgit@krank>
User-Agent: StGIT/0.13
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68279>

=46rom: Karl Hasselstr=C3=B6m <kha@treskal.com>

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
---

 contrib/stgit.el |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)


diff --git a/contrib/stgit.el b/contrib/stgit.el
index 09dec8b..cce0c0e 100644
--- a/contrib/stgit.el
+++ b/contrib/stgit.el
@@ -1,3 +1,14 @@
+;; stgit.el: An emacs mode for StGit
+;;
+;; Copyright (C) 2007 David K=C3=A5gedal <davidk@lysator.liu.se>
+;;
+;; To install: put this file on the load-path and place the following
+;; in your .emacs file:
+;;
+;;    (require 'stgit)
+;;
+;; To start: `M-x stgit'
+
 (defun stgit (dir)
   "Manage stgit patches"
   (interactive "DDirectory: \n")
@@ -146,3 +157,5 @@ Commands:
   "Display help for the StGit mode."
   (interactive)
   (describe-function 'stgit-mode))
+
+(provide 'stgit)
