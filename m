From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 0/2] Fix bug 12204
Date: Thu, 28 Aug 2008 00:06:40 +0200
Message-ID: <20080827220606.3607.17134.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Erik Sandberg <mandolaerik@gmail.com>, git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 00:08:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYTBq-00074M-Rk
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 00:08:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753453AbYH0WGw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Aug 2008 18:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753430AbYH0WGw
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 18:06:52 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1276 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753439AbYH0WGv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 18:06:51 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1KYTVc-0007lX-00; Wed, 27 Aug 2008 23:29:00 +0100
User-Agent: StGIT/0.14.3.232.g9dfa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93965>

This is a test and a fix for https://gna.org/bugs/?12204

---

Karl Hasselstr=C3=B6m (2):
      Check for top =3D=3D head at the start of every transaction
      Test that stg coalesce handles head !=3D top gracefully


 stgit/commands/redo.py     |    3 ++-
 stgit/commands/reset.py    |    3 ++-
 stgit/commands/uncommit.py |    3 ++-
 stgit/commands/undo.py     |    3 ++-
 stgit/lib/transaction.py   |   11 ++++++++---
 t/t2600-coalesce.sh        |   13 +++++++++++++
 6 files changed, 29 insertions(+), 7 deletions(-)

--=20
Karl Hasselstr=C3=B6m, kha@treskal.com
      www.treskal.com/kalle
