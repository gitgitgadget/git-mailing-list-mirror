From: Jeff King <peff@peff.net>
Subject: [PATCHv3 01/11] Makefile: sort LIB_H list
Date: Wed, 20 Jun 2012 14:30:08 -0400
Message-ID: <20120620183008.GA30995@sigill.intra.peff.net>
References: <20120620182855.GA26948@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 20 20:30:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShPfV-0004PL-Ab
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 20:30:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932552Ab2FTSaN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 14:30:13 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:38988
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932445Ab2FTSaL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 14:30:11 -0400
Received: (qmail 26747 invoked by uid 107); 20 Jun 2012 18:30:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Jun 2012 14:30:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Jun 2012 14:30:08 -0400
Content-Disposition: inline
In-Reply-To: <20120620182855.GA26948@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200317>

This was mostly sorted already, but put things like
"cache-tree.h" after "cache.h", even though "-" comes before
"." (at least in the C locale). This will make it easier to
keep the list sorted later by piping it through "sort".

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 62de0b4..72cdb56 100644
--- a/Makefile
+++ b/Makefile
@@ -595,8 +595,8 @@ LIB_H += attr.h
 LIB_H += blob.h
 LIB_H += builtin.h
 LIB_H += bulk-checkin.h
-LIB_H += cache.h
 LIB_H += cache-tree.h
+LIB_H += cache.h
 LIB_H += color.h
 LIB_H += commit.h
 LIB_H += compat/bswap.h
@@ -636,13 +636,13 @@ LIB_H += mailmap.h
 LIB_H += merge-file.h
 LIB_H += merge-recursive.h
 LIB_H += mergesort.h
-LIB_H += notes.h
 LIB_H += notes-cache.h
 LIB_H += notes-merge.h
+LIB_H += notes.h
 LIB_H += object.h
-LIB_H += pack.h
 LIB_H += pack-refs.h
 LIB_H += pack-revindex.h
+LIB_H += pack.h
 LIB_H += parse-options.h
 LIB_H += patch-ids.h
 LIB_H += pkt-line.h
@@ -668,8 +668,8 @@ LIB_H += submodule.h
 LIB_H += tag.h
 LIB_H += thread-utils.h
 LIB_H += transport.h
-LIB_H += tree.h
 LIB_H += tree-walk.h
+LIB_H += tree.h
 LIB_H += unpack-trees.h
 LIB_H += userdiff.h
 LIB_H += utf8.h
-- 
1.7.11.5.gc0eeaa8
