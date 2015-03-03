From: Kevin Daudt <me@ikke.info>
Subject: [PATCH 2/2] docs: explain behaviour of remote add without tag option
Date: Wed,  4 Mar 2015 00:12:00 +0100
Message-ID: <1425424320-4091-2-git-send-email-me@ikke.info>
References: <1425424320-4091-1-git-send-email-me@ikke.info>
Cc: git@vger.kernel.org, Kevin Daudt <me@ikke.info>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Mar 04 00:12:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSvz9-00023D-C0
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 00:12:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757543AbbCCXML (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2015 18:12:11 -0500
Received: from ikke.info ([178.21.113.177]:59932 "EHLO vps892.directvps.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757174AbbCCXMJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2015 18:12:09 -0500
Received: by vps892.directvps.nl (Postfix, from userid 182)
	id 0DF8D4400B1; Wed,  4 Mar 2015 00:12:07 +0100 (CET)
Received: from ikke-laptop.ikke (unknown [10.8.0.6])
	by vps892.directvps.nl (Postfix) with ESMTP id 691444400AE;
	Wed,  4 Mar 2015 00:12:07 +0100 (CET)
X-Mailer: git-send-email 2.3.0
In-Reply-To: <1425424320-4091-1-git-send-email-me@ikke.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264704>

Only behaviour with these options are currently explained. Add
explanation what the default behaviour is.

Signed-off-by: Kevin Daudt <me@ikke.info>
---
 Documentation/git-remote.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index a77607b..5bde0e1 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -58,6 +58,9 @@ remote repository.
 With `--no-tags` option, `git fetch <name>` does not import tags from
 the remote repository.
 +
+With neither `--tags` or `--no-tags` set, imports only tags that are
+reachable from downloaded history.
++
 With `-t <branch>` option, instead of the default glob
 refspec for the remote to track all branches under
 the `refs/remotes/<name>/` namespace, a refspec to track only `<branch>`
-- 
2.3.0
