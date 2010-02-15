From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: [PATCH v2] Documentation: Fix indentation problem in git-commit(1)
Date: Mon, 15 Feb 2010 04:33:06 -0800
Message-ID: <1266237186-8065-1-git-send-email-jacob.helwig@gmail.com>
References: <201002151008.31980.trast@student.ethz.ch>
Cc: Thomas Rast <trast@student.ethz.ch>,
	Jacob Helwig <jacob.helwig@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 15 13:33:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nh09C-0004M0-H4
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 13:33:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755486Ab0BOMds (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 07:33:48 -0500
Received: from mail-pz0-f197.google.com ([209.85.222.197]:37214 "EHLO
	mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751550Ab0BOMdr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 07:33:47 -0500
Received: by pzk35 with SMTP id 35so164112pzk.33
        for <git@vger.kernel.org>; Mon, 15 Feb 2010 04:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=/JVWC67jyNsZzviqIG/2lws4oLa12LUzcplBXIgkFls=;
        b=RiqsYi0jpjQRxGdON7pSy5b2YWh5N12KfiImwDVAzWFxeO14F4k2J+cWQA2V7zs9pL
         Z8bT12iyRn6IE5Wk6WBrPXitudUq9GlBNTA1+GbKGOTJQcTBK0YOORg7tUWIObgDQDkR
         g4ThH5kWTkOKJgalGbJhNilhM55WsAWVuBiDs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=JTsebF8wPvBxhV8yqkUgJgbLUiuDT+l9KsRzwPGrU0MzG+plLSnJXtB9YB91P1Hi2C
         mbpmTAuUe2n6lgkqWCwyjLEPezRXBgDlD/XrcNFHLq3Pxkipq/2Cz5ela9tjjX5ye3az
         NiqMP1bBRZWQcMDEQj/WuajzKquKE/W9xnnJw=
Received: by 10.114.189.27 with SMTP id m27mr3389740waf.221.1266237227067;
        Mon, 15 Feb 2010 04:33:47 -0800 (PST)
Received: from localhost.localdomain ([96.225.220.117])
        by mx.google.com with ESMTPS id 22sm5512675pzk.13.2010.02.15.04.33.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 15 Feb 2010 04:33:45 -0800 (PST)
X-Mailer: git-send-email 1.7.0
In-Reply-To: <201002151008.31980.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140007>

Ever since the "See linkgit:git-config[1]..." paragraph was added to the
description for --untracked-files (d6293d1), the paragraphs for the
following options were indented at the same level as the "See
linkgit:git-config[1]" paragraph.  This problem showed up in the
manpages, but not in the HTML documentation.

While this does fix the alignment of the options following
--untracked-files in the manpage, the "See linkgit..." portion of the
description does not retain its previous indentation level in the
manpages, or HTML documentation.

Signed-off-by: Jacob Helwig <jacob.helwig@gmail.com>
Acked-by: Thomas Rast <trast@student.ethz.ch>
---

When adding the caveat to the commit message, the introductory comment
paragraph I had before seemed to fit better; I decided to go with a
version of it, instead.

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
