From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Subject: [PATCH] Add some documentation.
Date: Fri, 26 Aug 2005 18:18:48 -0700
Message-ID: <430FBF78.6050204@gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Aug 27 03:19:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8pLY-0003aG-CL
	for gcvg-git@gmane.org; Sat, 27 Aug 2005 03:19:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965193AbVH0BSy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Aug 2005 21:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965194AbVH0BSy
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Aug 2005 21:18:54 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:41952 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965193AbVH0BSx (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Aug 2005 21:18:53 -0400
Received: by rproxy.gmail.com with SMTP id i8so671737rne
        for <git@vger.kernel.org>; Fri, 26 Aug 2005 18:18:51 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=HHZDGg8TksDKHh2rTyy9v2nAF1nQuATyC/9lXX4gKk/GwKmzOo4NegC96qWfqamk5FuM5H06WzBqMBhLjRZ+F/d1Keal+vWhymERbFXFOSd+yt5uRSkbN5Xiyw/jHebo6pY3k0W4l8BLrWNdGMmi2pTt6ilMvsqCcQtoHIqYowo=
Received: by 10.38.11.16 with SMTP id 16mr1007858rnk;
        Fri, 26 Aug 2005 18:18:51 -0700 (PDT)
Received: from ?12.145.154.227? ( [12.145.154.227])
        by mx.gmail.com with ESMTP id a29sm3233968rng.2005.08.26.18.18.50;
        Fri, 26 Aug 2005 18:18:51 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: git@vger.kernel.org, junkio@cox.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7834>

Add some documentation.

Text taken from the the commit messages and the command sources.

---

I made no attempt to use the proper terminology, as defined by the new
glossary, but instead used the text from the original commit messages and/or
the program source.

These are some of the easy ones. Some others (like git-diff-script) will
require real effort to adequately document.

Hopefully I followed my own instructions correctly and will avoid being hit
by the "shiny blue bat". :-)

 Documentation/git-add-script.txt           |   17 ++++++-----------
 Documentation/git-branch-script.txt        |   19 ++++++++++---------
 Documentation/git-cherry.txt               |   22 +++++++++++++---------
 Documentation/git-count-objects-script.txt |   18 ++++--------------
 Documentation/git-patch-id.txt             |   19 +++++++++----------
 Documentation/git-rebase-script.txt        |   17 +++++++----------
 Documentation/git-relink-script.txt        |   19 +++++++++----------
 Documentation/git-revert-script.txt        |   18 +++++++-----------
 Documentation/git-sh-setup-script.txt      |   18 +++++++-----------
 Documentation/git-verify-tag-script.txt    |   16 +++++-----------
 10 files changed, 77 insertions(+), 106 deletions(-)

a02a9ef2a347e4fac8088fb289dd24c7110c4ee4
diff --git a/Documentation/git-add-script.txt b/Documentation/git-add-script.txt
--- a/Documentation/git-add-script.txt
+++ b/Documentation/git-add-script.txt
@@ -3,26 +3,21 @@ git-add-script(1)

 NAME
 ----
-git-add-script - Some git command not yet documented.
-
+git-add-script - Add files to the cache.

 SYNOPSIS
 --------
-'git-add-script' [ --option ] <args>...
+'git-add-script' [<file>]\+

 DESCRIPTION
 -----------
-Does something not yet documented.
-
+A simple wrapper to git-update-cache to add files to the cache for people used
+to do "cvs add".

 OPTIONS
 -------
---option::
-	Some option not yet documented.
-
-<args>...::
-	Some argument not yet documented.
-
+<file>::
+	Files to add to the cache.

 Author
 ------
diff --git a/Documentation/git-branch-script.txt b/Documentation/git-branch-script.txt
--- a/Documentation/git-branch-script.txt
+++ b/Documentation/git-branch-script.txt
@@ -3,26 +3,27 @@ git-branch-script(1)

 NAME
 ----
-git-branch-script - Some git command not yet documented.
-
+git-branch-script - Create a new branch.

 SYNOPSIS
 --------
-'git-branch-script' [ --option ] <args>...
+'git-branch-script' [<branchname> [start-point]]

 DESCRIPTION
 -----------
-Does something not yet documented.
+If no argument is provided, show available branches and mark current
+branch with star. Otherwise, create a new branch of name <branchname>.

+If a starting point is also specified, that will be where the branch is
+created, otherwise it will be created at the current HEAD.

 OPTIONS
 -------
---option::
-	Some option not yet documented.
-
-<args>...::
-	Some argument not yet documented.
+<branchname>::
+	The name of the branch to create.

+start-point::
+	Where to make the branch; defaults to HEAD.

 Author
 ------
diff --git a/Documentation/git-cherry.txt b/Documentation/git-cherry.txt
--- a/Documentation/git-cherry.txt
+++ b/Documentation/git-cherry.txt
@@ -3,26 +3,30 @@ git-cherry(1)

 NAME
 ----
-git-cherry - Some git command not yet documented.
-
+git-cherry - Find commits not merged upstream.

 SYNOPSIS
 --------
-'git-cherry' [ --option ] <args>...
+'git-cherry' [-v] <upstream> [<head>]

 DESCRIPTION
 -----------
-Does something not yet documented.
-
+Each commit between the fork-point and <head> is examined, and compared against
+the change each commit between the fork-point and <upstream> introduces.
+Commits already included in upstream are prefixed with '-' (meaning "drop from
+my local pull"), while commits missing from upstream are prefixed with '+'
+(meaning "add to the updated upstream").

 OPTIONS
 -------
---option::
-	Some option not yet documented.
+-v::
+	Verbose.

-<args>...::
-	Some argument not yet documented.
+<upstream>::
+	Upstream branch to compare against.

+<head>::
+	Working branch; defaults to HEAD.

 Author
 ------
diff --git a/Documentation/git-count-objects-script.txt b/Documentation/git-count-objects-script.txt
--- a/Documentation/git-count-objects-script.txt
+++ b/Documentation/git-count-objects-script.txt
@@ -3,26 +3,16 @@ git-count-objects-script(1)

 NAME
 ----
-git-count-objects-script - Some git command not yet documented.
-
+git-count-objects-script - Reports on unpacked objects.

 SYNOPSIS
 --------
-'git-count-objects-script' [ --option ] <args>...
+'git-count-objects-script'

 DESCRIPTION
 -----------
-Does something not yet documented.
-
-
-OPTIONS
--------
---option::
-	Some option not yet documented.
-
-<args>...::
-	Some argument not yet documented.
-
+This counts the number of unpacked object files and disk space consumed by
+them, to help you decide when it is a good time to repack.

 Author
 ------
diff --git a/Documentation/git-patch-id.txt b/Documentation/git-patch-id.txt
--- a/Documentation/git-patch-id.txt
+++ b/Documentation/git-patch-id.txt
@@ -3,26 +3,25 @@ git-patch-id(1)

 NAME
 ----
-git-patch-id - Some git command not yet documented.
-
+git-patch-id - Generate a patch ID.

 SYNOPSIS
 --------
-'git-patch-id' [ --option ] <args>...
+'git-patch-id' < <patch>

 DESCRIPTION
 -----------
-Does something not yet documented.
+A "patch ID" is nothing but a SHA1 of the diff associated with a patch, with
+whitespace and line numbers ignored.  As such, it's "reasonably stable", but at
+the same time also reasonably unique, ie two patches that have the same "patch
+ID" are almost guaranteed to be the same thing.

+IOW, you can use this thing to look for likely duplicate commits.

 OPTIONS
 -------
---option::
-	Some option not yet documented.
-
-<args>...::
-	Some argument not yet documented.
-
+<patch>::
+	The diff to create the ID of.

 Author
 ------
diff --git a/Documentation/git-rebase-script.txt b/Documentation/git-rebase-script.txt
--- a/Documentation/git-rebase-script.txt
+++ b/Documentation/git-rebase-script.txt
@@ -3,26 +3,23 @@ git-rebase-script(1)

 NAME
 ----
-git-rebase-script - Some git command not yet documented.
-
+git-rebase-script - Rebase local commits to new upstream head.

 SYNOPSIS
 --------
-'git-rebase-script' [ --option ] <args>...
+'git-rebase-script' <upstream> [<head>]

 DESCRIPTION
 -----------
-Does something not yet documented.
-
+Rebases local commits to the new head of the upstream tree.'

 OPTIONS
 -------
---option::
-	Some option not yet documented.
-
-<args>...::
-	Some argument not yet documented.
+<upstream>::
+	Upstream branch to compare against.

+<head>::
+	Working branch; defaults to HEAD.

 Author
 ------
diff --git a/Documentation/git-relink-script.txt b/Documentation/git-relink-script.txt
--- a/Documentation/git-relink-script.txt
+++ b/Documentation/git-relink-script.txt
@@ -3,26 +3,25 @@ git-relink-script(1)

 NAME
 ----
-git-relink-script - Some git command not yet documented.
-
+git-relink-script - Hardlink common objects in local repositories.

 SYNOPSIS
 --------
-'git-relink-script' [ --option ] <args>...
+'git-relink-script' [--safe] <dir> <dir> [<dir>]\*

 DESCRIPTION
 -----------
-Does something not yet documented.
-
+This will scan 2 or more object repositories and look for common objects, check
+if they are hardlinked, and replace one with a hardlink to the other if not.

 OPTIONS
 -------
---option::
-	Some option not yet documented.
-
-<args>...::
-	Some argument not yet documented.
+--safe::
+	Stops if two objects with the same hash exist but have different sizes.
+	Default is to warn and continue.

+<dir>::
+	Directories containing a .git/objects/ subdirectory.

 Author
 ------
diff --git a/Documentation/git-revert-script.txt b/Documentation/git-revert-script.txt
--- a/Documentation/git-revert-script.txt
+++ b/Documentation/git-revert-script.txt
@@ -3,26 +3,22 @@ git-revert-script(1)

 NAME
 ----
-git-revert-script - Some git command not yet documented.
-
+git-revert-script - Revert an existing commit.

 SYNOPSIS
 --------
-'git-revert-script' [ --option ] <args>...
+'git-revert-script' <commit>

 DESCRIPTION
 -----------
-Does something not yet documented.
-
+Given one existing commit, revert the change the patch introduces, and record a
+new commit that records it.  This requires your working tree to be clean (no
+modifications from the HEAD commit).

 OPTIONS
 -------
---option::
-	Some option not yet documented.
-
-<args>...::
-	Some argument not yet documented.
-
+<commit>::
+	Commit to revert.

 Author
 ------
diff --git a/Documentation/git-sh-setup-script.txt b/Documentation/git-sh-setup-script.txt
--- a/Documentation/git-sh-setup-script.txt
+++ b/Documentation/git-sh-setup-script.txt
@@ -3,26 +3,22 @@ git-sh-setup-script(1)

 NAME
 ----
-git-sh-setup-script - Some git command not yet documented.
-
+git-sh-setup-script - Common git shell script setup code.

 SYNOPSIS
 --------
-'git-sh-setup-script' [ --option ] <args>...
+'git-sh-setup-script'

 DESCRIPTION
 -----------
-Does something not yet documented.
-

-OPTIONS
--------
---option::
-	Some option not yet documented.
+Sets up the normal git environment variables and a few helper functions
+(currently just "die()"), and returns ok if it all looks like a git archive.
+So use it something like

-<args>...::
-	Some argument not yet documented.
+	. git-sh-setup-script || die "Not a git archive"

+to make the rest of the git scripts more careful and readable.

 Author
 ------
diff --git a/Documentation/git-verify-tag-script.txt b/Documentation/git-verify-tag-script.txt
--- a/Documentation/git-verify-tag-script.txt
+++ b/Documentation/git-verify-tag-script.txt
@@ -3,26 +3,20 @@ git-verify-tag-script(1)

 NAME
 ----
-git-verify-tag-script - Some git command not yet documented.
-
+git-verify-tag-script - Check the GPG signature of tag.

 SYNOPSIS
 --------
-'git-verify-tag-script' [ --option ] <args>...
+'git-verify-tag-script' <tag>

 DESCRIPTION
 -----------
-Does something not yet documented.
-
+Validates the gpg signature created by git-tag-script.

 OPTIONS
 -------
---option::
-	Some option not yet documented.
-
-<args>...::
-	Some argument not yet documented.
-
+<tag>::
+	SHA1 identifier of a git tag object.

 Author
 ------
