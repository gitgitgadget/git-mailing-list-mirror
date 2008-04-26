From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 2/2] Documentation: include diff-tree-options in git-show manpage.
Date: Sat, 26 Apr 2008 23:01:07 +0200
Message-ID: <499fc547c6316f25967c71f0991a027482dab349.1209243527.git.vmiklos@frugalware.org>
References: <b57b2d5d484b6e099382900069ed6ca2afc6922d.1209243527.git.vmiklos@frugalware.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 26 23:02:21 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JprXI-0002uZ-Rj
	for gcvg-git-2@gmane.org; Sat, 26 Apr 2008 23:02:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760393AbYDZVBg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Apr 2008 17:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760332AbYDZVBf
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Apr 2008 17:01:35 -0400
Received: from virgo.iok.hu ([193.202.89.103]:45164 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757329AbYDZVB0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Apr 2008 17:01:26 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id B7AEE1B25A2;
	Sat, 26 Apr 2008 23:01:23 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 7DB7444659;
	Sat, 26 Apr 2008 22:57:43 +0200 (CEST)
Received: from vmobile.example.net (dsl5401CCC2.pool.t-online.hu [84.1.204.194])
	by genesis.frugalware.org (Postfix) with ESMTP id DD37D11901AE;
	Sat, 26 Apr 2008 23:01:20 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id ABC2C186103; Sat, 26 Apr 2008 23:01:07 +0200 (CEST)
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <b57b2d5d484b6e099382900069ed6ca2afc6922d.1209243527.git.vmiklos@frugalware.org>
In-Reply-To: <b57b2d5d484b6e099382900069ed6ca2afc6922d.1209243527.git.vmiklos@frugalware.org>
References: <b57b2d5d484b6e099382900069ed6ca2afc6922d.1209243527.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80392>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 Documentation/git-show.txt |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-show.txt b/Documentation/git-show.txt
index dccf0e2..b1fa879 100644
--- a/Documentation/git-show.txt
+++ b/Documentation/git-show.txt
@@ -25,12 +25,6 @@ with \--name-only).
 
 For plain blobs, it shows the plain contents.
 
-The command takes options applicable to the linkgit:git-diff-tree[1] command to
-control how the changes the commit introduces are shown.
-
-This manual page describes only the most frequently used options.
-
-
 OPTIONS
 -------
 <object>::
@@ -38,6 +32,9 @@ OPTIONS
 	For a more complete list of ways to spell object names, see
 	"SPECIFYING REVISIONS" section in linkgit:git-rev-parse[1].
 
+include::diff-tree-options.txt[]
+
+
 include::pretty-options.txt[]
 
 
-- 
1.5.5.1
