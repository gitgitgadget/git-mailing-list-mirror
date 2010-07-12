From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] format-patch: document the format.to configuration setting
Date: Mon, 12 Jul 2010 20:58:38 +0200
Message-ID: <20100712185838.GR31048@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 12 20:58:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYODH-0000sx-Jj
	for gcvg-git-2@lo.gmane.org; Mon, 12 Jul 2010 20:58:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756523Ab0GLS6m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jul 2010 14:58:42 -0400
Received: from virgo.iok.hu ([212.40.97.103]:42716 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754082Ab0GLS6m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jul 2010 14:58:42 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 55A745809D;
	Mon, 12 Jul 2010 20:58:39 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 3B379B1306;
	Mon, 12 Jul 2010 20:58:39 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 0F61512D90F0; Mon, 12 Jul 2010 20:58:39 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150842>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

Reported by leo2007 on IRC.

 Documentation/config.txt |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 72949e7..877f78d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -886,6 +886,10 @@ format.headers::
 	Additional email headers to include in a patch to be submitted
 	by mail.  See linkgit:git-format-patch[1].
 
+format.to::
+	Additional "To:" headers to include in a patch to be submitted
+	by mail.  See the --to option in linkgit:git-format-patch[1].
+
 format.cc::
 	Additional "Cc:" headers to include in a patch to be submitted
 	by mail.  See the --cc option in linkgit:git-format-patch[1].
-- 
1.7.0
