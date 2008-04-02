From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 2/3] Documentation/hooks: add pre-auto-gc hook
Date: Wed, 2 Apr 2008 21:34:55 +0200
Message-ID: <878a46b80a7b9129b520b522a3f35237c1a01f79.1207164676.git.vmiklos@frugalware.org>
References: <7vtzik848t.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bj?rn Steinbrink <B.Steinbrink@gmx.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 02 21:36:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jh8kv-00017y-7q
	for gcvg-git-2@gmane.org; Wed, 02 Apr 2008 21:36:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757839AbYDBTe5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2008 15:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757913AbYDBTe5
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Apr 2008 15:34:57 -0400
Received: from virgo.iok.hu ([193.202.89.103]:24897 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757783AbYDBTe4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2008 15:34:56 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 7CEF61B25B7;
	Wed,  2 Apr 2008 21:34:55 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 8E686446A7;
	Wed,  2 Apr 2008 21:31:44 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 542161190A16; Wed,  2 Apr 2008 21:34:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vtzik848t.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78707>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 Documentation/hooks.txt |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Documentation/hooks.txt b/Documentation/hooks.txt
index 76b8d77..44fbe58 100644
--- a/Documentation/hooks.txt
+++ b/Documentation/hooks.txt
@@ -276,3 +276,10 @@ probably enable this hook.
 Both standard output and standard error output are forwarded to
 `git-send-pack` on the other end, so you can simply `echo` messages
 for the user.
+
+pre-auto-gc
+-----------
+
+This hook is invoked by `git-gc --auto`. It takes no parameter, and
+exiting with non-zero status from this script causes the `git-gc --auto`
+to abort.
-- 
1.5.5.rc2.4.gec07.dirty
