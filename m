From: Jelmer Vernooij <jelmer@samba.org>
Subject: [PATCH] Fix an incorrect reference to --set-all.
Date: Tue, 27 Dec 2011 03:03:45 +0100
Message-ID: <20111227020345.GA5045@vernstok.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 27 03:12:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RfMWP-00007V-EY
	for gcvg-git-2@lo.gmane.org; Tue, 27 Dec 2011 03:12:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752184Ab1L0CMF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Dec 2011 21:12:05 -0500
Received: from aurelia.vernstok.nl ([178.63.244.14]:47372 "EHLO
	aurelia.vernstok.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752183Ab1L0CMC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Dec 2011 21:12:02 -0500
X-Greylist: delayed 495 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Dec 2011 21:12:02 EST
Received: from ganieda.lan (localhost [127.0.0.1])
	by aurelia.vernstok.nl (Postfix) with ESMTPS id 053EE1C23A;
	Tue, 27 Dec 2011 03:03:46 +0100 (CET)
Received: by ganieda.lan (Postfix, from userid 1000)
	id C20693A0277; Tue, 27 Dec 2011 03:03:45 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187703>

Signed-off-by: Jelmer Vernooij <jelmer@samba.org>
---
 builtin/config.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 0315ad7..d35c06a 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -444,7 +444,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		ret = git_config_set(argv[0], value);
 		if (ret == CONFIG_NOTHING_SET)
 			error("cannot overwrite multiple values with a single value\n"
-			"       Use a regexp, --add or --set-all to change %s.", argv[0]);
+			"       Use a regexp, --add or --replace-all to change %s.", argv[0]);
 		return ret;
 	}
 	else if (actions == ACTION_SET_ALL) {
-- 
1.7.7.3
