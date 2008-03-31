From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 3/4] Documentation/hooks: add pre-auto-gc hook
Date: Mon, 31 Mar 2008 11:36:44 +0200
Message-ID: <0a4fb03744d2a8c3e38030a29098e25823aed6bc.1206929014.git.vmiklos@frugalware.org>
References: <alpine.LFD.1.00.0803301645020.14670@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bj?rn Steinbrink <B.Steinbrink@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Mar 31 11:37:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgGSh-000352-UR
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 11:37:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756177AbYCaJgr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2008 05:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756101AbYCaJgr
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Mar 2008 05:36:47 -0400
Received: from virgo.iok.hu ([193.202.89.103]:11268 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756073AbYCaJgq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2008 05:36:46 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 1C6281B258A;
	Mon, 31 Mar 2008 11:36:45 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 94CF644698;
	Mon, 31 Mar 2008 11:33:36 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id A22C71190547; Mon, 31 Mar 2008 11:36:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0803301645020.14670@woody.linux-foundation.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78577>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 Documentation/hooks.txt |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/Documentation/hooks.txt b/Documentation/hooks.txt
index 76b8d77..04ec352 100644
--- a/Documentation/hooks.txt
+++ b/Documentation/hooks.txt
@@ -276,3 +276,13 @@ probably enable this hook.
 Both standard output and standard error output are forwarded to
 `git-send-pack` on the other end, so you can simply `echo` messages
 for the user.
+
+pre-auto-gc
+-----------
+
+This hook is invoked by `git-gc --auto`, and can be bypassed with
+`\--no-verify` option.  It takes no parameter, and exiting with non-zero
+status from this script causes the `git-gc --auto` to abort.
+
+The default 'pre-auto-gc' hook, when enabled, defers auto repacking when
+you are on battery.
-- 
1.5.5.rc2.4.g283c6
