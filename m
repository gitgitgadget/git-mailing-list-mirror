From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH] doc/git-daemon: add missing arguments to options
Date: Sat, 18 Apr 2009 11:44:07 +0200
Message-ID: <1240047847-24524-1-git-send-email-markus.heidelberg@web.de>
Cc: git@vger.kernel.org, Markus Heidelberg <markus.heidelberg@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 18 11:45:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lv77F-0002Iw-Gc
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 11:45:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753264AbZDRJoJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2009 05:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752826AbZDRJoI
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Apr 2009 05:44:08 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:42611 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751359AbZDRJoF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2009 05:44:05 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id 649B5FAAFF57;
	Sat, 18 Apr 2009 11:44:04 +0200 (CEST)
Received: from [89.59.75.158] (helo=localhost.localdomain)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1Lv75g-0001oG-00; Sat, 18 Apr 2009 11:44:04 +0200
X-Mailer: git-send-email 1.6.3.rc0.77.g079dc
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX19egk0zUH2ZEjBCbmd5zLsh91t/3O/5p52xEaHQ
	HrtqzEj7yVVvAx+HfAlLeqMGzZVLcbKDkoK+rmsRv1iX1YmB7O
	LFRZvvbUrDJjfmV+zwLA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116817>

Also fix some spellings and typos.

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 Documentation/git-daemon.txt |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index 36f00ae..a85121c 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -48,7 +48,7 @@ OPTIONS
 	'git-daemon' will refuse to start when this option is enabled and no
 	whitelist is specified.
 
---base-path::
+--base-path=path::
 	Remap all the path requests as relative to the given path.
 	This is sort of "GIT root" - if you run 'git-daemon' with
 	'--base-path=/srv/git' on example.com, then if you later try to pull
@@ -81,8 +81,8 @@ OPTIONS
 	Incompatible with --port, --listen, --user and --group options.
 
 --listen=host_or_ipaddr::
-	Listen on an a specific IP address or hostname.  IP addresses can
-	be either an IPv4 address or an IPV6 address if supported.  If IPv6
+	Listen on a specific IP address or hostname.  IP addresses can
+	be either an IPv4 address or an IPv6 address if supported.  If IPv6
 	is not supported, then --listen=hostname is also not supported and
 	--listen must be given an IPv4 address.
 	Incompatible with '--inetd' option.
@@ -90,17 +90,17 @@ OPTIONS
 --port=n::
 	Listen on an alternative port.  Incompatible with '--inetd' option.
 
---init-timeout::
+--init-timeout=n::
 	Timeout between the moment the connection is established and the
 	client request is received (typically a rather low value, since
 	that should be basically immediate).
 
---timeout::
+--timeout=n::
 	Timeout for specific client sub-requests. This includes the time
-	it takes for the server to process the sub-request and time spent
-	waiting for next client's request.
+	it takes for the server to process the sub-request and the time spent
+	waiting for the next client's request.
 
---max-connections::
+--max-connections=n::
 	Maximum number of concurrent clients, defaults to 32.  Set it to
 	zero for no limit.
 
@@ -150,7 +150,7 @@ the facility of inet daemon to achieve the same before spawning
 	Enable/disable the service site-wide per default.  Note
 	that a service disabled site-wide can still be enabled
 	per repository if it is marked overridable and the
-	repository enables the service with an configuration
+	repository enables the service with a configuration
 	item.
 
 --allow-override=service::
-- 
1.6.3.rc0.77.g079dc
