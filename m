From: =?UTF-8?q?Santi=20B=C3=A9jar?= <santi@agolina.net>
Subject: [PATCHv4 0/4] git pull --rebase fixes and cleanup
Date: Fri, 12 Jun 2009 00:39:17 +0200
Message-ID: <1244759961-4750-1-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 12 00:39:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEsvX-0006oE-BY
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 00:39:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758901AbZFKWjI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2009 18:39:08 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758221AbZFKWjH
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jun 2009 18:39:07 -0400
Received: from mail-fx0-f216.google.com ([209.85.220.216]:62928 "EHLO
	mail-fx0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757552AbZFKWjH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2009 18:39:07 -0400
Received: by fxm12 with SMTP id 12so288920fxm.37
        for <git@vger.kernel.org>; Thu, 11 Jun 2009 15:39:08 -0700 (PDT)
Received: by 10.86.91.3 with SMTP id o3mr2861125fgb.40.1244759948333;
        Thu, 11 Jun 2009 15:39:08 -0700 (PDT)
Received: from localhost (p5B0D383D.dip.t-dialin.net [91.13.56.61])
        by mx.google.com with ESMTPS id e20sm228155fga.25.2009.06.11.15.39.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Jun 2009 15:39:07 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.2.222.g479ad6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121366>

Changes since v3:
  - Extend 1/4 commit message to explain why there are not behavior cha=
nges

Santi B=C3=A9jar (4):
  parse-remote: function to get the tracking branch to be merge
  parse-remote: support default reflist in get_remote_merge_branch
  t5520-pull: --rebase with rebased upstream and two branches
  parse-remote: remove unused functions

 Documentation/git-parse-remote.txt |   20 ----
 git-parse-remote.sh                |  222 ++++------------------------=
-------
 git-pull.sh                        |    7 +-
 t/t5520-pull.sh                    |   29 +++++
 4 files changed, 57 insertions(+), 221 deletions(-)
