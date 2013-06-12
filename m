From: =?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
Subject: [PATCH v5 00/31] Follow perlcritic's recommandations
Date: Wed, 12 Jun 2013 17:43:17 +0200
Message-ID: <1371051828-12866-1-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: benoit.person@ensimag.fr, matthieu.moy@grenoble-inp.fr,
	=?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 12 17:44:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmnDQ-0006pX-O2
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 17:44:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753746Ab3FLPoA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Jun 2013 11:44:00 -0400
Received: from mx1.imag.fr ([129.88.30.5]:43391 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752688Ab3FLPn7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jun 2013 11:43:59 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5CFhtlG028537
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 12 Jun 2013 17:43:56 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5CFhv3I014966;
	Wed, 12 Jun 2013 17:43:57 +0200
Received: from tohwi-K50IE.imag.fr (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r5CFhu5j014096;
	Wed, 12 Jun 2013 17:43:57 +0200
X-Mailer: git-send-email 1.8.3.rc3.18.g21a7b2c
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 12 Jun 2013 17:43:56 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227622>

Not many changes since v3. This version is only for fixing last typos a=
nd
applying Junio's recommandations for [21/31], which I forgot in v4.
At this point, the only patch worth reviewing is [21/31].

Changes with v4 :=20
- fixed typos
- Change in [21/31]: all the processing is done within the subroutine

Changes with v3:
- Remove whitespace in [18/28]
- Typo in [09/28]
- Better line split in [22/28]
- A part of the file @@ -610,9 +610,9 @@ had escaped patches [22/31] an=
d=20
[23/31] for some reason. This is fixed.
- patch [29/31] and [30/31] are new: they add a .perlcriticrc file to i=
gnore
some rules and add a rule in the Makefile for perlcritic
- patch [31/31] is also a new one, which intends to make some error mes=
sages=20
more precise. It comes from an advice from es in the reviewing of v1, t=
hat I=20
had forgotten to add in earlier versions. It is not related to perlcrit=
ic, but I
hope it can be included into this series of patches anyway.

Changes with v2:
- Remove patch [02/22] about using the Readonly module
- Split commit [07/22] into 5 different ones
- Split commit [14/22] into 2 different ones
- Patch [17/22] was *not* split: tell me if it is necessary
- Remove wrong change in patch [22/22]

Changes with v1:
- split first commit into 6 different commits
- remove commit [17/18] about moving open() call
- took every other comment into account

C=C3=A9lestin Matte (31):
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
  git-remote-mediawiki: Add a .perlcriticrc file
  git-remote-mediawiki: add a perlcritic rule in Makefile
  git-remote-mediawiki: Make error message more precise

 contrib/mw-to-git/.perlcriticrc             |  28 ++
 contrib/mw-to-git/Makefile                  |   5 +-
 contrib/mw-to-git/git-remote-mediawiki.perl | 549 +++++++++++++++-----=
--------
 3 files changed, 328 insertions(+), 254 deletions(-)
 create mode 100644 contrib/mw-to-git/.perlcriticrc

--=20
1.8.3.rc3.18.g21a7b2c
