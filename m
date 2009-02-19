From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 6/8] builtin-show-branch: use warning() instead of
	fprintf(stderr, "warning: ")
Date: Thu, 19 Feb 2009 13:54:48 +0100
Message-ID: <8095a2134bdbd7edbdeee730ae06d785401c9540.1235047192.git.vmiklos@frugalware.org>
References: <200902190736.49161.johnflux@gmail.com> <20090219081725.GB7774@coredump.intra.peff.net> <20090219120708.GM4371@genesis.frugalware.org> <20090219122104.GA4602@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, John Tapsell <johnflux@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 13:56:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La8Rv-0001ak-NM
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 13:56:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755178AbZBSMyv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 07:54:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754742AbZBSMyv
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 07:54:51 -0500
Received: from virgo.iok.hu ([212.40.97.103]:47464 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753930AbZBSMyu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 07:54:50 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 88C77580D1;
	Thu, 19 Feb 2009 13:54:50 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 47311446A6;
	Thu, 19 Feb 2009 13:54:49 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 1496311B877C; Thu, 19 Feb 2009 13:54:48 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <cover.1235047192.git.vmiklos@frugalware.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110691>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 builtin-show-branch.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index 306b850..828e6f8 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -365,8 +365,7 @@ static int append_ref(const char *refname, const unsigned char *sha1,
 				return 0;
 	}
 	if (MAX_REVS <= ref_name_cnt) {
-		fprintf(stderr, "warning: ignoring %s; "
-			"cannot handle more than %d refs\n",
+		warning("ignoring %s; cannot handle more than %d refs",
 			refname, MAX_REVS);
 		return 0;
 	}
-- 
1.6.1
