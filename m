From: =?utf-8?q?Santi=20B=C3=A9jar?= <santi@agolina.net>
Subject: [PATCHv2 0/4] push.default and branch.<name>.{remote,merge} changes
Date: Mon, 30 Mar 2009 12:11:39 +0200
Message-ID: <1238407903-28020-1-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 30 12:14:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoEUi-0006ps-UH
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 12:13:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758389AbZC3KL6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 06:11:58 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758286AbZC3KL6
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 06:11:58 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:44348 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753002AbZC3KL5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 06:11:57 -0400
Received: by bwz17 with SMTP id 17so1837526bwz.37
        for <git@vger.kernel.org>; Mon, 30 Mar 2009 03:11:54 -0700 (PDT)
Received: by 10.223.117.1 with SMTP id o1mr3752257faq.96.1238407913980;
        Mon, 30 Mar 2009 03:11:53 -0700 (PDT)
Received: from localhost (p5B0D60BE.dip.t-dialin.net [91.13.96.190])
        by mx.google.com with ESMTPS id f31sm2233595fkf.15.2009.03.30.03.11.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 30 Mar 2009 03:11:53 -0700 (PDT)
X-Mailer: git-send-email 1.6.1.258.g7ff14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115127>

Hi *,

  the four patches are conceptually independent, but they have textual
dependency.

  The 1st one can also be applied to 'maint'.

Changes from v1:
  rename "tracking branch" to "upstream branch"
  rename push.default to push.mode instead of push.style

Santi B=C3=A9jar (4):
  Documentation: enhance branch.<name>.{remote,merge}
  Documentation: push.default applies to all remotes
  Documentation: branch.*.merge can also afect 'git-push'
  Rename push.default to push.mode

 Documentation/RelNotes-1.6.3.txt |    2 +-
 Documentation/config.txt         |   21 ++++++++++-----------
 builtin-push.c                   |   16 ++++++++--------
 cache.h                          |   14 +++++++-------
 config.c                         |   10 +++++-----
 environment.c                    |    2 +-
 6 files changed, 32 insertions(+), 33 deletions(-)
