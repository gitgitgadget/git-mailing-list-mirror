From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 2/2] Documentation: make git-sh-setup docs less scary
Date: Tue, 20 Dec 2011 12:09:05 +0100
Message-ID: <c8867738c264a76f9662080b64e00615ec1aa28f.1324378986.git.trast@student.ethz.ch>
References: <c53feb0de8006c205fd26c2c07dcd78bd86b6c24.1324378986.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 20 12:09:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RcxZO-0002vW-Iw
	for gcvg-git-2@lo.gmane.org; Tue, 20 Dec 2011 12:09:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751664Ab1LTLJO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Dec 2011 06:09:14 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:56092 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751456Ab1LTLJJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Dec 2011 06:09:09 -0500
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 20 Dec
 2011 12:09:03 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 20 Dec
 2011 12:09:07 +0100
X-Mailer: git-send-email 1.7.8.484.gdad4270
In-Reply-To: <c53feb0de8006c205fd26c2c07dcd78bd86b6c24.1324378986.git.trast@student.ethz.ch>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187509>

At least one IRC user was scared away by the introductory "This is not
a command the end user would want to run.  Ever." to the point of not
reading on.

Reword it in a more matter-of-fact way that does not intentionally try
to scare the user away.  Since 46bac90 (Do not install shell libraries
executable, 2010-01-31) it is not executable anyway, so the end user
would get

  $ git sh-setup
  fatal: cannot exec 'git-sh-setup': Permission denied

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/git-sh-setup.txt |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-sh-setup.txt b/Documentation/git-sh-setup.txt
index bbfefca..612fb50 100644
--- a/Documentation/git-sh-setup.txt
+++ b/Documentation/git-sh-setup.txt
@@ -13,13 +13,10 @@ SYNOPSIS
 DESCRIPTION
 -----------
 
-This is not a command the end user would want to run.  Ever.
-This documentation is meant for people who are studying the
-Porcelain-ish scripts and/or are writing new ones.
-
-The 'git sh-setup' scriptlet is designed to be sourced (using
-`.`) by other shell scripts to set up some variables pointing at
-the normal git directories and a few helper shell functions.
+This command cannot be run by the end user.  Shell scripts can
+source it (using `.` as indicated above) to set up some variables
+pointing at the normal git directories and a few helper shell
+functions.
 
 Before sourcing it, your script should set up a few variables;
 `USAGE` (and `LONG_USAGE`, if any) is used to define message
-- 
1.7.8.484.gdad4270
