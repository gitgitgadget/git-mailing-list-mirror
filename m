From: Jeff King <peff@peff.net>
Subject: [PATCH 2/7] strbuf.h: unify documentation comments beginnings
Date: Fri, 16 Jan 2015 04:04:51 -0500
Message-ID: <20150116090451.GB31113@peff.net>
References: <20150116090225.GA30797@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 16 10:05:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YC2q1-0003fI-Co
	for gcvg-git-2@plane.gmane.org; Fri, 16 Jan 2015 10:05:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753035AbbAPJEz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2015 04:04:55 -0500
Received: from cloud.peff.net ([50.56.180.127]:35412 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752559AbbAPJEx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2015 04:04:53 -0500
Received: (qmail 2908 invoked by uid 102); 16 Jan 2015 09:04:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 16 Jan 2015 03:04:53 -0600
Received: (qmail 23444 invoked by uid 107); 16 Jan 2015 09:05:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 16 Jan 2015 04:05:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Jan 2015 04:04:51 -0500
Content-Disposition: inline
In-Reply-To: <20150116090225.GA30797@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262541>

From: Stefan Beller <sbeller@google.com>

The prior patch uses "/**" to denote "documentation"
comments that we pulled from api-strbuf.txt. Let's use a
consistent style for similar comments that were already in
strbuf.h.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jeff King <peff@peff.net>
---
This adds one spot that was missed in the original. I also rewrote the
commit message, as I found the original hard to parse.

 strbuf.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/strbuf.h b/strbuf.h
index b4050de..fd57e45 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -435,7 +435,7 @@ static inline int strbuf_strip_suffix(struct strbuf *sb, const char *suffix)
 		return 0;
 }
 
-/*
+/**
  * Split str (of length slen) at the specified terminator character.
  * Return a null-terminated array of pointers to strbuf objects
  * holding the substrings.  The substrings include the terminator,
@@ -451,7 +451,7 @@ static inline int strbuf_strip_suffix(struct strbuf *sb, const char *suffix)
 extern struct strbuf **strbuf_split_buf(const char *, size_t,
 					int terminator, int max);
 
-/*
+/**
  * Split a NUL-terminated string at the specified terminator
  * character.  See strbuf_split_buf() for more information.
  */
@@ -461,7 +461,7 @@ static inline struct strbuf **strbuf_split_str(const char *str,
 	return strbuf_split_buf(str, strlen(str), terminator, max);
 }
 
-/*
+/**
  * Split a strbuf at the specified terminator character.  See
  * strbuf_split_buf() for more information.
  */
@@ -471,7 +471,7 @@ static inline struct strbuf **strbuf_split_max(const struct strbuf *sb,
 	return strbuf_split_buf(sb->buf, sb->len, terminator, max);
 }
 
-/*
+/**
  * Split a strbuf at the specified terminator character.  See
  * strbuf_split_buf() for more information.
  */
@@ -481,7 +481,7 @@ static inline struct strbuf **strbuf_split(const struct strbuf *sb,
 	return strbuf_split_max(sb, terminator, 0);
 }
 
-/*
+/**
  * Free a NULL-terminated list of strbufs (for example, the return
  * values of the strbuf_split*() functions).
  */
@@ -498,7 +498,7 @@ extern int launch_editor(const char *path, struct strbuf *buffer, const char *co
 
 extern void strbuf_add_lines(struct strbuf *sb, const char *prefix, const char *buf, size_t size);
 
-/*
+/**
  * Append s to sb, with the characters '<', '>', '&' and '"' converted
  * into XML entities.
  */
@@ -523,7 +523,7 @@ extern int fprintf_ln(FILE *fp, const char *fmt, ...);
 
 char *xstrdup_tolower(const char *);
 
-/*
+/**
  * Create a newly allocated string using printf format. You can do this easily
  * with a strbuf, but this provides a shortcut to save a few lines.
  */
-- 
2.2.1.425.g441bb3c
