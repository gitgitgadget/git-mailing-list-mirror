From: =?UTF-8?q?David=20K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [PATCH] Minor improvement to the write-tree documentation
Date: Wed, 26 Aug 2009 16:04:54 +0200
Message-ID: <1251295494-18689-1-git-send-email-davidk@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?David=20K=C3=A5gedal?= <davidk@lysator.liu.se>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 26 16:05:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgJ7j-0001Up-DX
	for gcvg-git-2@lo.gmane.org; Wed, 26 Aug 2009 16:05:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757429AbZHZOFE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Aug 2009 10:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757420AbZHZOFD
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Aug 2009 10:05:03 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:49241 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757416AbZHZOFD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2009 10:05:03 -0400
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id E3D3140017;
	Wed, 26 Aug 2009 16:04:26 +0200 (CEST)
Received: by mail.lysator.liu.se (Postfix, from userid 1674)
	id D785940065; Wed, 26 Aug 2009 16:04:26 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb3 (2006-10-05) on 
	bernadotte.lysator.liu.se
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=5.0 tests=AWL autolearn=disabled 
	version=3.1.7-deb3
Received: from krank (unknown [62.20.90.206])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 9D19F40017;
	Wed, 26 Aug 2009 16:04:26 +0200 (CEST)
Received: by krank (Postfix, from userid 1000)
	id F032BDC7FA; Wed, 26 Aug 2009 16:05:02 +0200 (CEST)
X-Mailer: git-send-email 1.6.4.rc3.21.g3b9e
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127097>

Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
---
 Documentation/git-write-tree.txt |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-write-tree.txt b/Documentation/git-write=
-tree.txt
index 26d3850..3eee11f 100644
--- a/Documentation/git-write-tree.txt
+++ b/Documentation/git-write-tree.txt
@@ -12,7 +12,8 @@ SYNOPSIS
=20
 DESCRIPTION
 -----------
-Creates a tree object using the current index.
+Creates a tree object using the current index. The sha1 of the new
+tree object is printed to standard output.
=20
 The index must be in a fully merged state.
=20
--=20
1.6.4.rc3.21.g3b9e
