From: Jeff King <peff@peff.net>
Subject: [PATCH v4 23/23] compat/mingw.h: Fix the MinGW and msvc builds
Date: Sat, 21 Dec 2013 09:00:52 -0500
Message-ID: <20131221140052.GW21145@sigill.intra.peff.net>
References: <20131221135651.GA20818@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 21 15:01:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VuN6x-0005yy-Ek
	for gcvg-git-2@plane.gmane.org; Sat, 21 Dec 2013 15:00:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755718Ab3LUOAz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Dec 2013 09:00:55 -0500
Received: from cloud.peff.net ([50.56.180.127]:48507 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754065Ab3LUOAy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Dec 2013 09:00:54 -0500
Received: (qmail 7599 invoked by uid 102); 21 Dec 2013 14:00:53 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 21 Dec 2013 08:00:53 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 21 Dec 2013 09:00:52 -0500
Content-Disposition: inline
In-Reply-To: <20131221135651.GA20818@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239611>

From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 compat/mingw.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/compat/mingw.h b/compat/mingw.h
index 92cd728..8828ede 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -345,6 +345,7 @@ static inline char *mingw_find_last_dir_sep(const char *path)
 #define PATH_SEP ';'
 #define PRIuMAX "I64u"
 #define PRId64 "I64d"
+#define PRIx64 "I64x"
 
 void mingw_open_html(const char *path);
 #define open_html mingw_open_html
-- 
1.8.5.1.399.g900e7cd
