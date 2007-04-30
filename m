From: Jari Aalto <jari.aalto@cante.net>
Subject: [PATCH] Mention html doc location http://www.kernel.org in DESCRIPTION
Date: Mon, 30 Apr 2007 14:21:38 +0300
Organization: Private
Message-ID: <mz0qxg3h.fsf@cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 30 13:39:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HiUDh-0005go-G7
	for gcvg-git@gmane.org; Mon, 30 Apr 2007 13:39:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161186AbXD3Lik (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Apr 2007 07:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161475AbXD3Lik
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Apr 2007 07:38:40 -0400
Received: from main.gmane.org ([80.91.229.2]:38604 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161186AbXD3Lii (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2007 07:38:38 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HiU4u-0005bm-M2
	for git@vger.kernel.org; Mon, 30 Apr 2007 13:30:00 +0200
Received: from a81-197-175-198.elisa-laajakaista.fi ([81.197.175.198])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 30 Apr 2007 13:30:00 +0200
Received: from jari.aalto by a81-197-175-198.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 30 Apr 2007 13:30:00 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: a81-197-175-198.elisa-laajakaista.fi
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.3 (windows-nt)
Cancel-Lock: sha1:WOhntvtXLhkebzJQ+xBYzr2XbXE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45861>


Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---

 While reading the manual page under console, the page is rendered
 like below. The problem is than REFERENCES do not include canonical
 URL to the root where to reach the mentioned pages.

    DESCRIPTION

       Git is a fast, scalable, distributed revision control system
       with an unusually rich command set that provides both
       high-level operations and full access to internals.

       See this [1]tutorial to get started, then see [2]Everyday Git
       for a useful minimum set of

       [...]

    REFERENCES
       1. tutorial
          tutorial.html

 Documentation/git.txt |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index c5d02da..c3e1afe 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -18,7 +18,7 @@ Git is a fast, scalable, distributed revision control system with an
 unusually rich command set that provides both high-level operations
 and full access to internals.
 
-See this link:tutorial.html[tutorial] to get started, then see
+See[*] link:tutorial.html[tutorial] to get started, then see
 link:everyday.html[Everyday Git] for a useful minimum set of commands, and
 "man git-commandname" for documentation of each command.  CVS users may
 also want to read link:cvs-migration.html[CVS migration].
@@ -29,6 +29,8 @@ in a coherent way to git enlightenment ;-).
 The COMMAND is either a name of a Git command (see below) or an alias
 as defined in the configuration file (see gitlink:git-config[1]).
 
+[*] http://www.kernel.org/pub/software/scm/git/docs/
+
 ifdef::stalenotes[]
 [NOTE]
 ============
-- 
1.5.1.2.GIT
