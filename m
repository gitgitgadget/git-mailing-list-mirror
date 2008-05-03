From: Ping Yin <pkufranky@gmail.com>
Subject: Re: [PATCH] Make boundary characters for --color-words configurable
Date: Sat,  3 May 2008 08:22:58 +0800
Message-ID: <1209774178-26552-1-git-send-email-pkufranky@gmail.com>
References: <20080502143650.GB3079@mithlond.arda.local>
Cc: gitster@pobox.com, git@vger.kernel.org,
	Ping Yin <pkufranky@gmail.com>
To: tlikonen@iki.fi
X-From: git-owner@vger.kernel.org Sat May 03 02:23:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Js5XY-0006Gy-HB
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 02:23:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764202AbYECAXB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 20:23:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763583AbYECAXA
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 20:23:00 -0400
Received: from mail.qikoo.org ([60.28.205.235]:60951 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1760639AbYECAXA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 20:23:00 -0400
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id AFBCA470AE; Sat,  3 May 2008 08:22:58 +0800 (CST)
X-Mailer: git-send-email 1.5.5.1.117.g73010
In-Reply-To: <20080502143650.GB3079@mithlond.arda.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81053>

Signed-off-by: Ping Yin <pkufranky@gmail.com>
---
> I think config variables should be in alphabetical order in config.txt.
> Hence your diff.nonwordchars is not in the right place

THX, this is fixing patch

 Documentation/config.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index eb05592..812ec2c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -537,6 +537,10 @@ diff.external::
 	program only on a subset of your files, you might want to
 	use linkgit:gitattributes[5] instead.
 
+diff.nonwordchars::
+	Specify additional boundary characters other than spaces for
+	--color-words.
+
 diff.renameLimit::
 	The number of files to consider when performing the copy/rename
 	detection; equivalent to the git diff option '-l'.
@@ -546,10 +550,6 @@ diff.renames::
 	will enable basic rename detection.  If set to "copies" or
 	"copy", it will detect copies, as well.
 
-diff.nonwordchars::
-    Specify additional boundary characters other than spaces for
-    --color-words.
-
 fetch.unpackLimit::
 	If the number of objects fetched over the git native
 	transfer is below this
-- 
1.5.5.1.117.g73010
