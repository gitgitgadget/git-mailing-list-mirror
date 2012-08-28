From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH v7 00/16] GSOC remote-svn
Date: Tue, 28 Aug 2012 10:49:34 +0200
Message-ID: <1346143790-23491-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Joachim Schmitz <jojo@schmitz-digital.de>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 28 10:51:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6HVu-0001fe-QH
	for gcvg-git-2@plane.gmane.org; Tue, 28 Aug 2012 10:51:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375Ab2H1IuU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Aug 2012 04:50:20 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:42001 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962Ab2H1IuS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Aug 2012 04:50:18 -0400
Received: by bkwj10 with SMTP id j10so1532823bkw.19
        for <git@vger.kernel.org>; Tue, 28 Aug 2012 01:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=HmMMd4IIY+0ZZ/x/m+QWzyd3JzFTbHjHRn5DkjFrPRY=;
        b=KxsbQ5j3JIngOqhJcBmtoa0JnORq5ncTm5WCOq+r72Cqvy31Z0CTsS9McT8NEVEBvG
         JKlMuxCvdSxZ8IFBJL88sOnevyijw6UaIraHCFTOswNT48ZYbS4pBR8aWlaCy8UyYmmN
         fB79XPKfuUBT/95dVkTE3W8OHXUx6Hd9eMYcuLaMf/3qG4kRRZMLTXjNSriyW7MY4pu2
         jB0LR3fSwJUumVSPauLw/RimvFQUi+WIMjtulwr8NHhyo8MyzvYRWYlvw1+RQbKhNScl
         7T6kaiz9hhhVuXH2hvW+YnWeawzdkboAZ6MQwxp0AHZZPDirLh8EVfQoN2WUgbOPIr63
         UjSA==
Received: by 10.204.157.10 with SMTP id z10mr4715009bkw.63.1346143817133;
        Tue, 28 Aug 2012 01:50:17 -0700 (PDT)
Received: from flobuntu.lan (91-115-85-203.adsl.highway.telekom.at. [91.115.85.203])
        by mx.google.com with ESMTPS id m9sm12047800bkm.10.2012.08.28.01.50.11
        (version=SSLv3 cipher=OTHER);
        Tue, 28 Aug 2012 01:50:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204401>

Reroll includes fixups by Ramsey. Thanks!
Diff:
- Add missing dependency to rule in Makefile.
- improve compatibility of integer types.
- t9020-*.sh: remove excess slash in urls that makes python on windows 
  interpret it as a network path.
- t9020-*.sh: skip if python isn't available.
- replace getline() in remote-testsvn.c. There are platforms that don't provide
  this function.

[PATCH v7 01/16] Implement a remote helper for svn in C
[PATCH v7 02/16] Add git-remote-testsvn to Makefile
[PATCH v7 03/16] Add svndump_init_fd to allow reading dumps from
[PATCH v7 04/16] Add argv_array_detach and argv_array_free_detached
[PATCH v7 05/16] Connect fast-import to the remote-helper via pipe,
[PATCH v7 06/16] Add documentation for the 'bidi-import' capability
[PATCH v7 07/16] When debug==1, start fast-import with "--stats"
[PATCH v7 08/16] remote-svn, vcs-svn: Enable fetching to private
[PATCH v7 09/16] Allow reading svn dumps from files via file:// urls
[PATCH v7 10/16] vcs-svn: add fast_export_note to create notes
[PATCH v7 11/16] Create a note for every imported commit containing
[PATCH v7 12/16] remote-svn: Activate import/export-marks for
[PATCH v7 13/16] remote-svn: add incremental import
[PATCH v7 14/16] Add a svnrdump-simulator replaying a dump file for
[PATCH v7 15/16] remote-svn: add marks-file regeneration
[PATCH v7 16/16] Add a test script for remote-svn
