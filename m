From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH] Documentation: Make AsciiDoc links always point to HTML files
Date: Fri, 06 Sep 2013 22:03:22 +0200
Message-ID: <522A350A.5040903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 06 22:03:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VI2G1-0002hg-E6
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 22:03:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752577Ab3IFUDt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 16:03:49 -0400
Received: from plane.gmane.org ([80.91.229.3]:47816 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751361Ab3IFUDs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 16:03:48 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1VI2Fu-0002cm-Ig
	for git@vger.kernel.org; Fri, 06 Sep 2013 22:03:46 +0200
Received: from p5ddb323a.dip0.t-ipconnect.de ([93.219.50.58])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 Sep 2013 22:03:46 +0200
Received: from sschuberth by p5ddb323a.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 Sep 2013 22:03:46 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: p5ddb323a.dip0.t-ipconnect.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234093>

AsciiDoc's "link" is supposed to create hyperlinks for HTML output, so
prefer a "link" to point to an HTML file instead of a text file if an HTML
version of the file is being generated. For RelNotes, keep pointing to
text files as no equivalent HTML files are generated.

If appropriate, also update the link description to not contain the linked
file's extension.

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 Documentation/everyday.txt                | 2 +-
 Documentation/git-credential.txt          | 2 +-
 Documentation/git-rebase.txt              | 4 ++--
 Documentation/git-revert.txt              | 2 +-
 Documentation/gitcvs-migration.txt        | 2 +-
 Documentation/technical/http-protocol.txt | 4 ++--
 Documentation/user-manual.txt             | 4 ++--
 7 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/everyday.txt b/Documentation/everyday.txt
index e1fba85..2a18c1f 100644
--- a/Documentation/everyday.txt
+++ b/Documentation/everyday.txt
@@ -304,7 +304,7 @@ and maintain access to the repository by developers.
   * linkgit:git-shell[1] can be used as a 'restricted login shell'
     for shared central repository users.
 
-link:howto/update-hook-example.txt[update hook howto] has a good
+link:howto/update-hook-example.html[update hook howto] has a good
 example of managing a shared central repository.
 
 
diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
index 7da0f13..b211440 100644
--- a/Documentation/git-credential.txt
+++ b/Documentation/git-credential.txt
@@ -20,7 +20,7 @@ usernames and passwords. The git-credential command exposes this
 interface to scripts which may want to retrieve, store, or prompt for
 credentials in the same manner as Git. The design of this scriptable
 interface models the internal C API; see
-link:technical/api-credentials.txt[the Git credential API] for more
+link:technical/api-credentials.html[the Git credential API] for more
 background on the concepts.
 
 git-credential takes an "action" option on the command-line (one of
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 6b2e1c8..94e07fd 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -322,7 +322,7 @@ You may find this (or --no-ff with an interactive rebase) helpful after
 reverting a topic branch merge, as this option recreates the topic branch with
 fresh commits so it can be remerged successfully without needing to "revert
 the reversion" (see the
-link:howto/revert-a-faulty-merge.txt[revert-a-faulty-merge How-To] for details).
+link:howto/revert-a-faulty-merge.html[revert-a-faulty-merge How-To] for details).
 
 --ignore-whitespace::
 --whitespace=<option>::
@@ -416,7 +416,7 @@ Without --interactive, this is a synonym for --force-rebase.
 You may find this helpful after reverting a topic branch merge, as this option
 recreates the topic branch with fresh commits so it can be remerged
 successfully without needing to "revert the reversion" (see the
-link:howto/revert-a-faulty-merge.txt[revert-a-faulty-merge How-To] for details).
+link:howto/revert-a-faulty-merge.html[revert-a-faulty-merge How-To] for details).
 
 include::merge-strategies.txt[]
 
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index f79c9d8..2de67a5 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -59,7 +59,7 @@ brought in by the merge.  As a result, later merges will only bring in tree
 changes introduced by commits that are not ancestors of the previously
 reverted merge.  This may or may not be what you want.
 +
-See the link:howto/revert-a-faulty-merge.txt[revert-a-faulty-merge How-To] for
+See the link:howto/revert-a-faulty-merge.html[revert-a-faulty-merge How-To] for
 more details.
 
 --no-edit::
diff --git a/Documentation/gitcvs-migration.txt b/Documentation/gitcvs-migration.txt
index 5ab5b07..5ea94cb 100644
--- a/Documentation/gitcvs-migration.txt
+++ b/Documentation/gitcvs-migration.txt
@@ -157,7 +157,7 @@ points.  You can use these, for example, to send all commits to the shared
 repository to a mailing list.  See linkgit:githooks[5].
 
 You can enforce finer grained permissions using update hooks.  See
-link:howto/update-hook-example.txt[Controlling access to branches using
+link:howto/update-hook-example.html[Controlling access to branches using
 update hooks].
 
 Providing CVS Access to a Git Repository
diff --git a/Documentation/technical/http-protocol.txt b/Documentation/technical/http-protocol.txt
index a1173ee..caf941a 100644
--- a/Documentation/technical/http-protocol.txt
+++ b/Documentation/technical/http-protocol.txt
@@ -499,5 +499,5 @@ References
 
 link:http://www.ietf.org/rfc/rfc1738.txt[RFC 1738: Uniform Resource Locators (URL)]
 link:http://www.ietf.org/rfc/rfc2616.txt[RFC 2616: Hypertext Transfer Protocol -- HTTP/1.1]
-link:technical/pack-protocol.txt
-link:technical/protocol-capabilities.txt
+link:technical/pack-protocol.html
+link:technical/protocol-capabilities.html
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index fe723e4..ed01c98 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1977,7 +1977,7 @@ $ git clone http://yourserver.com/~you/proj.git
 -------------------------------------------------
 
 (See also
-link:howto/setup-git-server-over-http.txt[setup-git-server-over-http]
+link:howto/setup-git-server-over-http.html[setup-git-server-over-http]
 for a slightly more sophisticated setup using WebDAV which also
 allows pushing over HTTP.)
 
@@ -3191,7 +3191,7 @@ those "loose" objects.
 You can save space and make Git faster by moving these loose objects in
 to a "pack file", which stores a group of objects in an efficient
 compressed format; the details of how pack files are formatted can be
-found in link:technical/pack-format.txt[technical/pack-format.txt].
+found in link:technical/pack-format.html[pack format].
 
 To put the loose objects into a pack, just run git repack:
 
-- 
1.8.3.msysgit.1.3.g5b82b42.dirty
