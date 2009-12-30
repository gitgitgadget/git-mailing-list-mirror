From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v6 0/4] "git reset --merge" related improvements
Date: Wed, 30 Dec 2009 06:54:43 +0100
Message-ID: <20091230055008.4475.95755.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Paolo Bonzini <bonzini@gnu.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 30 06:53:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPrUM-0005vC-F2
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 06:52:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752141AbZL3Fwp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2009 00:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752080AbZL3Fwp
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Dec 2009 00:52:45 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:55866 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751591AbZL3Fwo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2009 00:52:44 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id C908481805F;
	Wed, 30 Dec 2009 06:52:34 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id AB1B4818076;
	Wed, 30 Dec 2009 06:52:31 +0100 (CET)
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135857>

Another reroll with the following changes:
- patches to add --keep option have been removed for now
- documentation patch has been moved before the core code changes
- commit messages have been improved
- tests have been much improved thanks to Junio's suggestions

Christian Couder (3):
  reset: improve mixed reset error message when in a bare repo
  Documentation: reset: add some tables to describe the different
    options
  reset: add a few tests for "git reset --merge"

Stephan Beyer (1):
  reset: use "unpack_trees()" directly instead of "git read-tree"

 Documentation/git-reset.txt |   66 ++++++++++++++++++
 builtin-reset.c             |   45 +++++++++---
 t/t7110-reset-merge.sh      |  161 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 261 insertions(+), 11 deletions(-)
 create mode 100755 t/t7110-reset-merge.sh
