From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] git-commit: fix usage to show (-F|-f) <logfile>.
Date: Mon, 7 May 2007 10:54:22 +0000
Message-ID: <20070507105422.28749.qmail@87831458cf3aca.315fe32.mid.smarden.org>
References: <20070504143022.8539.qmail@4071cc1c178e73.315fe32.mid.smarden.org> <20070504143210.8690.qmail@a4171e0dbe98e3.315fe32.mid.smarden.org> <20070507105337.28685.qmail@895eb57f5f8cba.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 07 12:54:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hl0r1-0003Oq-El
	for gcvg-git@gmane.org; Mon, 07 May 2007 12:54:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932500AbXEGKyE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 06:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932649AbXEGKyE
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 06:54:04 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:32880 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932500AbXEGKyD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 06:54:03 -0400
Received: (qmail 28750 invoked by uid 1000); 7 May 2007 10:54:22 -0000
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070507105337.28685.qmail@895eb57f5f8cba.315fe32.mid.smarden.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46442>

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 git-commit.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-commit.sh b/git-commit.sh
index e4518c4..bbd76c6 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -3,7 +3,7 @@
 # Copyright (c) 2005 Linus Torvalds
 # Copyright (c) 2006 Junio C Hamano
 
-USAGE='[-a | --interactive] [-s] [-v] [--no-verify] [-m <message> | -F <logfile> | (-C|-c) <commit> | --amend] [-u] [-e] [--author <author>] [[-i | -o] <path>...]'
+USAGE='[-a | --interactive] [-s] [-v] [--no-verify] [-m <message> | (-F|-f) <logfile> | (-C|-c) <commit> | --amend] [-u] [-e] [--author <author>] [[-i | -o] <path>...]'
 SUBDIRECTORY_OK=Yes
 . git-sh-setup
 require_work_tree
-- 
1.5.1.2
