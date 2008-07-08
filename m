From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 0/2] stg status rename fix (stable)
Date: Tue, 08 Jul 2008 21:54:19 +0200
Message-ID: <20080708195214.24866.61663.stgit@yoghurt>
References: <20080708122502.GA8838@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jon Smirl <jonsmirl@gmail.com>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 21:55:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGJHf-0004zL-Qr
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 21:55:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754263AbYGHTy2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jul 2008 15:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754188AbYGHTy2
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 15:54:28 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1608 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753989AbYGHTy2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 15:54:28 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1KGJGW-0003xG-00; Tue, 08 Jul 2008 20:54:20 +0100
In-Reply-To: <20080708122502.GA8838@diana.vm.bytemark.co.uk>
User-Agent: StGIT/0.14.3.194.gbf3df
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87793>

This fixes the bug on the stable branch. (stgit.diff-opts doesn't
exist there, so it's less of an issue, but still.)

Also available at

  git://repo.or.cz/stgit/kha.git safe

---

Karl Hasselstr=C3=B6m (2):
      Don't allow extra diff options with "stg status"
      Test "stg status" with renames


 stgit/commands/status.py |   16 +++-------------
 stgit/git.py             |    9 ++++++---
 t/t0002-status.sh        |   11 +++++++++++
 3 files changed, 20 insertions(+), 16 deletions(-)

--=20
Karl Hasselstr=C3=B6m, kha@treskal.com
      www.treskal.com/kalle
