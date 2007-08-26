From: Brian Hetro <whee@smaertness.net>
Subject: [PATCH] Make usage documentation for git-am consistent.
Date: Sat, 25 Aug 2007 23:19:38 -0400
Message-ID: <20070826031938.GA7644@ruiner>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 26 05:20:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IP8fj-0006pH-AD
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 05:20:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751834AbXHZDTq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Aug 2007 23:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751690AbXHZDTp
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Aug 2007 23:19:45 -0400
Received: from ag-out-0708.google.com ([72.14.246.242]:62114 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410AbXHZDTp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Aug 2007 23:19:45 -0400
Received: by ag-out-0708.google.com with SMTP id 35so2222201aga
        for <git@vger.kernel.org>; Sat, 25 Aug 2007 20:19:42 -0700 (PDT)
Received: by 10.100.141.13 with SMTP id o13mr641421and.1188098382133;
        Sat, 25 Aug 2007 20:19:42 -0700 (PDT)
Received: from smaertness.net ( [66.67.48.108])
        by mx.google.com with ESMTPS id d35sm2566443and.2007.08.25.20.19.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 25 Aug 2007 20:19:40 -0700 (PDT)
Received: by smaertness.net (nbSMTP-1.00) for uid 1000
	(using TLSv1/SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
	whee@smaertness.net; Sat, 25 Aug 2007 23:19:40 -0400 (EDT)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
X-PGP-Key: http://whee.smaertness.net/pubkey.asc
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56668>

The usage information in git-am.sh now matches that of the
documentation.

Signed-off-by: Brian Hetro <whee@smaertness.net>
---
 git-am.sh |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index b5ed8ca..6809aa0 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -2,8 +2,10 @@
 #
 # Copyright (c) 2005, 2006 Junio C Hamano
 
-USAGE='[--signoff] [--dotest=<dir>] [--utf8 | --no-utf8] [--binary] [--3way]
-  [--interactive] [--whitespace=<option>] [-C<n>] [-p<n>] <mbox>...
+USAGE='[--signoff] [--dotest=<dir>] [--keep] [--utf8 | --no-utf8]
+  [--3way] [--interactive] [--binary]
+  [--whitespace=<option>] [-C<n>] [-p<n>]
+  <mbox>|<Maildir>...
   or, when resuming [--skip | --resolved]'
 . git-sh-setup
 set_reflog_action am
-- 
1.5.3.rc6.23.g0058-dirty
