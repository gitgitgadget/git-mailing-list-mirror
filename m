From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 0/5] Performance testing tools
Date: Thu, 17 Jul 2008 22:42:20 +0200
Message-ID: <20080717204133.23407.34264.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 17 22:43:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJaK4-0007wP-Uj
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 22:43:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbYGQUmb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Jul 2008 16:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760212AbYGQUma
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 16:42:30 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1852 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760110AbYGQUma (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 16:42:30 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1KJaIw-0008GY-00; Thu, 17 Jul 2008 21:42:22 +0100
User-Agent: StGIT/0.14.3.197.gba718
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88915>

Here's the same scripts I posted earlier, but polished and extended.

---

Karl Hasselstr=C3=B6m (5):
      Global performance logging
      Log subprocess calls during performance testing
      Show full command in subprocess profiling
      Log subproces activity to a file
      Add some performance testing scripts


 perf/.gitignore               |    2 +
 perf/create_synthetic_repo.py |   61 ++++++++++++++++++++++++++
 perf/find_patchbomb.py        |   31 +++++++++++++
 perf/perftest.py              |   96 +++++++++++++++++++++++++++++++++=
++++++++
 perf/setup.sh                 |   52 ++++++++++++++++++++++
 stgit/main.py                 |   11 ++++-
 stgit/out.py                  |   11 +++--
 stgit/run.py                  |   61 +++++++++++++++++++++-----
 8 files changed, 306 insertions(+), 19 deletions(-)
 create mode 100644 perf/.gitignore
 create mode 100644 perf/create_synthetic_repo.py
 create mode 100644 perf/find_patchbomb.py
 create mode 100644 perf/perftest.py
 create mode 100644 perf/setup.sh

--=20
Karl Hasselstr=C3=B6m, kha@treskal.com
      www.treskal.com/kalle
