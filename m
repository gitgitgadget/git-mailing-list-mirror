From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] clone: detect extra arguments
Date: Fri, 30 Oct 2009 10:51:09 -0400
Message-ID: <20091030145108.GA881@coredump.intra.peff.net>
References: <20091029081030.GA11213@progeny.tock>
 <20091029160614.GB7622@sigill.intra.peff.net>
 <20091030111919.GA13242@progeny.tock>
 <20091030144525.GA22583@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johan Herland <johan@herland.net>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 15:52:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3sp1-0006DL-09
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 15:51:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbZJ3OvN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 10:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbZJ3OvM
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 10:51:12 -0400
Received: from peff.net ([208.65.91.99]:48155 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932259AbZJ3OvM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 10:51:12 -0400
Received: (qmail 361 invoked by uid 107); 30 Oct 2009 14:54:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 30 Oct 2009 10:54:57 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Oct 2009 10:51:09 -0400
Content-Disposition: inline
In-Reply-To: <20091030144525.GA22583@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131706>

On Fri, Oct 30, 2009 at 10:45:25AM -0400, Jeff King wrote:

> But looking at the usage message, there is some potential for cleanup.

Also, we should probably do this (I did it as a patch on master, though,
as it is an independent fix):

-- >8 --
Subject: [PATCH] clone: fix --recursive usage message

Looks like a mistaken cut-and-paste in e7fed18a.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin-clone.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index 5762a6f..436e8da 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -61,7 +61,7 @@ static struct option builtin_clone_options[] = {
 	OPT_BOOLEAN('s', "shared", &option_shared,
 		    "setup as shared repository"),
 	OPT_BOOLEAN(0, "recursive", &option_recursive,
-		    "setup as shared repository"),
+		    "initialize submodules in the clone"),
 	OPT_STRING(0, "template", &option_template, "path",
 		   "path the template repository"),
 	OPT_STRING(0, "reference", &option_reference, "repo",
-- 
1.6.5.1.143.g1dab74.dirty
