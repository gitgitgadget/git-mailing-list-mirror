From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 0/2] Convert "stg delete" to the new infrastructure
Date: Sun, 10 Feb 2008 21:47:01 +0100
Message-ID: <20080210204628.17886.27365.stgit@yoghurt>
References: <20080210203640.GA19688@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 21:47:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOJ5Z-0006B4-Tz
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 21:47:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754845AbYBJUrP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Feb 2008 15:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754638AbYBJUrP
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 15:47:15 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2848 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754841AbYBJUrO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 15:47:14 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1JOJ4m-0005E8-00; Sun, 10 Feb 2008 20:47:00 +0000
In-Reply-To: <20080210203640.GA19688@diana.vm.bytemark.co.uk>
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73410>

---

Karl Hasselstr=C3=B6m (2):
      Emacs mode: delete patches
      Convert "stg delete" to the new infrastructure


 contrib/stgit.el         |   10 ++++++
 stgit/commands/delete.py |   72 +++++++++++++++-----------------------=
--------
 t/t1600-delete-one.sh    |    8 +++--
 3 files changed, 36 insertions(+), 54 deletions(-)

--=20
Karl Hasselstr=C3=B6m, kha@treskal.com
      www.treskal.com/kalle
