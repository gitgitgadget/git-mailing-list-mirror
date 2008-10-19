From: Abhijit Bhopatkar <bain@devslashzero.com>
Subject: [PATCH] Documentation: Clarify '--signoff' for git-commit
Date: Sun, 19 Oct 2008 09:49:23 +0530
Message-ID: <48FAB54B.2020304@devslashzero.com>
References: <48F95974.3010503@devslashzero.com> <7vfxmuec46.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 19 06:20:47 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrPmY-0000zt-5S
	for gcvg-git-2@gmane.org; Sun, 19 Oct 2008 06:20:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbYJSETb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2008 00:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750704AbYJSETb
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Oct 2008 00:19:31 -0400
Received: from ti-out-0910.google.com ([209.85.142.190]:43973 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698AbYJSETa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2008 00:19:30 -0400
Received: by ti-out-0910.google.com with SMTP id b6so548680tic.23
        for <git@vger.kernel.org>; Sat, 18 Oct 2008 21:19:28 -0700 (PDT)
Received: by 10.110.37.17 with SMTP id k17mr2313516tik.6.1224389968619;
        Sat, 18 Oct 2008 21:19:28 -0700 (PDT)
Received: from ?192.168.1.204? ([59.95.16.66])
        by mx.google.com with ESMTPS id i6sm7311339tid.5.2008.10.18.21.19.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 18 Oct 2008 21:19:27 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.17 (X11/20080914)
In-Reply-To: <7vfxmuec46.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98589>

'--signoff' uses commiter name always to add the signoff line,
make it explicit in the documentation.

Signed-off-by: Abhijit Bhopatkar <bain@devslashzero.com>
---
 Documentation/git-commit.txt |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index eb05b0f..713ab0a 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -94,7 +94,8 @@ OPTIONS

 -s::
 --signoff::
-	Add Signed-off-by line at the end of the commit message.
+	Add Signed-off-by line by the commiter at the end of the commit
+	log message.

 -n::
 --no-verify::
-- 
1.5.6.3
