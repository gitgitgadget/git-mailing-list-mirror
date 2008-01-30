From: Bruno Ribas <ribas@c3sl.ufpr.br>
Subject: [PATCH] gitweb: Update gitweb/README to include the new per-repository configuration
Date: Wed, 30 Jan 2008 03:28:18 -0200
Message-ID: <1201670898-15076-2-git-send-email-ribas@c3sl.ufpr.br>
References: <1201670898-15076-1-git-send-email-ribas@c3sl.ufpr.br>
Cc: Bruno Ribas <ribas@c3sl.ufpr.br>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 30 06:28:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JK5VF-0007Xh-BQ
	for gcvg-git-2@gmane.org; Wed, 30 Jan 2008 06:28:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753768AbYA3F2W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2008 00:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753811AbYA3F2V
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jan 2008 00:28:21 -0500
Received: from mx.inf.ufpr.br ([200.17.202.3]:37235 "EHLO urquell.c3sl.ufpr.br"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753632AbYA3F2T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2008 00:28:19 -0500
Received: from localhost (unknown [201.21.136.136])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: ribas)
	by urquell.c3sl.ufpr.br (Postfix) with ESMTP id 73179700003E4;
	Wed, 30 Jan 2008 03:28:18 -0200 (BRST)
X-Mailer: git-send-email 1.5.3.8
In-Reply-To: <1201670898-15076-1-git-send-email-ribas@c3sl.ufpr.br>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72024>


Signed-off-by: Bruno Ribas <ribas@c3sl.ufpr.br>
---
 gitweb/README |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/gitweb/README b/gitweb/README
index b28f59f..d90969f 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -220,6 +220,10 @@ You can use the following files in repository:
    Displayed in the project summary page. You can use multiple-valued
    gitweb.url repository configuration variable for that, but the file
    takes precendence.
+ * owner (or gitweb.owner)
+   File with the owner of the repository, on a single line. By default set
+   to the filesystem directory's owner. You can use the gitweb.owner repo 
+   configuration variable, but the file takes precedence.
  * various gitweb.* config variables (in config)
    Read description of %feature hash for detailed list, and some
    descriptions.
-- 
1.5.3.8
