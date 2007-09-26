From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] git-bundle: fix commandline examples in the manpage
Date: Thu, 27 Sep 2007 01:34:59 +0200
Message-ID: <1190849699-11265-1-git-send-email-vmiklos@frugalware.org>
Cc: git@vger.kernel.org, Miklos Vajna <vmiklos@frugalware.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 27 01:36:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IagQi-0002Vv-6L
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 01:36:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbXIZXgN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2007 19:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752294AbXIZXgM
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Sep 2007 19:36:12 -0400
Received: from virgo.iok.hu ([193.202.89.103]:60050 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750869AbXIZXgL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2007 19:36:11 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 463021B252C;
	Thu, 27 Sep 2007 01:36:09 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 25B456FCDD;
	Thu, 27 Sep 2007 01:36:09 +0200 (CEST)
Received: from vmobile.example.net (dsl5401CB81.pool.t-online.hu [84.1.203.129])
	by genesis.frugalware.org (Postfix) with ESMTP id 8E95313A4126;
	Thu, 27 Sep 2007 01:36:08 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 7B1A58B7E1; Thu, 27 Sep 2007 01:34:59 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.2.80.g077d6f-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59255>

Multiple commands were displayed in one line, making the manpage hard to read.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 Documentation/git-bundle.txt |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index 5051e2b..0cc6511 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -103,14 +103,20 @@ We set a tag in R1 (lastR2bundle) after the previous such transport,
 and move it afterwards to help build the bundle.
 
 in R1 on A:
+
+------------
 $ git-bundle create mybundle master ^lastR2bundle
 $ git tag -f lastR2bundle master
+------------
 
 (move mybundle from A to B by some mechanism)
 
 in R2 on B:
+
+------------
 $ git-bundle verify mybundle
 $ git-fetch mybundle  refspec
+------------
 
 where refspec is refInBundle:localRef
 
@@ -124,9 +130,11 @@ Also, with something like this in your config:
 You can first sneakernet the bundle file to ~/tmp/file.bdl and
 then these commands:
 
+------------
 $ git ls-remote bundle
 $ git fetch bundle
 $ git pull bundle
+------------
 
 would treat it as if it is talking with a remote side over the
 network.
-- 
1.5.3.2.80.g077d6f-dirty
