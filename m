From: Teemu Likonen <tlikonen@iki.fi>
Subject: [PATCH] config.txt: Add missing colons after option name
Date: Fri, 29 Aug 2008 10:29:42 +0300
Message-ID: <20080829072942.GA4098@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mmogilvi_git@miniinfo.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 29 09:31:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYyRy-0007In-0K
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 09:31:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752028AbYH2HaM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 03:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751869AbYH2HaL
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 03:30:11 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:52274 "EHLO kirsi2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751782AbYH2HaK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 03:30:10 -0400
Received: from mithlond.arda.local (80.220.180.181) by kirsi2.inet.fi (8.5.014)
        id 488DC54E016BC225; Fri, 29 Aug 2008 10:29:43 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1KYyQQ-0001nN-1W; Fri, 29 Aug 2008 10:29:42 +0300
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

    gitcvs.usecrlfattr --> gitcvs.usecrlfattr::

This fixes an asciidoc markup issue.

Signed-off-by: Teemu Likonen <tlikonen@iki.fi>
---
 Documentation/config.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 866d0c3..2364b8d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -711,7 +711,7 @@ gitcvs.logfile::
 	Path to a log file where the CVS server interface well... logs
 	various stuff. See linkgit:git-cvsserver[1].
 
-gitcvs.usecrlfattr
+gitcvs.usecrlfattr::
 	If true, the server will look up the `crlf` attribute for
 	files to determine the '-k' modes to use. If `crlf` is set,
 	the '-k' mode will be left blank, so cvs clients will
-- 
1.6.0.1.129.g0a56
