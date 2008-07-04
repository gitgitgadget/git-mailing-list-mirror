From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 0/2] stg refresh -e/--edit
Date: Fri, 04 Jul 2008 08:40:24 +0200
Message-ID: <20080704063755.9637.23750.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 04 08:42:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEeza-0001RJ-LX
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 08:42:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752816AbYGDGlE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Jul 2008 02:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752293AbYGDGlD
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jul 2008 02:41:03 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2095 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751998AbYGDGlB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2008 02:41:01 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1KEexz-0000OI-00; Fri, 04 Jul 2008 07:40:23 +0100
User-Agent: StGIT/0.14.3.185.gb9e85
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87365>

Jakub, this one's for you. ;-)

These live in my experimental branch for a little while yet, but the
plan is to include them in v0.15 -- and release that reasonably soon.

---

Karl Hasselstr=C3=B6m (2):
      Implement "stg refresh --edit" again
      Refactor stgit.commands.edit


 stgit/commands/coalesce.py |    2 -
 stgit/commands/common.py   |    9 +++-
 stgit/commands/edit.py     |   82 ++++++------------------------------
 stgit/commands/imprt.py    |    2 -
 stgit/commands/new.py      |    3 +
 stgit/commands/refresh.py  |   44 +++++++++++++++-----
 stgit/lib/edit.py          |   99 ++++++++++++++++++++++++++++++++++++=
++++++++
 stgit/utils.py             |   18 +++++---
 8 files changed, 167 insertions(+), 92 deletions(-)
 create mode 100644 stgit/lib/edit.py

--=20
Karl Hasselstr=C3=B6m, kha@treskal.com
      www.treskal.com/kalle
