From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 0/2] Make new infrastructure subdirectory safe
Date: Wed, 19 Dec 2007 23:19:23 +0100
Message-ID: <20071219221848.29455.50676.stgit@yoghurt>
References: <20071218092419.GA16029@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 23:20:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J57Gg-0001vj-R9
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 23:19:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752903AbXLSWTg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Dec 2007 17:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752934AbXLSWTg
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 17:19:36 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3259 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752903AbXLSWTf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 17:19:35 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1J57GE-0003wB-00; Wed, 19 Dec 2007 22:19:30 +0000
In-Reply-To: <20071218092419.GA16029@diana.vm.bytemark.co.uk>
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68945>

---

Karl Hasselstr=C3=B6m (2):
      Make "stg goto" subdirectory safe
      Test that "stg goto" can be called from a subdirectory


 stgit/lib/git.py       |    5 ++--
 stgit/run.py           |    9 +++++--
 t/t2800-goto-subdir.sh |   59 ++++++++++++++++++++++++++++++++++++++++=
++++++++
 3 files changed, 68 insertions(+), 5 deletions(-)
 create mode 100755 t/t2800-goto-subdir.sh

--=20
Karl Hasselstr=C3=B6m, kha@treskal.com
      www.treskal.com/kalle
