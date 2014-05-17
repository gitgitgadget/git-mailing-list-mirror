From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 00/10] replace: add option to edit a Git object
Date: Sat, 17 May 2014 14:16:29 +0200
Message-ID: <20140517120649.27582.58609.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 17 17:58:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wlh09-0002cP-2Z
	for gcvg-git-2@plane.gmane.org; Sat, 17 May 2014 17:58:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757439AbaEQP5k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2014 11:57:40 -0400
Received: from mail-1y.bbox.fr ([194.158.98.14]:54503 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757375AbaEQP5i (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2014 11:57:38 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 26DA25C;
	Sat, 17 May 2014 17:57:35 +0200 (CEST)
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249481>

This patch series comes from what Peff sent in the following thread:

http://thread.gmane.org/gmane.comp.version-control.git/243361/focus=243528

The only changes compared to v2 are in the test (8/10) and documentation
patches (10/10). Thanks to Peff.

Christian Couder (6):
  replace: make sure --edit results in a different object
  replace: refactor checking ref validity
  replace: die early if replace ref already exists
  replace: add tests for --edit
  replace: add --edit to usage string
  Documentation: replace: describe new --edit option

Jeff King (4):
  replace: refactor command-mode determination
  replace: use OPT_CMDMODE to handle modes
  replace: factor object resolution out of replace_object
  replace: add --edit option

 Documentation/git-replace.txt |  16 ++-
 builtin/replace.c             | 225 +++++++++++++++++++++++++++++++++---------
 t/t6050-replace.sh            |  27 +++++
 3 files changed, 222 insertions(+), 46 deletions(-)

-- 
1.9.rc0.17.g651113e
