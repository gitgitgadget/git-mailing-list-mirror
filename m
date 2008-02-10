From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 0/5] Convert "stg new" to the new infrastructure
Date: Sun, 10 Feb 2008 21:40:56 +0100
Message-ID: <20080210203846.17683.43153.stgit@yoghurt>
References: <20080210203640.GA19688@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 21:41:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOIza-0004HX-If
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 21:41:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754134AbYBJUlF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Feb 2008 15:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753522AbYBJUlE
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 15:41:04 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4219 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753436AbYBJUlD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 15:41:03 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1JOIyu-0005C8-00; Sun, 10 Feb 2008 20:40:56 +0000
In-Reply-To: <20080210203640.GA19688@diana.vm.bytemark.co.uk>
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73404>

---

Karl Hasselstr=C3=B6m (5):
      Emacs mode: use "stg new --file"
      Let "stg new" support more message options
      Refactor --author/--committer options
      Convert "stg new" to the new infrastructure
      Disable patchlog test for "stg new"


 contrib/stgit.el         |   10 +----
 stgit/commands/common.py |   33 +++++-----------
 stgit/commands/edit.py   |   25 +-----------
 stgit/commands/new.py    |   97 ++++++++++++++++++++++++++------------=
--------
 stgit/lib/git.py         |    8 ++--
 stgit/utils.py           |   50 ++++++++++++++++++++++++
 t/t1400-patch-history.sh |    2 -
 7 files changed, 124 insertions(+), 101 deletions(-)

--=20
Karl Hasselstr=C3=B6m, kha@treskal.com
      www.treskal.com/kalle
