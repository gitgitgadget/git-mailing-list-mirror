From: vfr@lyx.org
Subject: [PATCH] builtin-reset: Documentation update
Date: Wed, 23 Nov 2011 07:44:16 +0100
Message-ID: <1322030656-18683-1-git-send-email-vfr@lyx.org>
Cc: gitster@pobox.com, Vincent van Ravesteijn <vfr@lyx.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 23 07:44:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RT6ZV-0004rU-Cc
	for gcvg-git-2@lo.gmane.org; Wed, 23 Nov 2011 07:44:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755187Ab1KWGog (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Nov 2011 01:44:36 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:44960 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753048Ab1KWGof (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2011 01:44:35 -0500
Received: by bke11 with SMTP id 11so1216259bke.19
        for <git@vger.kernel.org>; Tue, 22 Nov 2011 22:44:34 -0800 (PST)
Received: by 10.205.83.73 with SMTP id af9mr22718900bkc.24.1322030674353;
        Tue, 22 Nov 2011 22:44:34 -0800 (PST)
Received: from vincent-VirtualBox.tudelft.nl (221-44.206-83.static-ip.oleane.fr. [83.206.44.221])
        by mx.google.com with ESMTPS id j9sm11948099bkd.2.2011.11.22.22.44.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 22 Nov 2011 22:44:33 -0800 (PST)
X-Mailer: git-send-email 1.7.8-rc3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185822>

From: Vincent van Ravesteijn <vfr@lyx.org>

The second mode of 'git reset' is defined by the --patch
option, while the third mode is defined by the <mode> option.
Hence, these options are mandatory in the description of the
individual modes.

Signed-off-by: Vincent van Ravesteijn <vfr@lyx.org>
---
 Documentation/git-reset.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index b2832fc..b674866 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -9,8 +9,8 @@ SYNOPSIS
 --------
 [verse]
 'git reset' [-q] [<commit>] [--] <paths>...
-'git reset' [--patch|-p] [<commit>] [--] [<paths>...]
-'git reset' [--soft | --mixed | --hard | --merge | --keep] [-q] [<commit>]
+'git reset' (--patch | -p) [<commit>] [--] [<paths>...]
+'git reset' (--soft | --mixed | --hard | --merge | --keep) [-q] [<commit>]
 
 DESCRIPTION
 -----------
@@ -34,7 +34,7 @@ Alternatively, using linkgit:git-checkout[1] and specifying a commit, you
 can copy the contents of a path out of a commit to the index and to the
 working tree in one go.
 
-'git reset' --patch|-p [<commit>] [--] [<paths>...]::
+'git reset' (--patch | -p) [<commit>] [--] [<paths>...]::
 	Interactively select hunks in the difference between the index
 	and <commit> (defaults to HEAD).  The chosen hunks are applied
 	in reverse to the index.
@@ -43,7 +43,7 @@ This means that `git reset -p` is the opposite of `git add -p`, i.e.
 you can use it to selectively reset hunks. See the ``Interactive Mode''
 section of linkgit:git-add[1] to learn how to operate the `\--patch` mode.
 
-'git reset' [--<mode>] [<commit>]::
+'git reset' --<mode> [<commit>]::
 	This form resets the current branch head to <commit> and
 	possibly updates the index (resetting it to the tree of <commit>) and
 	the working tree depending on <mode>, which
-- 
1.7.8-rc3
