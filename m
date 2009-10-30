From: Jeff King <peff@peff.net>
Subject: [PATCH] push: fix typo in usage
Date: Fri, 30 Oct 2009 11:04:53 -0400
Message-ID: <20091030150453.GA1954@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 16:05:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3t2J-0005Wa-VR
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 16:05:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbZJ3PE5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 11:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbZJ3PE5
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 11:04:57 -0400
Received: from peff.net ([208.65.91.99]:51775 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932246AbZJ3PE4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 11:04:56 -0400
Received: (qmail 505 invoked by uid 107); 30 Oct 2009 15:08:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 30 Oct 2009 11:08:41 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Oct 2009 11:04:53 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131708>

Missing ")".

Signed-off-by: Jeff King <peff@peff.net>
---
I posted this in $gmane/130293, but I think it simply got missed.

 builtin-push.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-push.c b/builtin-push.c
index 7d78711..019c986 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -181,7 +181,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT_BIT( 0 , "all", &flags, "push all refs", TRANSPORT_PUSH_ALL),
 		OPT_BIT( 0 , "mirror", &flags, "mirror all refs",
 			    (TRANSPORT_PUSH_MIRROR|TRANSPORT_PUSH_FORCE)),
-		OPT_BOOLEAN( 0 , "tags", &tags, "push tags (can't be used with --all or --mirror"),
+		OPT_BOOLEAN( 0 , "tags", &tags, "push tags (can't be used with --all or --mirror)"),
 		OPT_BIT( 0 , "purge", &flags,
 			"remove locally deleted refs from remote",
 			TRANSPORT_PUSH_PURGE),
-- 
1.6.5.1.143.g1dab74.dirty
