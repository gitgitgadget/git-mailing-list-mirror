From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2 2/3] builtin/checkout: reword hint for -b
Date: Thu, 24 Jun 2010 03:28:59 +0800
Message-ID: <1277321340-4000-3-git-send-email-rctay89@gmail.com>
References: <1277140782-4064-1-git-send-email-rctay89@gmail.com>
 <1277321340-4000-1-git-send-email-rctay89@gmail.com>
 <1277321340-4000-2-git-send-email-rctay89@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Clemens Buchacher <drizzd@aon.at>,
	Michel Lespinasse <walken@google.com>,
	Erick Mattos <erick.mattos@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 23 21:29:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORVdY-0001e5-4b
	for gcvg-git-2@lo.gmane.org; Wed, 23 Jun 2010 21:29:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753517Ab0FWT3X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jun 2010 15:29:23 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:61250 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753495Ab0FWT3W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jun 2010 15:29:22 -0400
Received: by pxi7 with SMTP id 7so408429pxi.19
        for <git@vger.kernel.org>; Wed, 23 Jun 2010 12:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=vMR7pRObBOjfB9BseSqGAfP2vIHeSh6fzWEhYAYpdi4=;
        b=V4/AbwsvYlO6l2sLnMmLLLS8GeZTBlXZIWiNtW3yYlkS0tsGuB2ycxN8WKaAAFYtLY
         KLGxo+3hZiM0h3TPb1QTg4pmi+1Aktq15tdGTv/TGFgLbLSCWlcbJ9BJff1cqizn0FjE
         KzEoVIC3Y+t2I8S4rYjrTE+tAjvjimjHRy45c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=mc7VIEnxmu6kFbPQJ1XcmdxIb0rvvRB/G7I+EQf7BRydd3WiRIxOVkwWFnjnM2sQxu
         9etQc5EI//VK+LhyfKzWjehv7laeyx2aTYJgGO5jXJUI4+rOv9I2e6JF8/of2HbaDRsN
         PQHtC6OdklWx9QmLA64miNVzUWhb+7fejiQow=
Received: by 10.142.152.37 with SMTP id z37mr7816958wfd.84.1277321360754;
        Wed, 23 Jun 2010 12:29:20 -0700 (PDT)
Received: from localhost.localdomain (cm156.zeta152.maxonline.com.sg [116.87.152.156])
        by mx.google.com with ESMTPS id p1sm570577rvq.0.2010.06.23.12.29.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 23 Jun 2010 12:29:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.513.g06a69
In-Reply-To: <1277321340-4000-2-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149537>

Shift the 'new' from the param to the hint, and expand the hint.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 builtin/checkout.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 1994be9..3969683 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -657,7 +657,8 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	int dwim_new_local_branch = 1;
 	struct option options[] = {
 		OPT__QUIET(&opts.quiet),
-		OPT_STRING('b', NULL, &opts.new_branch, "new branch", "branch"),
+		OPT_STRING('b', NULL, &opts.new_branch, "branch",
+		           "create and checkout a new branch"),
 		OPT_BOOLEAN('l', NULL, &opts.new_branch_log, "log for new branch"),
 		OPT_SET_INT('t', "track",  &opts.track, "track",
 			BRANCH_TRACK_EXPLICIT),
--
1.7.1.513.g4f18
