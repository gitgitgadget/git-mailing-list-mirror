From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH v2 0/5] provide better error messages for @{upstream}
Date: Sat, 14 Apr 2012 09:54:30 +0200
Message-ID: <1334390075-25467-1-git-send-email-zbyszek@in.waw.pl>
References: <20120412204055.GA21018@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: peff@peff.net, Matthieu.Moy@grenoble-inp.fr,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Apr 14 09:56:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIxpz-0007Ry-NY
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 09:56:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752855Ab2DNHz6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Apr 2012 03:55:58 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:34823 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752819Ab2DNHz5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2012 03:55:57 -0400
Received: from 89-78-221-60.dynamic.chello.pl ([89.78.221.60] helo=localhost.localdomain)
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SIxpq-0001I9-Sv; Sat, 14 Apr 2012 09:55:55 +0200
X-Mailer: git-send-email 1.7.10.226.gfe575
In-Reply-To: <20120412204055.GA21018@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195472>

Hi,

v2:

- Better commit descriptions (hopefully)
- error_message used in tests in one more place
- Error message changed from
  "Upstream branch '%s' not fetched from remote '%s'"
  to
  "Upstream branch '%s' not stored as a remote-tracking branch".

[I thought about using
 "No tracking brach for remote branch '%s'"
 or
 "No remote-tracking branch for upstream branch '%s'"
 or
 "Tracking branch not configured for upstream branch '%s'"
 but neither one is convincing. ]

Zbigniew J=C4=99drzejewski-Szmek (5):
      t1507: add tests to document @{upstream} behaviour
      Provide branch name in error message when using @{u}
      Provide better message for barnhc_wiht_tpyo@{u}
      Be more specific if upstream branch is not tracked
      i18n: mark @{upstream} error messages for translation

 sha1_name.c                   |   20 ++++++++--
 t/t1507-rev-parse-upstream.sh |   81 +++++++++++++++++++++++++++++++++=
++++++--
 2 files changed, 94 insertions(+), 7 deletions(-)

--=20
1.7.10.344.g387ed
