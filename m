From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCHv3 0/5] Improving gitweb documentation, creating manpages
Date: Mon,  6 Jun 2011 19:44:26 +0200
Message-ID: <1307382271-7677-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>,
	Drew Northup <drew.northup@maine.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 19:51:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTdy1-0005Yb-Tf
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 19:51:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754758Ab1FFRvb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 13:51:31 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:33787 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753427Ab1FFRv2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2011 13:51:28 -0400
Received: by wwa36 with SMTP id 36so4070004wwa.1
        for <git@vger.kernel.org>; Mon, 06 Jun 2011 10:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=x8hbg12M4T9ReacM6PQ7Hx7TP5gJddr3ctNxZYobChA=;
        b=gf0LZGWu2bpvdvnn4rwxPixphrYENhueSMBrC0RJLcA57tcJQzyMf8QdNUoN89w7Ym
         v3LSj8pUiY2cynjfu2O6a0fbtKoY9UwTPslKIxo16Sq+8thtMOh2+QxyIX3ZTT+xvzY3
         ZULipIK7B64mQVPON3HxqA5s9to/yebCe+UxA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=dH3KtM71qNWpQKMaST78IDkbyEaDCbI90lxw53lq6vF9vXCvcExirDyW+CjY+cerpX
         Hi1rhvujY3TziCenEUAuqnWZH4cIHF241mixpkPBvx0/YdTUmWp31ynjDHIz8jLNuRBm
         FkYoEJd8vbgiPOx85fNcLgUZIyfYB5ESIQ/Lk=
Received: by 10.216.171.18 with SMTP id q18mr3707780wel.47.1307382686571;
        Mon, 06 Jun 2011 10:51:26 -0700 (PDT)
Received: from localhost.localdomain (abwr100.neoplus.adsl.tpnet.pl [83.8.241.100])
        by mx.google.com with ESMTPS id t79sm2440982weq.5.2011.06.06.10.51.23
        (version=SSLv3 cipher=OTHER);
        Mon, 06 Jun 2011 10:51:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175140>

This is yet a work in progress.

0. The first three patches are improvements to gitweb's INSTALL and
README files, before moving or copying most of the contents to
gitweb.txt and gitweb.conf.txt i.e. newly introduced gitweb's
manpages.

The first two were sent to git mailing list as

  [PATCH 0/2] Improving gitweb documentation
  http://thread.gmane.org/gmane.comp.version-control.git/174954

Third one was sent as reply in thread mentioned above

  [PATCH 3/2] gitweb: Move "Requirements" up in gitweb/INSTALL
  http://thread.gmane.org/gmane.comp.version-control.git/174954/focus=175016

1. The man page for /etc/gitweb.conf is modified, extended and
improved version of patch by Drew Northup from

  "[PATCH/WIP] Starting work on a man page for /etc/gitweb.conf"
  http://thread.gmane.org/gmane.comp.version-control.git/173422

Drew version was mostly pulled directly from the README and INSTALL
files of gitweb.  I have tried to incorporate comments in mentioned
thread, and to group config variables by category.

This version now moves, rather than copies, contents from
gitweb/README file.

2. The man page for gitweb is slightly extended version of patch I
have sent to git mailing list as

  "[RFC/PATCH] gitweb: Starting work on a man page for gitweb (WIP)"
  http://thread.gmane.org/gmane.comp.version-control.git/173422/focus=173625

This version now moves, rather than copies, contents from
gitweb/README and gitweb/INSTALL files.

......................................................................

The part that is left is turn references to chapters/sections into
hyperlinks, fix and unify AsciiDoc formatting (it is quite
inconsistent now), checking for leftover unintended duplication,
cleaning up gitweb/README.

NOTE also that I have only tested that both generated manpages _looks_
(halfway) reasonable.  I didn't check HTML output.


Those commits also available in 'gitweb/doc' branch in both of my
repositories:

  git://repo.or.cz/git/jnareb-git.git
  git://github.com/jnareb/git.git


Shortlog:
~~~~~~~~~
Drew Northup (1):
  gitweb: Starting work on a man page for /etc/gitweb.conf (WIP)

The one that started this.  Drew, could you comment on this thread?
Thanks in advance.

Jakub Narebski (4):
  gitweb: Move information about installation from README to INSTALL
  gitweb: Describe CSSMIN and JSMIN in gitweb/INSTALL
  gitweb: Move "Requirements" up in gitweb/INSTALL
  gitweb: Starting work on a man page for gitweb (WIP)

My contributions.

Table of contents:
~~~~~~~~~~~~~~~~~~
 [PATCHv3 1/5] gitweb: Move information about installation from
 [PATCHv3 2/5] gitweb: Describe CSSMIN and JSMIN in gitweb/INSTALL
 [PATCHv3 3/5] gitweb: Move "Requirements" up in gitweb/INSTALL
 [RFC/PATCHv3 4/5] gitweb: Starting work on a man page for /etc/gitweb.conf (WIP)
 [RFC/PATCHv3 5/5] gitweb: Starting work on a man page for gitweb (WIP)

Diffstat:
~~~~~~~~~
 Documentation/Makefile        |    9 +-
 Documentation/gitweb.conf.txt |  724 +++++++++++++++++++++++++++++++++++++++++
 Documentation/gitweb.txt      |  702 +++++++++++++++++++++++++++++++++++++++
 gitweb/INSTALL                |  246 ++++++++------
 gitweb/Makefile               |    7 +-
 gitweb/README                 |  519 +----------------------------
 6 files changed, 1599 insertions(+), 608 deletions(-)
 create mode 100644 Documentation/gitweb.conf.txt
 create mode 100644 Documentation/gitweb.txt

Dirstat:
~~~~~~~~
  62.4% Documentation/
  37.5% gitweb/
-- 
1.7.5
