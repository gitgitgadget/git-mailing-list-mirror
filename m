From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 0/5] More experimental patches
Date: Fri, 14 Dec 2007 07:32:07 +0100
Message-ID: <20071214062618.29290.70792.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 07:32:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J346D-0003fp-IB
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 07:32:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756484AbXLNGcN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Dec 2007 01:32:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753515AbXLNGcM
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 01:32:12 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4219 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752191AbXLNGcL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 01:32:11 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1J345e-0002ob-00; Fri, 14 Dec 2007 06:32:06 +0000
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68241>

Also available from

  git://repo.or.cz/stgit/kha.git experimental

However, the experimentalness is getting decidedly low. And now that
we just had a release, I have just one more thing I intend to take a
look at -- subdirectory safeness -- before I'm going to transfer all
the "experimental" patches to "safe", wholesale.

So if anyone knows of problems that would make this a bad idea, please
say so.

---

Karl Hasselstr=C3=B6m (5):
      Make "stg commit" fancier
      Convert "stg commit" to new infrastructure
      Set exit code to 3 on merge conflict
      stg coalesce: Support --file and --save-template
      Expose transaction abort function


 stgit/commands/coalesce.py |   32 ++++++++-----
 stgit/commands/commit.py   |  111 ++++++++++++++++++++++++++++--------=
--------
 stgit/commands/goto.py     |    2 -
 stgit/commands/uncommit.py |    2 -
 stgit/lib/transaction.py   |   24 ++++++++--
 stgit/main.py              |    4 +-
 stgit/utils.py             |    1=20
 t/t1300-uncommit.sh        |   12 ++---
 8 files changed, 121 insertions(+), 67 deletions(-)

--=20
Karl Hasselstr=C3=B6m, kha@treskal.com
      www.treskal.com/kalle
