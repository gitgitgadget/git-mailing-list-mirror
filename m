From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCHv2 0/3] Improve branch UI for setting upstream information
Date: Thu, 30 Aug 2012 19:23:10 +0200
Message-ID: <1346347393-8425-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 30 19:23:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T78Sq-0005nt-NU
	for gcvg-git-2@plane.gmane.org; Thu, 30 Aug 2012 19:23:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752162Ab2H3RXL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Aug 2012 13:23:11 -0400
Received: from hessy.cmartin.tk ([78.47.67.53]:57839 "EHLO hessy.dwim.me"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751103Ab2H3RXK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2012 13:23:10 -0400
Received: from cmartin.tk (p4FC5D726.dip.t-dialin.net [79.197.215.38])
	by hessy.dwim.me (Postfix) with ESMTPA id C3A4B80030;
	Thu, 30 Aug 2012 19:23:08 +0200 (CEST)
Received: (nullmailer pid 8463 invoked by uid 1000);
	Thu, 30 Aug 2012 17:23:13 -0000
X-Mailer: git-send-email 1.7.12.3.g0dd8ef6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204552>

Hi all,

As a result of making --unset-upstream fail if the given branch
doesn't exist, I discovered a copy-paste error in on the the tests in
the patch after it, so I'm resending the whole thing.

The changes from the last reroll are the tightening of the situations
where git will show an error message (not it's just if the branch is
new and exists as remote-tracking) which I already sent as a reply in
the other thread; and making --unset-upstream error out on bad input,
which I already mentioned above.

   cmn

Carlos Mart=C3=ADn Nieto (3):
  branch: introduce --set-upstream-to
  branch: add --unset-upstream option
  branch: deprecate --set-upstream and show help if we detect possible
    mistaken use

 Documentation/git-branch.txt | 14 ++++++++-
 builtin/branch.c             | 60 ++++++++++++++++++++++++++++++++++++=
+--
 t/t3200-branch.sh            | 67 ++++++++++++++++++++++++++++++++++++=
++++++++
 3 files changed, 137 insertions(+), 4 deletions(-)

--=20
1.7.12.3.g0dd8ef6
