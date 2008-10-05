From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 0/6] Documentation updates
Date: Sun, 05 Oct 2008 18:01:28 +0200
Message-ID: <20081005155450.19886.43748.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 05 18:02:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmW4F-00063u-Dx
	for gcvg-git-2@gmane.org; Sun, 05 Oct 2008 18:02:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754315AbYJEQBg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Oct 2008 12:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754258AbYJEQBg
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Oct 2008 12:01:36 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1867 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753897AbYJEQBf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Oct 2008 12:01:35 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1KmW2y-0007X5-00; Sun, 05 Oct 2008 17:01:28 +0100
User-Agent: StGIT/0.14.3.236.g0c611
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97513>

We're approaching a new StGit release (yay!), and the docs are rather
outdated. This is an attempt to refresh the main stg man page and the
tutorial (but I ran out of time for this weekend, so the second half
of the tutorial is incomplete).

Comments & helping hands much appreciated.

Since I touch almost every line, the patches are kind of a nuisance to
read. It's probably easiest to just fetch the branch:

  git://repo.or.cz/stgit/kha.git doc

---

Karl Hasselstr=C3=B6m (6):
      Refresh and expand the tutorial (not finished)
      Refresh the main stg man page
      Add 1.0 TODO items from recent discussion by private mail
      We're half-way there with the separate indexes
      Remove TODO items that have already been addressed
      Remove unused variable


 Documentation/Makefile      |   11 -
 Documentation/asciidoc.conf |   22 +
 Documentation/stg.txt       |  150 +++++---
 Documentation/tutorial.txt  |  794 ++++++++++++++++++++++++++---------=
--------
 TODO                        |   26 +
 stgit/argparse.py           |    2=20
 6 files changed, 603 insertions(+), 402 deletions(-)

--=20
Karl Hasselstr=C3=B6m, kha@treskal.com
      www.treskal.com/kalle
