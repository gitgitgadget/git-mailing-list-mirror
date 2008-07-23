From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH 0/9] Extend use of parse_options()
Date: Wed, 23 Jul 2008 23:42:03 +0200
Message-ID: <1216849332-26813-1-git-send-email-barra_cuda@katamail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 23:37:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLm1X-00026o-S5
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 23:37:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755850AbYGWVfr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 17:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755837AbYGWVfr
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 17:35:47 -0400
Received: from smtp.katamail.com ([62.149.157.154]:36960 "HELO
	smtp1.pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1754555AbYGWVfq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 17:35:46 -0400
Received: (qmail 11428 invoked by uid 89); 23 Jul 2008 21:35:35 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp2-pc
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_50,HELO_LH_LD,RDNS_NONE
	autolearn=no version=3.2.3
Received: from unknown (HELO localhost.localdomain) (barra?cuda@katamail.com@80.104.56.10)
  by smtp2-pc with SMTP; 23 Jul 2008 21:35:35 -0000
X-Mailer: git-send-email 1.5.6.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89776>

These patches spread the use of parse_options() to some more commands.
I tried to come up with a short description for every option, but
I'm not sure I fully succeeded. In particular, the option "sparse"
in builtin-rev-list.c has no description.

Michele Ballabio (9):
  builtin-verify-tag.c: use parse_options()
  builtin-write-tree.c: use parse_options()
  builtin-prune-packed.c: use parse_options()
  builtin-ls-tree.c: use parse_options()
  builtin-rev-list.c: use parse_options()
  builtin-init-db.c: use parse_options()
  builtin-checkout-index.c: use parse_options()
  builtin-fetch-pack.c: use parse_options()
  builtin-mailinfo.c: use parse_options()

 builtin-checkout-index.c |  146 +++++++++++++++++++++++++---------------------
 builtin-fetch-pack.c     |  144 ++++++++++++++++++++++++++++-----------------
 builtin-init-db.c        |   56 +++++++++++-------
 builtin-ls-tree.c        |   92 +++++++++++------------------
 builtin-mailinfo.c       |   39 +++++++------
 builtin-prune-packed.c   |   38 ++++++------
 builtin-rev-list.c       |  132 ++++++++++++++++++++---------------------
 builtin-verify-tag.c     |   25 +++++---
 builtin-write-tree.c     |   31 +++++-----
 9 files changed, 376 insertions(+), 327 deletions(-)
