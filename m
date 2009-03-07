From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] document config --bool-or-int
Date: Sat,  7 Mar 2009 12:14:06 -0500
Message-ID: <1236446046-18319-4-git-send-email-peff@peff.net>
References: <1236446046-18319-1-git-send-email-peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 07 18:16:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lg08Z-0002kb-Cp
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 18:16:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755453AbZCGRPB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2009 12:15:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755410AbZCGRPB
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 12:15:01 -0500
Received: from peff.net ([208.65.91.99]:47639 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755282AbZCGRPA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 12:15:00 -0500
Received: (qmail 16015 invoked by uid 107); 7 Mar 2009 17:15:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 07 Mar 2009 12:15:01 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 07 Mar 2009 12:14:49 -0500
X-Mailer: git-send-email 1.6.2.195.g44251.dirty
In-Reply-To: <1236446046-18319-1-git-send-email-peff@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112553>

The documentation is just a pointer to the --bool and --int
options, but it makes sense to at least mention that it
exists.

Signed-off-by: Jeff King <peff@peff.net>
---
Maybe it is pointless to document this; it seems to have been added by
c35b0b5 purely as a way for t1300 to test the git_config_bool_or_int
feature.

In that case, 2/3 should probably be hiding it instead of describing it,
as well.

 Documentation/git-config.txt |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 7d14007..82ce89e 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -131,6 +131,10 @@ See also <<FILES>>.
 	in the config file will cause the value to be multiplied
 	by 1024, 1048576, or 1073741824 prior to output.
 
+--bool-or-int::
+	'git-config' will ensure that the output matches the format of
+	either --bool or --int, as described above.
+
 -z::
 --null::
 	For all options that output values and/or keys, always
-- 
1.6.2.195.g44251.dirty
