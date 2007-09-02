From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 00/15] i18n support for git-gui
Date: Sun, 2 Sep 2007 17:23:50 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709021719380.28586@racer.site>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1968424043-1188750230=:28586"
To: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 02 18:25:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRsFw-0003Qj-F5
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 18:25:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754928AbXIBQYc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 12:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753366AbXIBQYc
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 12:24:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:52357 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752821AbXIBQYc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 12:24:32 -0400
Received: (qmail invoked by alias); 02 Sep 2007 16:24:30 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp004) with SMTP; 02 Sep 2007 18:24:30 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Mfrt4NbXMsmn+GzDuUktc9kwPhzW2tnPGLKxcZf
	ZI5k4qXpNrwMbM
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57345>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1968424043-1188750230=:28586
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

to test, as usual call "make" in git-gui and use git-gui.sh.  Or install 
right away.


The shortlog:

Christian Stimming (6):
      Mark strings for translation.
      Makefile rules for translation catalog generation and installation.
      Add glossary that can be converted into a po file for each language.
      Add glossary translation template into git.
      German translation for git-gui
      German glossary for translation

Irina Riesen (1):
      git-gui: initial version of russian translation

Johannes Schindelin (2):
      Add po/git-gui.pot
      Ignore po/*.msg

Junio C Hamano (1):
      git-gui po/README: Guide to translators

Miklos Vajna (1):
      Hungarian translation of git-gui

Paolo Ciarrocchi (1):
      Italian translation of git-gui

Xudong Guan (2):
      Initial Chinese translation for git-gui
      git-gui: Added initial version of po/glossary/zh_cn.po

しらいしななこ (1):
      Japanese translation of git-gui


And the diffstat:

 Makefile                         |   21 +-
 git-gui.sh                       |  265 ++++----
 lib/blame.tcl                    |   10 +-
 lib/branch_checkout.tcl          |   16 +-
 lib/branch_create.tcl            |   38 +-
 lib/branch_delete.tcl            |   22 +-
 lib/branch_rename.tcl            |   22 +-
 lib/browser.tcl                  |   22 +-
 lib/checkout_op.tcl              |   48 +-
 lib/choose_rev.tcl               |   16 +-
 lib/commit.tcl                   |   52 +-
 lib/console.tcl                  |   14 +-
 lib/database.tcl                 |   28 +-
 lib/diff.tcl                     |   16 +-
 lib/error.tcl                    |    8 +-
 lib/index.tcl                    |   23 +-
 lib/merge.tcl                    |   60 +-
 lib/option.tcl                   |   49 +-
 lib/remote.tcl                   |    6 +-
 lib/remote_branch_delete.tcl     |   42 +-
 lib/shortcut.tcl                 |   12 +-
 lib/status_bar.tcl               |    2 +-
 lib/transport.tcl                |   30 +-
 po/.gitignore                    |    2 +
 po/README                        |  205 ++++++
 po/de.po                         | 1398 +++++++++++++++++++++++++++++++++++
 po/git-gui.pot                   | 1264 ++++++++++++++++++++++++++++++++
 po/glossary/Makefile             |    9 +
 po/glossary/de.po                |  158 ++++
 po/glossary/git-gui-glossary.pot |  152 ++++
 po/glossary/git-gui-glossary.txt |   34 +
 po/glossary/txt-to-pot.sh        |   48 ++
 po/glossary/zh_cn.po             |  170 +++++
 po/hu.po                         | 1422 ++++++++++++++++++++++++++++++++++++
 po/it.po                         | 1393 +++++++++++++++++++++++++++++++++++
 po/ja.po                         | 1381 +++++++++++++++++++++++++++++++++++
 po/ru.po                         | 1480 ++++++++++++++++++++++++++++++++++++++
 po/zh_cn.po                      | 1284 +++++++++++++++++++++++++++++++++
 38 files changed, 10822 insertions(+), 400 deletions(-)


Have fun!

Ciao,
Dscho

--8323584-1968424043-1188750230=:28586--
