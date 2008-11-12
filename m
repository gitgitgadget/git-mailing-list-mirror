From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 4/4] git-remote: document the migration feature of the rename subcommand
Date: Wed, 12 Nov 2008 18:11:04 +0100
Message-ID: <a8b13b05417ca3ecc360472c7c44e824402aa6e6.1226508805.git.vmiklos@frugalware.org>
References: <cover.1226508805.git.vmiklos@frugalware.org>
 <95e56b46e30b41af31da86789625c93511f1faef.1226508805.git.vmiklos@frugalware.org>
 <d99804ad3579d4882e8241d9dcaee1b7dd6508af.1226508805.git.vmiklos@frugalware.org>
 <c3744d00a3d612a637cf520d2719492265e4f061.1226508805.git.vmiklos@frugalware.org>
Cc: Jeff King <peff@peff.net>, Brandon Casey <casey@nrlssc.navy.mil>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 12 18:12:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0JFr-00065i-Ux
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 18:11:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752601AbYKLRKK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 12:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752243AbYKLRKJ
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 12:10:09 -0500
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:50009 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752178AbYKLRKG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 12:10:06 -0500
Received: from vmobile.example.net (dsl5401C37A.pool.t-online.hu [84.1.195.122])
	by yugo.frugalware.org (Postfix) with ESMTPA id A3F12446CD2;
	Wed, 12 Nov 2008 18:10:03 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id F1B5419DB17; Wed, 12 Nov 2008 18:11:04 +0100 (CET)
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <c3744d00a3d612a637cf520d2719492265e4f061.1226508805.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1226508805.git.vmiklos@frugalware.org>
References: <cover.1226508805.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100775>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 Documentation/git-remote.txt |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 7b227b3..fad983e 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -66,6 +66,10 @@ was passed.
 
 Rename the remote named <old> to <new>. All remote tracking branches and
 configuration settings for the remote are updated.
++
+In case <old> and <new> are the same, and <old> is a file under
+`$GIT_DIR/remotes` or `$GIT_DIR/branches`, the remote is converted to
+the configuration file format.
 
 'rm'::
 
-- 
1.6.0.2
