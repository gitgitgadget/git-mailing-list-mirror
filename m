From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] log: document the --decorate=auto option
Date: Fri, 27 May 2016 16:56:02 +0100
Message-ID: <57486E12.7030907@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 27 17:56:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6K7Q-0003y9-8t
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 17:56:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754768AbcE0P4H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2016 11:56:07 -0400
Received: from avasout01.plus.net ([84.93.230.227]:33905 "EHLO
	avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753187AbcE0P4G (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2016 11:56:06 -0400
Received: from [10.0.2.15] ([84.92.139.254])
	by avasout01 with smtp
	id zTw21s0055VX2mk01Tw3NY; Fri, 27 May 2016 16:56:04 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=bsGxfxui c=1 sm=1 tr=0
 a=RCQFcU9wfaUQolwYLdiqXg==:117 a=RCQFcU9wfaUQolwYLdiqXg==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=EBOSESyhAAAA:8 a=PDRV5jgpUyT7GBsJrWUA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295764>


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Junio,

While reading an email from Linus earlier (RFC: dynamic "auto" date formats),
I noticed that log.decorate was being set to 'auto'. Since I didn't recall
that setting (even if it's easy to guess), I went looking for the documentation ...

This should probably be marked RFC, since I haven't checked that the formatting
is OK (I don't have the documentation toolchain installed these days).

ATB,
Ramsay Jones

 Documentation/config.txt  | 5 ++++-
 Documentation/git-log.txt | 8 +++++---
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 53f00db..0707b3b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1956,7 +1956,10 @@ log.decorate::
 	command. If 'short' is specified, the ref name prefixes 'refs/heads/',
 	'refs/tags/' and 'refs/remotes/' will not be printed. If 'full' is
 	specified, the full ref name (including prefix) will be printed.
-	This is the same as the log commands '--decorate' option.
+	If 'auto' is specified, then if the output is going to a terminal,
+	the ref names are shown as if 'short' were given, otherwise no ref
+	names are shown. This is the same as the log commands '--decorate'
+	option.
 
 log.follow::
 	If `true`, `git log` will act as if the `--follow` option was used when
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 03f9580..dec379b 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -29,12 +29,14 @@ OPTIONS
 	(works only for a single file).
 
 --no-decorate::
---decorate[=short|full|no]::
+--decorate[=short|full|auto|no]::
 	Print out the ref names of any commits that are shown. If 'short' is
 	specified, the ref name prefixes 'refs/heads/', 'refs/tags/' and
 	'refs/remotes/' will not be printed. If 'full' is specified, the
-	full ref name (including prefix) will be printed. The default option
-	is 'short'.
+	full ref name (including prefix) will be printed. If 'auto' is
+	specified, then if the output is going to a terminal, the ref names
+	are shown as if 'short' were given, otherwise no ref names are
+	shown. The default option is 'short'.
 
 --source::
 	Print out the ref name given on the command line by which each
-- 
2.8.0
