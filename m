From: =?UTF-8?q?Santi=20B=C3=A9jar?= <santi@agolina.net>
Subject: [RFC/PATCH 0/2] Support for arbitrary mapping for "git pull --rebase"
Date: Thu, 18 Jun 2009 09:57:11 +0200
Message-ID: <1245311834-5290-1-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 18 09:57:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHCUZ-00026h-Sm
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 09:57:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755679AbZFRH4x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2009 03:56:53 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755430AbZFRH4x
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 03:56:53 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:37467 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754505AbZFRH4w (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2009 03:56:52 -0400
Received: by bwz9 with SMTP id 9so868030bwz.37
        for <git@vger.kernel.org>; Thu, 18 Jun 2009 00:56:53 -0700 (PDT)
Received: by 10.103.239.10 with SMTP id q10mr827610mur.36.1245311813780;
        Thu, 18 Jun 2009 00:56:53 -0700 (PDT)
Received: from localhost (p5B0D73A2.dip.t-dialin.net [91.13.115.162])
        by mx.google.com with ESMTPS id w5sm4966968mue.4.2009.06.18.00.56.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 18 Jun 2009 00:56:53 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.2.406.gd6a466
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121802>

Hi *,

  Here you have my patch serie to add support for arbitrary mapping for
"git pull --rebase".

  This is a RFC specially for the new "git remote" subcommand, tracking=
=2E
Suggest other things if you think of a better way.

  Santi

Santi B=C3=A9jar (2):
  remote tracking: return the tracking branch for the given branches
  get_remote_merge_branch: Support for arbitrary mapping

 Documentation/git-remote.txt |    7 +++++++
 builtin-remote.c             |   35 ++++++++++++++++++++++++++++++++++=
+
 git-parse-remote.sh          |   21 ++++++++++++---------
 3 files changed, 54 insertions(+), 9 deletions(-)
