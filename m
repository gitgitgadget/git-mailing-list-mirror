From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCH 0/3] A better way of handling upstream information in git-branch
Date: Tue, 10 Jul 2012 18:52:58 +0200
Message-ID: <1341939181-8962-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jrnieder@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 10 18:53:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SodgN-0004BT-44
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jul 2012 18:53:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756439Ab2GJQwn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jul 2012 12:52:43 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:56650 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754316Ab2GJQwl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2012 12:52:41 -0400
Received: from centaur.lab.cmartin.tk (p4FC5CD3B.dip.t-dialin.net [79.197.205.59])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 13D9F46149;
	Tue, 10 Jul 2012 18:52:37 +0200 (CEST)
Received: (nullmailer pid 8999 invoked by uid 1000);
	Tue, 10 Jul 2012 16:53:01 -0000
X-Mailer: git-send-email 1.7.10.2.1.g8c77c3c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201261>

Hello all,

This stems from comments made by Junio and Jonathan about my proposed
changes to --set-upstream.

This should probably have a few tests, but I'd like to hear comments
about the code and documentation first. The third patch is the one I'm
not so confident about. It would be simpler to remove the whole
branch.foo configuration, but that wouldn't be very safe, as we may
have more things there (either the future git or some external tool).

Carlos Mart=C3=ADn Nieto (3):
  branch: introduce --set-upstream-to
  branch: suggest how to undo a --set-upstream when given one branch
  branch: add --unset-upstream option

 Documentation/git-branch.txt |   14 +++++++++++-
 builtin/branch.c             |   50 ++++++++++++++++++++++++++++++++++=
+++++---
 2 files changed, 60 insertions(+), 4 deletions(-)

--=20
1.7.10.2.1.g8c77c3c
