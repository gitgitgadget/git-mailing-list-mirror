From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH] stg status rename fix (safe+experimental)
Date: Tue, 08 Jul 2008 21:57:14 +0200
Message-ID: <20080708195508.25030.46828.stgit@yoghurt>
References: <20080708122502.GA8838@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jon Smirl <jonsmirl@gmail.com>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 21:58:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGJKP-00060w-3P
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 21:58:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752509AbYGHT5W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jul 2008 15:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753240AbYGHT5W
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 15:57:22 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1617 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752378AbYGHT5V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 15:57:21 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1KGJJK-0003z0-00; Tue, 08 Jul 2008 20:57:14 +0100
In-Reply-To: <20080708122502.GA8838@diana.vm.bytemark.co.uk>
User-Agent: StGIT/0.14.3.194.gbf3df
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87794>

This is just a patch to make sure the bug is gone; the bugfix consists
of a merge of the updated stable branch.

Both safe and experimental at git://repo.or.cz/stgit/kha.git has said
merge, and this test.

---

Karl Hasselstr=C3=B6m (1):
      Test "stg status" with -M in stgit.diff-opts


 t/t0002-status.sh |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

--=20
Karl Hasselstr=C3=B6m, kha@treskal.com
      www.treskal.com/kalle
