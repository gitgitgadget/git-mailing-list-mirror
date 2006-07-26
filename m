From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH] Add description on how to use an HTTP proxy with git.
Date: Thu, 27 Jul 2006 00:23:19 +0200
Message-ID: <20060726222319.22350.57222.stgit@lathund.dewire.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Thu Jul 27 00:22:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5rmL-0000AD-B6
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 00:22:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbWGZWWy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Jul 2006 18:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751798AbWGZWWy
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Jul 2006 18:22:54 -0400
Received: from [83.140.172.130] ([83.140.172.130]:57457 "EHLO
	torino.dewire.com") by vger.kernel.org with ESMTP id S1751221AbWGZWWx
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jul 2006 18:22:53 -0400
Received: from localhost (localhost [127.0.0.1])
	by torino.dewire.com (Postfix) with ESMTP id 31D52802E19
	for <git@vger.kernel.org>; Thu, 27 Jul 2006 00:20:59 +0200 (CEST)
Received: from torino.dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 24395-05 for <git@vger.kernel.org>; Thu, 27 Jul 2006 00:20:58 +0200 (CEST)
Received: from lathund.dewire.com (unknown [10.9.0.3])
	by torino.dewire.com (Postfix) with ESMTP id DF1DB802E04
	for <git@vger.kernel.org>; Thu, 27 Jul 2006 00:20:58 +0200 (CEST)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id ADAB22833C
	for <git@vger.kernel.org>; Thu, 27 Jul 2006 00:23:19 +0200 (CEST)
To: git@vger.kernel.org
User-Agent: StGIT/0.10
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24255>

From: Robin Rosenberg <robin.rosenberg@dewire.com>


---

 Documentation/urls.txt |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/Documentation/urls.txt b/Documentation/urls.txt
index 7477413..fb94162 100644
--- a/Documentation/urls.txt
+++ b/Documentation/urls.txt
@@ -8,6 +8,13 @@ to name the remote repository:
 - rsync://host.xz/path/to/repo.git/
 - http://host.xz/path/to/repo.git/
 - https://host.xz/path/to/repo.git/
+===============================================================
+
+If you need to use an HTTP proxy you can set the `http_proxy`
+environment variable to a suitable value, e.g.
+`proxy.mydomain.com:8080`. This is a libcurl feature.
+
+===============================================================
 - git://host.xz/path/to/repo.git/
 - git://host.xz/~user/path/to/repo.git/
 - ssh://host.xz/path/to/repo.git/
@@ -15,7 +22,7 @@ to name the remote repository:
 - ssh://host.xz/~/path/to/repo.git
 ===============================================================
 
-SSH Is the default transport protocol and also supports an
+SSH is the default transport protocol and also supports an
 scp-like syntax.  Both syntaxes support username expansion,
 as does the native git protocol. The following three are
 identical to the last three above, respectively:
