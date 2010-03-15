From: Jari Aalto <jari.aalto@cante.net>
Subject: [PATCH] git-filter-branch.txt: mention absolute path for scripts in --tree-filter
Date: Mon, 15 Mar 2010 10:26:17 +0200
Organization: Private
Message-ID: <87vdcy7zyu.fsf@jondo.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 15 09:26:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nr5dG-0004I9-Hg
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 09:26:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759883Ab0COI0d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 04:26:33 -0400
Received: from lo.gmane.org ([80.91.229.12]:54223 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759866Ab0COI0d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 04:26:33 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Nr5d9-0004Fk-4n
	for git@vger.kernel.org; Mon, 15 Mar 2010 09:26:31 +0100
Received: from a91-155-187-216.elisa-laajakaista.fi ([91.155.187.216])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 15 Mar 2010 09:26:31 +0100
Received: from jari.aalto by a91-155-187-216.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 15 Mar 2010 09:26:31 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-187-216.elisa-laajakaista.fi
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.1 (gnu/linux)
Cancel-Lock: sha1:/XIf5xD4d9JS2KEHOHk61wRs3B4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142189>


Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 Documentation/git-filter-branch.txt |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 020028c..01bd0ad 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -91,6 +91,9 @@ OPTIONS
 	is then used as-is (new files are auto-added, disappeared files
 	are auto-removed - neither .gitignore files nor any other ignore
 	rules *HAVE ANY EFFECT*!).
++
+In case the <command> is a shell script, provide an absolute path.
+An example: --tree-filter 'sh /path/to/filter.sh'
 
 --index-filter <command>::
 	This is the filter for rewriting the index.  It is similar to the
-- 
1.7.0
