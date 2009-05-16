From: Johan Herland <johan@herland.net>
Subject: [PATCH 0/5] RESEND: git notes
Date: Sat, 16 May 2009 03:45:03 +0200
Message-ID: <cover.1242437696.git.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de,
	trast@student.ethz.ch, tavestbo@trolltech.com, johan@herland.net,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat May 16 03:47:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5900-0004iT-7n
	for gcvg-git-2@gmane.org; Sat, 16 May 2009 03:47:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753943AbZEPBq2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2009 21:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753829AbZEPBq2
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 21:46:28 -0400
Received: from mx.getmail.no ([84.208.15.66]:51867 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753821AbZEPBq1 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 May 2009 21:46:27 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KJP000GWRLFXB40@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Sat, 16 May 2009 03:46:27 +0200 (MEST)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KJP0047TRKAYOH0@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Sat, 16 May 2009 03:46:27 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.5.16.13426
X-Mailer: git-send-email 1.6.3.rc0.1.gf800
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119309>

Hi,

Dscho has asked me to take over the responsibility for the js/notes
patch series.

The following is a re-roll and resend of the patch series currently
in pu, plus my own 2 patches for adding support for "-m" and "-F" to
"git notes edit".

On advice from Dscho, I have squashed the current bugfix and cleanup
patches in js/notes into the first 4 "main" patches. As a result the
original 15 + 2 patch series is now down to 5 (4 + 1) patches.

In sum, these 5 patches produce the exact same result as the original
js/notes series (plus my 2 patches).

I have taken the liberty of squashing the various Signed-off-by tags
(along with their corresponding patches) into these 5 new patches.
I hope this is OK with everybody. If not, I apologize; please tell me,
and I will re-send.


Have fun! :)

...Johan


Johan Herland (1):
  Teach "-m <msg>" and "-F <file>" to "git notes edit"

Johannes Schindelin (4):
  Introduce commit notes
  Add a script to edit/inspect notes
  Speed up git notes lookup
  Add an expensive test for git-notes

 .gitignore                       |    1 +
 Documentation/config.txt         |   13 +++
 Documentation/git-notes.txt      |   60 ++++++++++++++
 Makefile                         |    3 +
 cache.h                          |    4 +
 command-list.txt                 |    1 +
 commit.c                         |    1 +
 config.c                         |    5 +
 environment.c                    |    1 +
 git-notes.sh                     |  121 ++++++++++++++++++++++++++++
 notes.c                          |  160 ++++++++++++++++++++++++++++++++++++++
 notes.h                          |    7 ++
 pretty.c                         |    5 +
 t/t3301-notes.sh                 |  149 +++++++++++++++++++++++++++++++++++
 t/t3302-notes-index-expensive.sh |   98 +++++++++++++++++++++++
 15 files changed, 629 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-notes.txt
 create mode 100755 git-notes.sh
 create mode 100644 notes.c
 create mode 100644 notes.h
 create mode 100755 t/t3301-notes.sh
 create mode 100755 t/t3302-notes-index-expensive.sh
