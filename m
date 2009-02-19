From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 7/8] builtin-show-ref: use warning() instead of
	fprintf(stderr, "warning: ")
Date: Thu, 19 Feb 2009 13:55:22 +0100
Message-ID: <3fb08b8fb972b27d2a75f6cf24de757dd7dcd7a6.1235047192.git.vmiklos@frugalware.org>
References: <200902190736.49161.johnflux@gmail.com> <20090219081725.GB7774@coredump.intra.peff.net> <20090219120708.GM4371@genesis.frugalware.org> <20090219122104.GA4602@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, John Tapsell <johnflux@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 13:56:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La8SS-0001mI-L4
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 13:56:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755335AbZBSMzZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 07:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755219AbZBSMzY
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 07:55:24 -0500
Received: from virgo.iok.hu ([212.40.97.103]:47473 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755182AbZBSMzX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 07:55:23 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 49A3B580D1;
	Thu, 19 Feb 2009 13:55:23 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 0D7BF446A6;
	Thu, 19 Feb 2009 13:55:22 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 4870611B877C; Thu, 19 Feb 2009 13:55:22 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <cover.1235047192.git.vmiklos@frugalware.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110692>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 builtin-show-ref.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-show-ref.c b/builtin-show-ref.c
index 572b114..dc76c50 100644
--- a/builtin-show-ref.c
+++ b/builtin-show-ref.c
@@ -140,7 +140,7 @@ static int exclude_existing(const char *match)
 				continue;
 		}
 		if (check_ref_format(ref)) {
-			fprintf(stderr, "warning: ref '%s' ignored\n", ref);
+			warning("ref '%s' ignored", ref);
 			continue;
 		}
 		if (!string_list_has_string(&existing_refs, ref)) {
-- 
1.6.1
