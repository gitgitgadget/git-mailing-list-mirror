From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [PATCH v3 0/4] Teach git diff-tree --stdin to diff trees
Date: Sun, 10 Aug 2008 18:12:39 +0200
Message-ID: <20080810161035.7116.2171.stgit@yoghurt>
References: <20080810153848.GA28032@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 10 18:19:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSDdp-0006QM-0g
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 18:19:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752736AbYHJQSf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Aug 2008 12:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752730AbYHJQSf
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 12:18:35 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1369 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752634AbYHJQSe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 12:18:34 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1KSDsf-0008KE-00; Sun, 10 Aug 2008 17:34:57 +0100
In-Reply-To: <20080810153848.GA28032@diana.vm.bytemark.co.uk>
User-Agent: StGIT/0.14.3.223.g12ca.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91854>

Updated after Junio's comments. (Patch 1/4 and 4/4 have not changed
but I'm resending them anyway for convenience.)

---

Karl Hasselstr=C3=B6m (4):
      Add test for diff-tree --stdin with two trees
      Teach git diff-tree --stdin to diff trees
      diff-tree: Note that the commit ID is printed with --stdin
      Refactoring: Split up diff_tree_stdin


 Documentation/git-diff-tree.txt |   19 ++++++++++---
 builtin-diff-tree.c             |   56 +++++++++++++++++++++++++++++++=
--------
 t/t4002-diff-basic.sh           |   14 ++++++++++
 3 files changed, 72 insertions(+), 17 deletions(-)

--=20
Karl Hasselstr=C3=B6m, kha@treskal.com
      www.treskal.com/kalle
