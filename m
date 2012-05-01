From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH 0/4] report chmod'ed binary files the same as text files
Date: Tue,  1 May 2012 19:10:11 +0200
Message-ID: <1335892215-21331-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: mj@ucw.cz,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue May 01 19:10:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPGax-0003BC-VT
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 19:10:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755807Ab2EARKb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 May 2012 13:10:31 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:35787 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752492Ab2EARKa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 13:10:30 -0400
Received: from ip-37-209-134-178.free.aero2.net.pl ([37.209.134.178] helo=localhost.localdomain)
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SPGar-0003uH-Bs; Tue, 01 May 2012 19:10:29 +0200
X-Mailer: git-send-email 1.7.10.539.g288dd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196698>

This patch series fixes a small discrepancy between the way that
text files and binary files are treated. Reported by Martin Mare=C5=A1 =
in [1].
=46irt patch is cleanup, second describes current behaviour, third does
the change, and fourth is a bonus micro-opt.=20

[1] http://article.gmane.org/gmane.comp.version-control.git/179361

Zbigniew J=C4=99drzejewski-Szmek (4):
  test: modernize style of t4006
  tests: check --[short]stat output after chmod
  diff --stat: report chmoded binary files like text files
  diff --stat: do not run diff on indentical files

 diff.c               |   30 +++++++++++++----------
 t/t4006-diff-mode.sh |   65 ++++++++++++++++++++++++++++++++++++------=
--------
 2 files changed, 65 insertions(+), 30 deletions(-)

--=20
1.7.10.539.g288dd
