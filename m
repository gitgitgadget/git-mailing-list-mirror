From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv6 0/5] Moving gitweb documentation to manpages
Date: Sun, 16 Oct 2011 13:07:30 +0200
Message-ID: <1318763255-23495-1-git-send-email-jnareb@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org, Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Sun Oct 16 13:09:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFOaX-0003kx-7R
	for gcvg-git-2@lo.gmane.org; Sun, 16 Oct 2011 13:09:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933Ab1JPLIE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Oct 2011 07:08:04 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58765 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713Ab1JPLIC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Oct 2011 07:08:02 -0400
Received: by bkbzt19 with SMTP id zt19so2273596bkb.19
        for <git@vger.kernel.org>; Sun, 16 Oct 2011 04:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=FbkxvDjYXFbwDHLpsL0yKJdQK0YAE3PlnsCEGSTqJn8=;
        b=bRxEjUtAezg69DasFU+qehyRZt5RaFBmpOFPfLtX1mX3p+nu0xkqSj+UXWOZb4ptwd
         0tdjegH9GPiVxUH8vuKG7AfmataNdTy8zNGFKX1yyFDqnGdeFbiDYwuf/ZJ1L8O6KoaZ
         QkL96uAYhw/H8z0kj8nxlVxv0pg4cFkm04E0U=
Received: by 10.223.17.3 with SMTP id q3mr17115480faa.28.1318763280438;
        Sun, 16 Oct 2011 04:08:00 -0700 (PDT)
Received: from localhost.localdomain (abrz25.neoplus.adsl.tpnet.pl. [83.8.119.25])
        by mx.google.com with ESMTPS id x22sm16468798faa.5.2011.10.16.04.07.57
        (version=SSLv3 cipher=OTHER);
        Sun, 16 Oct 2011 04:07:58 -0700 (PDT)
X-Mailer: git-send-email 1.7.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183705>

The original patch adding manpage for /etc/gitweb.conf was sent by
Drew Northup (as can be seen from shortlog); I have added manpage for
gitweb itself, inspired by his patch.  Unfortunately Drew doesn't
currently have time to work on this patch (patch series), so that is
why it is me resending this series (yet again).

The difference with previous version

  [PATCHv5/RFC 0/6] Moving gitweb documentation to manpages
  http://thread.gmane.org/gmane.comp.version-control.git/183166
  http://marc.info/?l=git&m=131809875619259&w=2

is that "Documentation: Preparation for gitweb manpages" (originally a
first patch) got removed, and two main patches got improved.  Other
patches are unchanged from previous version.


Pull request:
~~~~~~~~~~~~~
The following changes since commit 288396994f077eec7e7db0017838a5afbfbf81e3:

  Sync with maint (2011-10-15 20:59:50 -0700)

are available in the git repository at:

  git://repo.or.cz/git/jnareb-git.git gitweb/doc

Table of contents:
~~~~~~~~~~~~~~~~~~
  [PATCHv6 1/5] gitweb: Add gitweb.conf(5) manpage for gitweb
  [PATCHv6 2/5] gitweb: Add gitweb(1) manpage for gitweb itself
  [PATCHv5 3/5] Documentation: Link to gitweb(1) and gitweb.conf(5) in
    other manpages
  [PATCHv5 4/5] Documentation: Add gitweb config variables to git-config(1)
  [PATCHv5 5/5] gitweb: Add gitweb manpages to 'gitweb' package in git.spec

Shortlog:
~~~~~~~~~
Drew Northup (1):
  gitweb: Add gitweb.conf(5) manpage for gitweb configuration files

Jakub Narebski (4):
  gitweb: Add gitweb(1) manpage for gitweb itself
  Documentation: Link to gitweb(1) and gitweb.conf(5) in other manpages
  Documentation: Add gitweb config variables to git-config(1)
  gitweb: Add gitweb manpages to 'gitweb' package in git.spec

Diffstat:
~~~~~~~~~
 Documentation/Makefile         |    4 +-
 Documentation/config.txt       |   17 +
 Documentation/git-instaweb.txt |    4 +
 Documentation/gitweb.conf.txt  |  884 ++++++++++++++++++++++++++++++++++++++++
 Documentation/gitweb.txt       |  704 ++++++++++++++++++++++++++++++++
 command-list.txt               |    1 +
 git.spec.in                    |    7 +
 gitweb/INSTALL                 |   94 +----
 gitweb/README                  |  411 +------------------
 9 files changed, 1648 insertions(+), 478 deletions(-)
 create mode 100644 Documentation/gitweb.conf.txt
 create mode 100644 Documentation/gitweb.txt

-- 
1.7.6
