From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [PATCH 0/3] Teach git diff-tree --stdin to diff trees
Date: Fri, 08 Aug 2008 22:48:05 +0200
Message-ID: <20080808204348.7744.46006.stgit@yoghurt>
References: <7vbq06rwhq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 08 22:49:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRYu6-00058H-Tp
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 22:49:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753076AbYHHUsk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Aug 2008 16:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753053AbYHHUsj
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 16:48:39 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4159 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752941AbYHHUsi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 16:48:38 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1KRZEG-0000vH-00; Fri, 08 Aug 2008 22:10:32 +0100
In-Reply-To: <7vbq06rwhq.fsf@gitster.siamese.dyndns.org>
User-Agent: StGIT/0.14.3.222.g9ef2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91712>

Here's two patches that implements diffing of trees: first a
refactoring, then the actual functionality.

I'm not familiar with git's API, so I might have made mistakes in
choosing or using functions. Extra eyeballs appreciated. But the test
suite passes, it does what I want, and it does make StGit faster, so
_I'm_ happy ...

---

Karl Hasselstr=C3=B6m (3):
      Add test for diff-tree --stdin with two trees
      Teach git diff-tree --stdin to diff trees
      Refactoring: Split up diff_tree_stdin


 Documentation/git-diff-tree.txt |   14 ++++++---
 builtin-diff-tree.c             |   58 +++++++++++++++++++++++++++++++=
--------
 t/t4002-diff-basic.sh           |   14 +++++++++
 3 files changed, 69 insertions(+), 17 deletions(-)

--=20
Karl Hasselstr=C3=B6m, kha@treskal.com
      www.treskal.com/kalle
