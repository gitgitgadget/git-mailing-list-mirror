From: =?utf-8?q?Santi=20B=C3=A9jar?= <santi@agolina.net>
Subject: [PATCH 0/4] push.default and branch.<name>.{remote,merge} changes
Date: Sun, 29 Mar 2009 00:10:00 +0100
Message-ID: <1238281804-30290-1-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 29 00:11:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lnhgr-0002uR-2D
	for gcvg-git-2@gmane.org; Sun, 29 Mar 2009 00:11:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752906AbZC1XKR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Mar 2009 19:10:17 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752265AbZC1XKR
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Mar 2009 19:10:17 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:59133 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752110AbZC1XKQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Mar 2009 19:10:16 -0400
Received: by fxm2 with SMTP id 2so1483335fxm.37
        for <git@vger.kernel.org>; Sat, 28 Mar 2009 16:10:13 -0700 (PDT)
Received: by 10.103.91.2 with SMTP id t2mr1004575mul.52.1238281813105;
        Sat, 28 Mar 2009 16:10:13 -0700 (PDT)
Received: from localhost (p5B0D7403.dip.t-dialin.net [91.13.116.3])
        by mx.google.com with ESMTPS id t10sm6245424muh.29.2009.03.28.16.10.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 28 Mar 2009 16:10:12 -0700 (PDT)
X-Mailer: git-send-email 1.6.1.258.g7ff14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114987>

Hi *,

  the four patches are independent, but I've send them in a series beca=
use
their topic is related. Well, there is a textual dependency between the=
 3rd
and the 4th.

  The 1st one can also be applied to 'maint' while the rest is on top o=
f 'next'
because the 'push.default' is only there.

Santi B=C3=A9jar (4):
  Documentation: enhance branch.<name>.{remote,merge}
  Documentation: push.default applies to all remotes
  Documentation: branch.*.merge can also afect 'git-push'
  Rename push.default to push.style

 Documentation/RelNotes-1.6.3.txt |    2 +-
 Documentation/config.txt         |   21 ++++++++++-----------
 builtin-push.c                   |   16 ++++++++--------
 cache.h                          |   14 +++++++-------
 config.c                         |   10 +++++-----
 environment.c                    |    2 +-
 6 files changed, 32 insertions(+), 33 deletions(-)
