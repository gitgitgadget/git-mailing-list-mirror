From: Sylvain Rabot <sylvain@abstraction.fr>
Subject: [PATCH 2/3] gitweb: decorate a bit more remotes
Date: Thu, 16 Dec 2010 22:43:20 +0100
Message-ID: <1292535801-7421-3-git-send-email-sylvain@abstraction.fr>
References: <1292535801-7421-1-git-send-email-sylvain@abstraction.fr>
Cc: Sylvain Rabot <sylvain@abstraction.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 16 22:43:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTLc9-0005gY-SU
	for gcvg-git-2@lo.gmane.org; Thu, 16 Dec 2010 22:43:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757519Ab0LPVnf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Dec 2010 16:43:35 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:36985 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756083Ab0LPVnb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Dec 2010 16:43:31 -0500
Received: by wyb28 with SMTP id 28so9190wyb.19
        for <git@vger.kernel.org>; Thu, 16 Dec 2010 13:43:29 -0800 (PST)
Received: by 10.216.187.10 with SMTP id x10mr160287wem.97.1292535809608;
        Thu, 16 Dec 2010 13:43:29 -0800 (PST)
Received: from localhost.localdomain (85-168-197-251.rev.numericable.fr [85.168.197.251])
        by mx.google.com with ESMTPS id n11sm297651wej.43.2010.12.16.13.43.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 16 Dec 2010 13:43:28 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2
In-Reply-To: <1292535801-7421-1-git-send-email-sylvain@abstraction.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163818>

Signed-off-by: Sylvain Rabot <sylvain@abstraction.fr>
---
 gitweb/gitweb.perl |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index db18d06..9398475 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5127,13 +5127,13 @@ sub git_remote_block {
 
 	if (defined $fetch) {
 		if ($fetch eq $push) {
-			$urls_table .= format_repo_url("URL", $fetch);
+			$urls_table .= format_repo_url("<strong>URL:</strong>", $fetch);
 		} else {
-			$urls_table .= format_repo_url("Fetch URL", $fetch);
-			$urls_table .= format_repo_url("Push URL", $push) if defined $push;
+			$urls_table .= format_repo_url("<strong>Fetch URL:</strong>", $fetch);
+			$urls_table .= format_repo_url("<strong>Push URL:</strong>", $push) if defined $push;
 		}
 	} elsif (defined $push) {
-		$urls_table .= format_repo_url("Push URL", $push);
+		$urls_table .= format_repo_url("<strong>Push URL:</strong>", $push);
 	} else {
 		$urls_table .= format_repo_url("", "No remote URL");
 	}
-- 
1.7.3.2
