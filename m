From: =?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
Subject: [PATCH v2 00/22] git-remote-mediawiki: Follow perlcritic's recommandations
Date: Fri,  7 Jun 2013 23:42:01 +0200
Message-ID: <1370641344-4253-1-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: benoit.person@ensimag.fr, matthieu.moy@grenoble-inp.fr,
	=?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 07 23:43:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul4R4-0007mN-Ak
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 23:43:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755813Ab3FGVm6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Jun 2013 17:42:58 -0400
Received: from mx2.imag.fr ([129.88.30.17]:55279 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753181Ab3FGVm5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 17:42:57 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r57Lgo7q003228
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 7 Jun 2013 23:42:50 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r57Lgr1T029545;
	Fri, 7 Jun 2013 23:42:53 +0200
Received: from tohwi-K50IE.imag.fr (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r57LgqRb019409;
	Fri, 7 Jun 2013 23:42:53 +0200
X-Mailer: git-send-email 1.7.9.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 07 Jun 2013 23:42:50 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r57Lgo7q003228
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: celestin.matte@ensimag.fr
MailScanner-NULL-Check: 1371246172.83207@G0e8brA0YOT/zwbOHCeiKg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226717>

v2 of patch to follow perlcritic's recommandations ([1])

Changes with v1:
- split first commit into 6 different commits
- remove commit [17/18] about moving open() call
- took every other comment into account

[1]: http://thread.gmane.org/gmane.comp.version-control.git/226533

C=C3=A9lestin Matte (22):
  git-remote-mediawiki: Replace :utf8 by :encoding(UTF-8)
  git-remote-mediawiki: Use the Readonly module instead of the constant
    pragma
  git-remote-mediawiki: Always end a subroutine with a return
  git-remote-mediawiki: Move a variable declaration at the top of the
    code
  git-remote-mediawiki: Change syntax of map calls
  git-remote-mediawiki: Rewrite unclear line of instructions
  git-remote-mediawiki: Change style of some regular expressions
  git-remote-mediawiki: Add newline in the end of die() error messages
  git-remote-mediawiki: Change the name of a variable
  git-remote-mediawiki: Turn double-negated expressions into simple
    expressions
  git-remote-mediawiki: Remove unused variable $entry
  git-remote-mediawiki: Rename a variable ($last) which has the name of
    a keyword
  git-remote-mediawiki: Assign a variable as undef and make proper
    indentation
  git-remote-mediawiki: Check return value of open + remove import of
    unused open2
  git-remote-mediawiki: Put long code into a subroutine
  git-remote-mediawiki: Modify strings for a better coding-style
  git-remote-mediawiki: Brace file handles for print for more clarity
  git-remote-mediawiki: Replace "unless" statements with negated "if"
    statements
  git-remote-mediawiki: Don't use quotes for empty strings
  git-remote-mediawiki: Put non-trivial numeric values in constants.
  git-remote-mediawiki: Fix a typo ("mediwiki" instead of "mediawiki")
  git-remote-mediawiki: Clearly rewrite double dereference

 contrib/mw-to-git/git-remote-mediawiki.perl |  545 ++++++++++++++-----=
--------
 1 file changed, 293 insertions(+), 252 deletions(-)

--=20
1.7.9.5
