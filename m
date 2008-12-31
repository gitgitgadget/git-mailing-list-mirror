From: jidanni@jidanni.org
Subject: [PATCH] Documentation/git-ls-files: --abbrev=<n> only useful with --stage
Date: Wed, 31 Dec 2008 09:38:39 +0800
Message-ID: <871vvpnmxs.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 31 03:55:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHrF1-0004uy-KT
	for gcvg-git-2@gmane.org; Wed, 31 Dec 2008 03:55:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755246AbYLaCyK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 21:54:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755243AbYLaCyG
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 21:54:06 -0500
Received: from sd-green-bigip-207.dreamhost.com ([208.97.132.207]:56816 "EHLO
	homiemail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755232AbYLaCyF (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Dec 2008 21:54:05 -0500
Received: from jidanni.org (122-127-43-96.dynamic.hinet.net [122.127.43.96])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a2.g.dreamhost.com (Postfix) with ESMTP id DB6AED272E
	for <git@vger.kernel.org>; Tue, 30 Dec 2008 18:54:03 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104244>

Else one wonders why one can't see the hex numbers it is talking about.

Signed-off-by: jidanni <jidanni@jidanni.org>
---
 Documentation/git-ls-files.txt |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 9f85d60..a1e952f 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -128,6 +128,7 @@ OPTIONS
 	Instead of showing the full 40-byte hexadecimal object
 	lines, show only handful hexdigits prefix.
 	Non default number of digits can be specified with --abbrev=<n>.
+	(Useful only with --stage.)
 
 \--::
 	Do not interpret any more arguments as options.
-- 
1.6.0.6
