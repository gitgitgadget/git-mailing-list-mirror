From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 2/8] builtin-checkout: use warning() instead of
	fprintf(stderr, "warning: ")
Date: Thu, 19 Feb 2009 13:53:28 +0100
Message-ID: <85cc0cd257f02379985aca3cb20263a8f3c61486.1235047192.git.vmiklos@frugalware.org>
References: <200902190736.49161.johnflux@gmail.com> <20090219081725.GB7774@coredump.intra.peff.net> <20090219120708.GM4371@genesis.frugalware.org> <20090219122104.GA4602@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, John Tapsell <johnflux@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 13:55:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La8Qd-00012t-5Y
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 13:54:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755081AbZBSMxa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 07:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755041AbZBSMxa
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 07:53:30 -0500
Received: from virgo.iok.hu ([212.40.97.103]:47446 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754480AbZBSMx3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 07:53:29 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id D3E73580D1;
	Thu, 19 Feb 2009 13:53:29 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 976E3446A6;
	Thu, 19 Feb 2009 13:53:28 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id D7B4111B877C; Thu, 19 Feb 2009 13:53:28 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <cover.1235047192.git.vmiklos@frugalware.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110687>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 builtin-checkout.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index 20b34ce..0ddd34b 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -556,8 +556,8 @@ static int switch_branches(struct checkout_opts *opts, struct branch_info *new)
 
 	if (!old.commit && !opts->force) {
 		if (!opts->quiet) {
-			fprintf(stderr, "warning: You appear to be on a branch yet to be born.\n");
-			fprintf(stderr, "warning: Forcing checkout of %s.\n", new->name);
+			warning("You appear to be on a branch yet to be born.");
+			warning("Forcing checkout of %s.", new->name);
 		}
 		opts->force = 1;
 	}
-- 
1.6.1
