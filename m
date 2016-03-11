From: Jeff King <peff@peff.net>
Subject: [PATCH v2 10/10] verify_repository_format: mark messages for
 translation
Date: Fri, 11 Mar 2016 17:37:22 -0500
Message-ID: <20160311223722.GJ449@sigill.intra.peff.net>
References: <20160311223620.GA7963@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Turner <dturner@twopensource.com>, pclouds@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 11 23:37:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeVgb-0004Au-7U
	for gcvg-git-2@plane.gmane.org; Fri, 11 Mar 2016 23:37:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932847AbcCKWh2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2016 17:37:28 -0500
Received: from cloud.peff.net ([50.56.180.127]:58684 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932454AbcCKWhZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2016 17:37:25 -0500
Received: (qmail 21029 invoked by uid 102); 11 Mar 2016 22:37:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 11 Mar 2016 17:37:24 -0500
Received: (qmail 7581 invoked by uid 107); 11 Mar 2016 22:37:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 11 Mar 2016 17:37:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Mar 2016 17:37:22 -0500
Content-Disposition: inline
In-Reply-To: <20160311223620.GA7963@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288717>

These messages are human-readable and should be translated.

Signed-off-by: Jeff King <peff@peff.net>
---
 setup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/setup.c b/setup.c
index 1314c17..09d3720 100644
--- a/setup.c
+++ b/setup.c
@@ -462,7 +462,7 @@ int verify_repository_format(const struct repository_format *format,
 			     struct strbuf *err)
 {
 	if (GIT_REPO_VERSION_READ < format->version) {
-		strbuf_addf(err, "Expected git repo version <= %d, found %d",
+		strbuf_addf(err, _("Expected git repo version <= %d, found %d"),
 			    GIT_REPO_VERSION_READ, format->version);
 		return -1;
 	}
@@ -470,7 +470,7 @@ int verify_repository_format(const struct repository_format *format,
 	if (format->version >= 1 && format->unknown_extensions.nr) {
 		int i;
 
-		strbuf_addstr(err, "unknown repository extensions found:");
+		strbuf_addstr(err, _("unknown repository extensions found:"));
 
 		for (i = 0; i < format->unknown_extensions.nr; i++)
 			strbuf_addf(err, "\n\t%s",
-- 
2.8.0.rc2.328.g39e2a47
