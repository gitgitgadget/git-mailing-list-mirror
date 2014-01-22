From: Pete Wyckoff <pw@padd.com>
Subject: [PATCHv2 11/11] git p4 doc: use two-line style for options with multiple spellings
Date: Wed, 22 Jan 2014 17:47:29 -0500
Message-ID: <1390430849-11436-11-git-send-email-pw@padd.com>
References: <20140122224421.GB4047@padd.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 22 23:50:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W66dN-0006ct-Fc
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 23:50:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752886AbaAVWux (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jan 2014 17:50:53 -0500
Received: from honk.padd.com ([74.3.171.149]:41873 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751527AbaAVWuw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jan 2014 17:50:52 -0500
Received: from arf.padd.com (unknown [50.105.0.78])
	by honk.padd.com (Postfix) with ESMTPSA id 623177147;
	Wed, 22 Jan 2014 14:50:52 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id D07FC200AB; Wed, 22 Jan 2014 17:50:49 -0500 (EST)
X-Mailer: git-send-email 1.8.5.2.364.g6ac45cd
In-Reply-To: <20140122224421.GB4047@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240882>

Thomas Rast noticed the docs have a mix of styles when
it comes to options with multiple spellings.  Standardize
the couple in git-p4.txt that are odd.

Instead of:
  -n, --dry-run::

Do this:
  -n::
  --dry-run::

See
http://thread.gmane.org/gmane.comp.version-control.git/219936/focus=219945

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 Documentation/git-p4.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index 8cba16d..6ab5f94 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -168,7 +168,8 @@ All commands except clone accept these options.
 --git-dir <dir>::
 	Set the 'GIT_DIR' environment variable.  See linkgit:git[1].
 
---verbose, -v::
+-v::
+--verbose::
 	Provide more progress information.
 
 Sync options
@@ -279,7 +280,8 @@ These options can be used to modify 'git p4 submit' behavior.
 	Export tags from Git as p4 labels. Tags found in Git are applied
 	to the perforce working directory.
 
---dry-run, -n::
+-n::
+--dry-run::
 	Show just what commits would be submitted to p4; do not change
 	state in Git or p4.
 
-- 
1.8.5.2.364.g6ac45cd
