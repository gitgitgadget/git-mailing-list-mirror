From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] git-tag(1): -v option is a subcommand; fix code block
Date: Tue, 1 May 2007 09:24:59 +0200
Message-ID: <20070501072459.GB27876@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 01 09:58:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HinFX-0008BE-QS
	for gcvg-git@gmane.org; Tue, 01 May 2007 09:58:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965626AbXEAH6N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 03:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965638AbXEAH6M
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 03:58:12 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:59109 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965626AbXEAH6M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 03:58:12 -0400
X-Greylist: delayed 1989 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 May 2007 03:58:11 EDT
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 5C2C977803C;
	Tue,  1 May 2007 09:25:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KjzdwMgETkQU; Tue,  1 May 2007 09:25:00 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 1E1FE778036;
	Tue,  1 May 2007 09:25:00 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 844CD6DF823; Tue,  1 May 2007 09:23:42 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 0727662A32; Tue,  1 May 2007 09:24:59 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45926>

When the -v is passed, git-tag will exit after it is processed like it
does with the -d and -l options. Additionally, missing code block caused
wrong rendering of an option example.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 Documentation/git-tag.txt |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 70235e8..4e3e027 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -9,9 +9,10 @@ git-tag - Create, list, delete or verify a tag object signed with GPG
 SYNOPSIS
 --------
 [verse]
-'git-tag' [-a | -s | -u <key-id>] [-f | -v] [-m <msg> | -F <file>]  <name> [<head>]
+'git-tag' [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>]  <name> [<head>]
 'git-tag' -d <name>...
 'git-tag' -l [<pattern>]
+'git-tag' -v <name>
 
 DESCRIPTION
 -----------
@@ -77,8 +78,10 @@ committer identity (of the form "Your Name <your@email.address>") to
 find a key.  If you want to use a different default key, you can specify
 it in the repository configuration as follows:
 
+-------------------------------------
 [user]
     signingkey = <gpg-key-id>
+-------------------------------------
 
 
 DISCUSSION
-- 
1.5.2.rc0.gda94


-- 
Jonas Fonseca
