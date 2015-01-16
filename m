From: Jeff King <peff@peff.net>
Subject: [PATCH 7/7] strbuf.h: group documentation for trim functions
Date: Fri, 16 Jan 2015 04:06:04 -0500
Message-ID: <20150116090604.GG31113@peff.net>
References: <20150116090225.GA30797@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 16 10:06:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YC2rC-00043k-GT
	for gcvg-git-2@plane.gmane.org; Fri, 16 Jan 2015 10:06:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753126AbbAPJGL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2015 04:06:11 -0500
Received: from cloud.peff.net ([50.56.180.127]:35449 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752638AbbAPJGH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2015 04:06:07 -0500
Received: (qmail 3029 invoked by uid 102); 16 Jan 2015 09:06:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 16 Jan 2015 03:06:07 -0600
Received: (qmail 23532 invoked by uid 107); 16 Jan 2015 09:06:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 16 Jan 2015 04:06:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Jan 2015 04:06:04 -0500
Content-Disposition: inline
In-Reply-To: <20150116090225.GA30797@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262546>

The relationship between these makes more sense if you read
them as a group, which can help people who are looking for
the right function. Let's give them a single comment.

Signed-off-by: Jeff King <peff@peff.net>
---
 strbuf.h | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/strbuf.h b/strbuf.h
index 61c9c73..1883494 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -164,19 +164,11 @@ static inline void strbuf_setlen(struct strbuf *sb, size_t len)
  */
 
 /**
- * Strip whitespace from the beginning and end of a string.
- * Equivalent to performing `strbuf_rtrim()` followed by `strbuf_ltrim()`.
+ * Strip whitespace from the beginning (`ltrim`), end (`rtrim`), or both side
+ * (`trim`) of a string.
  */
 extern void strbuf_trim(struct strbuf *);
-
-/**
- * Strip whitespace from the end of a string.
- */
 extern void strbuf_rtrim(struct strbuf *);
-
-/**
- * Strip whitespace from the beginning of a string.
- */
 extern void strbuf_ltrim(struct strbuf *);
 
 /**
-- 
2.2.1.425.g441bb3c
