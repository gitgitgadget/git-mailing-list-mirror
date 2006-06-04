From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [ANNOUNCE qgit-1.3]
Date: Sun, 4 Jun 2006 10:55:09 +0200
Message-ID: <e5bfff550606040155v14565312na26f8c866f0fc32d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Jun 04 10:55:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmoOC-0004ZS-LK
	for gcvg-git@gmane.org; Sun, 04 Jun 2006 10:55:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbWFDIzM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Jun 2006 04:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbWFDIzL
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jun 2006 04:55:11 -0400
Received: from wr-out-0506.google.com ([64.233.184.239]:61545 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932206AbWFDIzK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jun 2006 04:55:10 -0400
Received: by wr-out-0506.google.com with SMTP id 69so1139506wri
        for <git@vger.kernel.org>; Sun, 04 Jun 2006 01:55:09 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=cEf37Ye5NBxAAhbnu+WYcuDVGhlRvuUfqlKQ27R7E3TY9fKvq5xlkUEjDkpDefY6woI2PNJjp/uQir/RF4GgTfbrT5IwV+XeMeqUTr2dsRprP1f76i6m7ZjGDtvAskZgcJ628c8JlRjfcmTDenqdW/J7CuVbe4A4rC4ALJdEfKY=
Received: by 10.64.150.20 with SMTP id x20mr835434qbd;
        Sun, 04 Jun 2006 01:55:09 -0700 (PDT)
Received: by 10.65.210.17 with HTTP; Sun, 4 Jun 2006 01:55:09 -0700 (PDT)
To: git@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21250>

This is qgit-1.3

With qgit you will be able to browse revisions history, view patch content
and changed files, graphically following different development branches.


FEATURES

 - View revisions, diffs, files history, files annotation, archive tree.

 - Commit changes visually cherry picking modified files.

 - Apply or format patch series from selected commits, drag and
   drop commits between two instances of qgit.

  - qgit implements a GUI for the most common StGIT commands like push/pop
   and apply/format patches. You can also create new patches or refresh
   current top one using the same semantics of git commit, i.e. cherry
   picking single modified files.


NEW IN THIS RELEASE

Main focus of this release is usability.

The big feature is the use of tabs instead of independent windows.

This change alone could be enough for a release. It's a big rewrite of UI
code to let browsing revisions and patches quicker and easier.

An whole set of key and mouse bindings has been introduced to support tab
navigation, see handbook (F1) for details.

Also changes in annotation/file viewer and StGIT integration.

Please note that you will need git 1.3.0 or newer.


DOWNLOAD

Tarball is
http://prdownloads.sourceforge.net/qgit/qgit-1.3.tar.bz2?download

Git archive is
git://git.kernel.org/pub/scm/qgit/qgit.git

See http://digilander.libero.it/mcostalba/ for detailed download information.


INSTALLATION

git 1.3.0 is required.

To install from tarball:

./configure
make
make install

To install from git archive:

autoreconf -i
./configure
make
make install

Or check the shipped README for detailed information.


CHANGELOG

from 1.3rc1 to 1.3
- added another powerful key binding to switch pages: <Alt+wheel>
- add refresh button to main toolbar
- disable back and forward buttons when not in a git archive
- patch viewer should not parse HTML
- strip debug info when installing qgit
- move 'Settings...' at the end of Edit menu
- fix code range filtering in case of multi indipendent branches
- actually support embedded Qt, make configuration code more robust
(Pavel Roskin)
- always select at first revision after opening a repository

from 1.2 to 1.3rc1
- convert UI to use tabs instead of independent windows
- use key bindings to quickly change view
- use 's' key to quickly hide/unhide secondary panes in current view
- use a standard 'find text' (CTRL+F) dialog across views
- add support for filter a given substring or regexp through patches content
- highlight matched filter patterns in diff viewer
- add up/down one revision key binding
- double clicking on file list now shows the patch
- improve file content loading time
- add support for hide/unhide annotation in file viewer
- fix 'format patch series' broken in multi revision case
- fix search for StGIT patches only under current stg branch directory
- fix don't be confused by out-of-date parent IDs of unapplied patches
(Pavel Roskin)
- fix show ref names in pop-up menu also for applied StGIT patches
- fix unable to push and pop patches if "check working dir" is enabled
- add support for finding Qt on SuSE-9.2 for x86_64 (Pavel Roskin)

For a complete changelog see shipped ChangeLog file or git repository
revision's history

	Marco
