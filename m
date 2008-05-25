From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [PATCH 0/3] Make old sha1 optional with git update-ref -d
Date: Sun, 25 May 2008 18:14:24 +0200
Message-ID: <20080525161125.25087.18083.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 25 18:16:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0ItE-00010j-O2
	for gcvg-git-2@gmane.org; Sun, 25 May 2008 18:16:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753528AbYEYQPS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 May 2008 12:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753470AbYEYQPR
	(ORCPT <rfc822;git-outgoing>); Sun, 25 May 2008 12:15:17 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1636 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753352AbYEYQPQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 May 2008 12:15:16 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1K0IrX-0001DE-00; Sun, 25 May 2008 17:14:23 +0100
User-Agent: StGIT/0.14.2.156.gbabd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82867>

This series makes the old ref value optional for update-ref -d (it's
already optional for update-ref without -d). But first it adds some
test and refactors a bit.

---

Karl Hasselstr=C3=B6m (3):
      Make old sha1 optional with git update-ref -d
      Clean up builtin-update-ref's option parsing
      Add some tests for git update-ref -d


 Documentation/git-update-ref.txt |    2 +-
 builtin-update-ref.c             |   32 ++++++++++++++++++------------=
--
 t/t1400-update-ref.sh            |   24 ++++++++++++++++++++++++
 3 files changed, 43 insertions(+), 15 deletions(-)

--=20
Karl Hasselstr=C3=B6m, kha@treskal.com
      www.treskal.com/kalle
