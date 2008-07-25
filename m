From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 0/3] Fix uncommit with top != head
Date: Fri, 25 Jul 2008 02:52:49 +0200
Message-ID: <20080725005154.13006.8908.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Erik Sandberg <mandolaerik@gmail.com>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 02:53:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMBZE-0006Fe-0v
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 02:53:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753434AbYGYAw4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jul 2008 20:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753368AbYGYAw4
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 20:52:56 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3149 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753355AbYGYAwz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 20:52:55 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1KMBtg-0005Vh-00; Fri, 25 Jul 2008 02:15:04 +0100
User-Agent: StGIT/0.14.3.197.gba718
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89987>

See http://gna.org/bugs/?12043

---

Karl Hasselstr=C3=B6m (3):
      Make sure that stg uncommit doesn't touch the branch head
      stg uncommit should never touch the branch head
      Test for exit code with command_error()


 stgit/commands/uncommit.py |    2 +-
 stgit/lib/transaction.py   |   19 ++++++++++---------
 t/t1300-uncommit.sh        |   13 ++++++++++++-
 t/t1303-commit.sh          |   20 ++++++++++++++++++++
 4 files changed, 43 insertions(+), 11 deletions(-)
 create mode 100755 t/t1303-commit.sh

--=20
Karl Hasselstr=C3=B6m, kha@treskal.com
      www.treskal.com/kalle
