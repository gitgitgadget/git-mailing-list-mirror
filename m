From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 00/10] replace: add option to edit a Git object
Date: Sat, 17 May 2014 08:41:22 +0200
Message-ID: <20140517062418.18932.21200.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 17 08:43:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlYLQ-0006FL-8o
	for gcvg-git-2@plane.gmane.org; Sat, 17 May 2014 08:43:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756800AbaEQGnd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2014 02:43:33 -0400
Received: from [194.158.98.14] ([194.158.98.14]:58437 "EHLO mail-1y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755848AbaEQGnc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2014 02:43:32 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 525D342;
	Sat, 17 May 2014 08:43:10 +0200 (CEST)
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249441>

This patch series comes from what Peff sent in the following thread:

http://thread.gmane.org/gmane.comp.version-control.git/243361/focus=243528

The first 4 patches (1/4, 2/4, 3/4 and 4/4) didn't change since v1.
I added 6 more small patches to add tests, documentation and a few
small improvements. 

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

 Documentation/git-replace.txt |  15 ++-
 builtin/replace.c             | 225 +++++++++++++++++++++++++++++++++---------
 t/t6050-replace.sh            |  29 ++++++
 3 files changed, 223 insertions(+), 46 deletions(-)

-- 
1.9.rc0.17.g651113e
