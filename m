From: Johan Herland <johan@herland.net>
Subject: [PATCH 4/5] Add documentation on the new --rewrite-url option to 'git
 config'
Date: Mon, 04 Aug 2008 01:02:31 +0200
Message-ID: <200808040102.31430.johan@herland.net>
References: <200808040057.00221.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 04 01:03:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPmc5-0001Po-PR
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 01:03:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758663AbYHCXCo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 19:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758840AbYHCXCo
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 19:02:44 -0400
Received: from smtp.getmail.no ([84.208.20.33]:42179 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758307AbYHCXCn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 19:02:43 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0K5100E09S0JN600@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 04 Aug 2008 01:02:43 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K5100B62S0A5320@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 04 Aug 2008 01:02:35 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K5100CAIS0AUOVP@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Mon, 04 Aug 2008 01:02:34 +0200 (CEST)
In-reply-to: <200808040057.00221.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91288>

Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/git-config.txt |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 28e1861..154c80b 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -22,6 +22,7 @@ SYNOPSIS
 'git config' [<file-option>] [-z|--null] -l | --list
 'git config' [<file-option>] --get-color name [default]
 'git config' [<file-option>] --get-colorbool name [stdout-is-tty]
+'git config' [<file-option>] --rewrite-url url
 
 DESCRIPTION
 -----------
@@ -157,6 +158,15 @@ See also <<FILES>>.
 	output.  The optional `default` parameter is used instead, if
 	there is no color configured for `name`.
 
+--rewrite-url url::
+
+	Rewrite `url` according to the longest matching URL rewriting rule
+	(see documentation on `url.<base>.insteadOf` for more information
+	on URL rewriting rules), and output the resulting URL to the
+	standard output. If there is no matching URL rewriting rule, the
+	original `url` is printed on the standard output. In either case,
+	the exit code is 0.
+
 [[FILES]]
 FILES
 -----
-- 
1.6.0.rc1.34.g0fe8c
