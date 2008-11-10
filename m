From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 4/4] git-remote: document the migration feature of the rename subcommand
Date: Mon, 10 Nov 2008 21:43:03 +0100
Message-ID: <ebcd8165be4bf4444692f6552aeb4d2ae6c32579.1226349595.git.vmiklos@frugalware.org>
References: <cover.1226349595.git.vmiklos@frugalware.org>
 <95e56b46e30b41af31da86789625c93511f1faef.1226349595.git.vmiklos@frugalware.org>
 <033bc63195299e494791e4e6d8a41f142d848bba.1226349595.git.vmiklos@frugalware.org>
 <b32cf68df41e417079a49dc02e46ffc0c571029b.1226349595.git.vmiklos@frugalware.org>
Cc: Jeff King <peff@peff.net>, Brandon Casey <casey@nrlssc.navy.mil>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 10 21:43:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzdbY-0003i8-1E
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 21:43:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753010AbYKJUmK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 15:42:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751748AbYKJUmJ
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 15:42:09 -0500
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:57762 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751774AbYKJUmG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 15:42:06 -0500
Received: from vmobile.example.net (dsl5401C2D3.pool.t-online.hu [84.1.194.211])
	by yugo.frugalware.org (Postfix) with ESMTPA id 7D793446CD1;
	Mon, 10 Nov 2008 21:42:04 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id B7E1E19DB17; Mon, 10 Nov 2008 21:43:04 +0100 (CET)
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <b32cf68df41e417079a49dc02e46ffc0c571029b.1226349595.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1226349595.git.vmiklos@frugalware.org>
References: <cover.1226349595.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100566>

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
