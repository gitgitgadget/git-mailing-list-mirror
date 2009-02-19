From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 3/8] builtin-fetch-pack: use warning() instead of
	fprintf(stderr, "warning: ")
Date: Thu, 19 Feb 2009 13:53:47 +0100
Message-ID: <842406ced89cabde4bd59150834ce08d88afb461.1235047192.git.vmiklos@frugalware.org>
References: <200902190736.49161.johnflux@gmail.com> <20090219081725.GB7774@coredump.intra.peff.net> <20090219120708.GM4371@genesis.frugalware.org> <20090219122104.GA4602@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, John Tapsell <johnflux@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 13:55:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La8Qv-00019R-OH
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 13:55:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755096AbZBSMxt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 07:53:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755021AbZBSMxt
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 07:53:49 -0500
Received: from virgo.iok.hu ([212.40.97.103]:47452 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754937AbZBSMxs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 07:53:48 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 1C391580D1;
	Thu, 19 Feb 2009 13:53:48 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id D423F446A6;
	Thu, 19 Feb 2009 13:53:46 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 1F18511B877C; Thu, 19 Feb 2009 13:53:47 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <cover.1235047192.git.vmiklos@frugalware.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110688>

---
 builtin-fetch-pack.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index 67fb80e..85de2ba 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -606,7 +606,7 @@ static struct ref *do_fetch_pack(int fd[2],
 			/* When cloning, it is not unusual to have
 			 * no common commit.
 			 */
-			fprintf(stderr, "warning: no common commits\n");
+			warning("no common commits");
 
 	if (get_pack(fd, pack_lockfile))
 		die("git fetch-pack: fetch failed.");
-- 
1.6.1
