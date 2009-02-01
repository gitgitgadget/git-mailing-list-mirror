From: jidanni@jidanni.org
Subject: Re: [PATCH,v2] git-bundle(1): add no references required simplest case
Date: Mon, 02 Feb 2009 07:42:51 +0800
Message-ID: <87pri12078.fsf@jidanni.org>
References: <87tz7i6scg.fsf_-_@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mdl123@verizon.net, spearce@spearce.org, git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Feb 02 00:48:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTm32-00009i-7w
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 00:48:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752137AbZBAXm4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Feb 2009 18:42:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751631AbZBAXm4
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Feb 2009 18:42:56 -0500
Received: from sd-green-bigip-81.dreamhost.com ([208.97.132.81]:45239 "EHLO
	homiemail-a3.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751300AbZBAXmz (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Feb 2009 18:42:55 -0500
Received: from jidanni.org (122-127-32-160.dynamic.hinet.net [122.127.32.160])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a3.dreamhost.com (Postfix) with ESMTP id 33C6CC544A;
	Sun,  1 Feb 2009 15:42:54 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108026>

Words totally by Junio C Hamano.
Signed-off-by: jidanni <jidanni@jidanni.org>
---

Junio: I used your words.
You might have missed this patch. Resending.


 Documentation/git-bundle.txt |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index 1b66ab7..42c2abc 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -164,6 +164,22 @@ $ git pull bundle
 would treat it as if it is talking with a remote side over the
 network.
 
+A complete bundle is one that does not require you to have any
+prerequisite object for you to extract its contents.  Not only you
+can fetch/pull from a bundle, you can clone from a complete bundle
+as if it was a remote repository, like this:
+
+----------------
+$ git clone /home/me/tmp/file.bdl mine.git
+----------------
+
+This will define a remote called "origin" in the resulting
+repository that lets you fetch and pull from the bundle, just
+like the previous example lets you do with the remote called
+"bundle", and from then on you can fetch/pull to update the
+resulting mine.git repository after replacing the bundle you store
+at /home/me/tmp/file.bdl with incremental updates.
+
 Author
 ------
 Written by Mark Levedahl <mdl123@verizon.net>
-- 
1.6.0.6
