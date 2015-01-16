From: Jeff King <peff@peff.net>
Subject: [PATCH 4/7] strbuf.h: format asciidoc code blocks as 4-space indent
Date: Fri, 16 Jan 2015 04:05:16 -0500
Message-ID: <20150116090515.GD31113@peff.net>
References: <20150116090225.GA30797@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 16 10:05:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YC2qN-0003mH-Dq
	for gcvg-git-2@plane.gmane.org; Fri, 16 Jan 2015 10:05:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752254AbbAPJFU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2015 04:05:20 -0500
Received: from cloud.peff.net ([50.56.180.127]:35427 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752783AbbAPJFS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2015 04:05:18 -0500
Received: (qmail 2942 invoked by uid 102); 16 Jan 2015 09:05:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 16 Jan 2015 03:05:18 -0600
Received: (qmail 23471 invoked by uid 107); 16 Jan 2015 09:05:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 16 Jan 2015 04:05:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Jan 2015 04:05:16 -0500
Content-Disposition: inline
In-Reply-To: <20150116090225.GA30797@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262543>

This is much easier to read when the whole thing is stuffed
inside a comment block. And there is precedent for this
convention in markdown (and just in general ascii text).

Signed-off-by: Jeff King <peff@peff.net>
---
 strbuf.h | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/strbuf.h b/strbuf.h
index ab5ff27..caa4dad 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -33,10 +33,9 @@
  *    NOTE: It is OK to "play" with the buffer directly if you work it this
  *    way:
  *
- *    ----
- *    strbuf_grow(sb, SOME_SIZE); <1>
- *    strbuf_setlen(sb, sb->len + SOME_OTHER_SIZE);
- *    ----
+ *        strbuf_grow(sb, SOME_SIZE); <1>
+ *        strbuf_setlen(sb, sb->len + SOME_OTHER_SIZE);
+ *
  *    <1> Here, the memory array starting at `sb->buf`, and of length
  *    `strbuf_avail(sb)` is all yours, and you can be sure that
  *    `strbuf_avail(sb)` is at least `SOME_SIZE`.
@@ -261,9 +260,7 @@ extern void strbuf_add(struct strbuf *, const void *, size_t);
  * NOTE: This function will *always* be implemented as an inline or a macro
  * using strlen, meaning that this is efficient to write things like:
  *
- * ----
- * strbuf_addstr(sb, "immediate string");
- * ----
+ *     strbuf_addstr(sb, "immediate string");
  *
  */
 static inline void strbuf_addstr(struct strbuf *sb, const char *s)
-- 
2.2.1.425.g441bb3c
