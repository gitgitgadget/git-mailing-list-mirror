From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 0/4] "git reset --merge" related improvements
Date: Thu, 17 Sep 2009 06:14:35 +0200
Message-ID: <20090917040835.4048.51057.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 06:15:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mo8Oh-0001qq-IS
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 06:15:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752067AbZIQEOz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2009 00:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751721AbZIQEOy
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Sep 2009 00:14:54 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:41020 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751177AbZIQEOy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2009 00:14:54 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 6F881818057;
	Thu, 17 Sep 2009 06:14:48 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 68CAF818094;
	Thu, 17 Sep 2009 06:14:46 +0200 (CEST)
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128706>

In this new version, some test cases have been added to show that the
behavior of "git reset --merge" when there is a pending merge is changed
by patch 2/4.

And some commit messages have been improved, thanks to Junio.

There is no documentation yet but I am working on it. 

Christian Couder (2):
  reset: add a few tests for "git reset --merge"
  reset: add test cases for "--merge-safe" option

Stephan Beyer (2):
  reset: use "unpack_trees()" directly instead of "git read-tree"
  reset: add option "--merge-safe" to "git reset"

 builtin-reset.c        |   81 ++++++++++++++++++++++------
 t/t7110-reset-merge.sh |  142 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 207 insertions(+), 16 deletions(-)
 create mode 100755 t/t7110-reset-merge.sh
