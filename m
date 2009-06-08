From: =?utf-8?q?Santi=20B=C3=A9jar?= <santi@agolina.net>
Subject: [PATCHv3 0/4] git pull --rebase fixes and cleanups
Date: Mon,  8 Jun 2009 11:00:47 +0200
Message-ID: <1244451651-22651-1-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 08 11:01:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDajW-0001Ws-0K
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 11:01:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754324AbZFHJAo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 05:00:44 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753964AbZFHJAo
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 05:00:44 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:28402 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753248AbZFHJAn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 05:00:43 -0400
Received: by fg-out-1718.google.com with SMTP id d23so721017fga.17
        for <git@vger.kernel.org>; Mon, 08 Jun 2009 02:00:44 -0700 (PDT)
Received: by 10.86.90.2 with SMTP id n2mr6946094fgb.39.1244451644919;
        Mon, 08 Jun 2009 02:00:44 -0700 (PDT)
Received: from localhost (p5B0D59E7.dip.t-dialin.net [91.13.89.231])
        by mx.google.com with ESMTPS id 4sm16714fgg.8.2009.06.08.02.00.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 08 Jun 2009 02:00:44 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.1.308.g426b5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121049>

Santi B=C3=A9jar (4):
  parse-remote: function to get the tracking branch to be merge
  parse-remote: support default reflist in get_remote_merge_branch
  t5520-pull: --rebase with rebased upstream and two branches
  parse-remote: remove unused functions

 Documentation/git-parse-remote.txt |   20 ----
 git-parse-remote.sh                |  207 ++++------------------------=
--------
 git-pull.sh                        |    7 +-
 t/t5520-pull.sh                    |   29 +++++
 4 files changed, 52 insertions(+), 211 deletions(-)
