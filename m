From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: [PATCH] Documentation: Fix indentation problem in git-commit(1)
Date: Sun, 14 Feb 2010 16:45:17 -0800
Message-ID: <1266194717-25438-1-git-send-email-jacob.helwig@gmail.com>
Cc: Jacob Helwig <jacob.helwig@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 15 01:45:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ngp5o-0000ee-14
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 01:45:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753941Ab0BOApc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2010 19:45:32 -0500
Received: from mail-pz0-f197.google.com ([209.85.222.197]:51664 "EHLO
	mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753229Ab0BOApb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 19:45:31 -0500
Received: by pzk35 with SMTP id 35so848327pzk.33
        for <git@vger.kernel.org>; Sun, 14 Feb 2010 16:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=OdmyjWfsSVaTXEsyikNLwDumkIVmt7nMsnOA9rNznRU=;
        b=BMY5KK4G0qc7/7JskIYcSNjs3BKwMqPN3ElJOVbWqOYXEXdaqdXq8eI0HFTcvEVkts
         SMmEFZupslI74KHMFfbZKIELK3Cu/YlXoUrqXH573093VSXVNwzSFAzf0NagBq6zxlLx
         0skkeuAZivl3UL+H6MbTiKm+wkpTrDCI14+kQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=YhTH/9bh1dYOGiD9+mw/1mg+rNIsS0r8njIHMIKFMqt3+DQ9YRTtlpmOniRBtLK1rM
         1XBgPzKHa7ZDrtCuJpzcsEyZSYBJGT4hv1dPdLsFG2/AnPOfEAW8MexOkNq0F4Q+VD3D
         eFdYp//xnhgjWmAQ0cBzoc8w1phrABdsh/fJA=
Received: by 10.114.187.7 with SMTP id k7mr3008392waf.153.1266194731085;
        Sun, 14 Feb 2010 16:45:31 -0800 (PST)
Received: from localhost.localdomain ([96.225.220.117])
        by mx.google.com with ESMTPS id 22sm4560147pzk.13.2010.02.14.16.45.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Feb 2010 16:45:30 -0800 (PST)
X-Mailer: git-send-email 1.7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139952>

All options listed after "-u[<mode>], --untracked-files[=<mode>]" in the
git-commit(1) manpage ended up listed as though they were part of the
description for -u/--untracked-files.  This was introduced by d6293d1.

Signed-off-by: Jacob Helwig <jacob.helwig@gmail.com>
---

Ever since the "See linkgit:git-config[1]..." paragraph was added to the
description for the --untracked-files option (d6293d1), the paragraphs
for the following options were indented at the same level as the "See
linkgit:git-config[1]" paragraph.  This problem looks like it only
showed up in the manpages, not in the HTML documentation.

I'm not entirely happy with this patch, since the "See linkgit..."
paragraph does not retain its previous indentation level in the
manpages, or HTML documentation.

Unfortunately, I'm not very good with ASCIIDOC at all, so this is mainly
the result of me throwing things at the problem until I found something
that (mostly) works.  Hopefully this will be enough to grab the
attention of someone that's better with ASCIIDOC than I.

 Documentation/git-commit.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index e99bb14..64fb458 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -197,13 +197,13 @@ FROM UPSTREAM REBASE" section in linkgit:git-rebase[1].)
 	Show untracked files (Default: 'all').
 +
 The mode parameter is optional, and is used to specify
-the handling of untracked files. The possible options are:
+the handling of untracked files.
++
+The possible options are:
 +
---
 	- 'no'     - Show no untracked files
 	- 'normal' - Shows untracked files and directories
 	- 'all'    - Also shows individual files in untracked directories.
---
 +
 See linkgit:git-config[1] for configuration variable
 used to change the default for when the option is not
-- 
1.7.0
