From: =?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
Subject: [PATCH v3 00/28] Follow perlcritic's recommandations
Date: Mon, 10 Jun 2013 00:22:25 +0200
Message-ID: <1370816573-3808-1-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: benoit.person@ensimag.fr, matthieu.moy@grenoble-inp.fr,
	=?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 10 00:23:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ulo1U-0000hF-JP
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 00:23:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034Ab3FIWXg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 18:23:36 -0400
Received: from mx2.imag.fr ([129.88.30.17]:41251 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750910Ab3FIWXf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 18:23:35 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r59MNQht021459
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 10 Jun 2013 00:23:26 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r59MNTVk019414;
	Mon, 10 Jun 2013 00:23:29 +0200
Received: from tohwi-K50IE.imag.fr (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r59MNSHN008599;
	Mon, 10 Jun 2013 00:23:29 +0200
X-Mailer: git-send-email 1.7.9.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 10 Jun 2013 00:23:27 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r59MNQht021459
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: celestin.matte@ensimag.fr
MailScanner-NULL-Check: 1371421411.53829@LQLkaq6oTveHw9n/6hnB9A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227174>

Changes with v2:
- Remove patch [02/22] about using the Readonly module
- Split commit [07/22] into 5 different ones
- Split commit [14/22] into 2 different ones
- Patch [17/22] was *not* split: tell me if it is necessary
- Remove wrong change in patch [22/22]

Patch about fixing a bug in a regexp (with has been renames "Make a reg=
exp
clearer"), which had been sent as a separate patch, is reintegrated int=
o this
series of patches.

Changes with v1:
- split first commit into 6 different commits
- remove commit [17/18] about moving open() call
- took every other comment into account

C=C3=A9lestin Matte (28):
  git-remote-mediawiki: Make a regexp clearer
  git-remote-mediawiki: Move "use warnings;" before any instruction
  git-remote-mediawiki: Replace :utf8 by :encoding(UTF-8)
  git-remote-mediawiki: Always end a subroutine with a return
  git-remote-mediawiki: Move a variable declaration at the top of the
    code
  git-remote-mediawiki: Change syntax of map calls
  git-remote-mediawiki: Rewrite unclear line of instructions
  git-remote-mediawiki: Remove useless regexp modifier (m)
  git-remote-mediawiki: Change the behaviour of a split
  git-remote-mediawiki: Change separator of some regexps
  git-remote-mediawiki: Change style in a regexp
  git-remote-mediawiki: Change style in a regexp
  git-remote-mediawiki: Add newline in the end of die() error messages
  git-remote-mediawiki: Change the name of a variable
  git-remote-mediawiki: Turn double-negated expressions into simple
    expressions
  git-remote-mediawiki: Remove unused variable $entry
  git-remote-mediawiki: Rename a variable ($last) which has the name of
    a keyword
  git-remote-mediawiki: Assign a variable as undef and make proper
    indentation
  git-remote-mediawiki: Check return value of open
  git-remote-mediawiki: remove import of unused open2
  git-remote-mediawiki: Put long code into a subroutine
  git-remote-mediawiki: Modify strings for a better coding-style
  git-remote-mediawiki: Brace file handles for print for more clarity
  git-remote-mediawiki: Replace "unless" statements with negated "if"
    statements
  git-remote-mediawiki: Don't use quotes for empty strings
  git-remote-mediawiki: Put non-trivial numeric values in constants.
  git-remote-mediawiki: Fix a typo ("mediwiki" instead of "mediawiki")
  git-remote-mediawiki: Clearly rewrite double dereference

 contrib/mw-to-git/git-remote-mediawiki.perl |  534 +++++++++++++++----=
--------
 1 file changed, 288 insertions(+), 246 deletions(-)

--=20
1.7.9.5
