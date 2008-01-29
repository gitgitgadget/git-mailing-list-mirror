From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 0/4] Rewrite "stg edit" to use new infrastructure
Date: Tue, 29 Jan 2008 04:15:14 +0100
Message-ID: <20080129031310.1177.83290.stgit@yoghurt>
References: <20080129025821.GA1373@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 04:15:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJgww-0006Xx-LJ
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 04:15:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752797AbYA2DPT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jan 2008 22:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753388AbYA2DPT
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 22:15:19 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4644 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752369AbYA2DPS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 22:15:18 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1JJgwK-0000dq-00; Tue, 29 Jan 2008 03:15:13 +0000
In-Reply-To: <20080129025821.GA1373@diana.vm.bytemark.co.uk>
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71939>

This is in kha/experimental. We hardly have any tests for "stg edit",
and the control flow is kind of complicated.

---

Karl Hasselstr=C3=B6m (4):
      Convert "stg edit" to the new infrastructure
      Teach new infrastructure to diff two trees
      Teach new infrastructure to apply patches
      Teach new infrastructure about the default author and committer


 stgit/commands/edit.py |  309 ++++++++++++++++++++++------------------=
--------
 stgit/lib/git.py       |   54 ++++++++
 2 files changed, 196 insertions(+), 167 deletions(-)

--=20
Karl Hasselstr=C3=B6m, kha@treskal.com
      www.treskal.com/kalle
