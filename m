From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 0/2] Test+fix for bug 11887 (stg sink)
Date: Mon, 30 Jun 2008 00:45:35 +0200
Message-ID: <20080629224440.9267.3591.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Erik Sandberg <mandolaerik@gmail.com>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 30 00:47:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KD5fy-00056f-HC
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 00:47:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752717AbYF2Wpo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Jun 2008 18:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751995AbYF2Wpo
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 18:45:44 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2448 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751888AbYF2Wpn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 18:45:43 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1KD5eK-0003UA-00; Sun, 29 Jun 2008 23:45:36 +0100
User-Agent: StGIT/0.14.2.171.g5c0d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86842>

This should go on the stable branch, of course.

---

Karl Hasselstr=C3=B6m (2):
      Fix "stg sink" with no applied patches (bug 11887)
      Try "stg sink" without applied patches


 stgit/commands/sink.py |    8 ++++++--
 t/t1501-sink.sh        |   28 ++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 2 deletions(-)
 create mode 100755 t/t1501-sink.sh

--=20
Karl Hasselstr=C3=B6m, kha@treskal.com
      www.treskal.com/kalle
