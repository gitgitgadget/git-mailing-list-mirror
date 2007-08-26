From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH 0/4] Miscellaneous fixes
Date: Sun, 26 Aug 2007 22:26:04 +0200
Message-ID: <20070826202309.15933.54183.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 26 22:26:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPOh6-00063l-4z
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 22:26:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753410AbXHZU0T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 26 Aug 2007 16:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752306AbXHZU0T
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 16:26:19 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3252 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752838AbXHZU0T (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 16:26:19 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IPOgT-0005sX-00; Sun, 26 Aug 2007 21:26:09 +0100
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56713>

This is a few miscellaneous fixes. Also available here:

  git://repo.or.cz/stgit/kha.git fixes

Karl Hasselstr=C3=B6m (4):
      Don't use test_expect_failure when more than one thing could fail
      Don't write None to the conf file
      Replace "git repo-config" with "git config" in help texts
      Compile regexp just once

 examples/gitconfig          |    2 +-
 stgit/git.py                |    3 ++-
 stgit/stack.py              |    7 ++++---
 t/t2101-pull-policy-pull.sh |    4 ++--
 4 files changed, 9 insertions(+), 7 deletions(-)

--=20
Karl Hasselstr=C3=B6m, kha@treskal.com
      www.treskal.com/kalle
