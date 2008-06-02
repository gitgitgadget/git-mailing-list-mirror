From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [PATCH v2 0/2] Make old sha1 optional with git update-ref -d
Date: Tue, 03 Jun 2008 01:34:42 +0200
Message-ID: <20080602233244.26087.51827.stgit@yoghurt>
References: <20080525193213.GB5674@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 01:36:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3JZY-0002sL-ST
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 01:36:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754220AbYFBXfZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Jun 2008 19:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754216AbYFBXfZ
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 19:35:25 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4747 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754163AbYFBXfY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 19:35:24 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1K3JY3-0001Zr-00; Tue, 03 Jun 2008 00:34:43 +0100
In-Reply-To: <20080525193213.GB5674@diana.vm.bytemark.co.uk>
User-Agent: StGIT/0.14.2.171.g5c0d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83594>

This series makes the old ref value optional for update-ref -d (it's
already optional for update-ref without -d).

---

Patch 1/2 updated after comments from Junio.

Karl Hasselstr=C3=B6m (2):
      Make old sha1 optional with git update-ref -d
      Clean up builtin-update-ref's option parsing


 Documentation/git-update-ref.txt |    2 +-
 builtin-update-ref.c             |   36 ++++++++++++++++++++----------=
------
 t/t1400-update-ref.sh            |    8 ++++++++
 3 files changed, 29 insertions(+), 17 deletions(-)

--=20
Karl Hasselstr=C3=B6m, kha@treskal.com
      www.treskal.com/kalle
