From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [ANNOUNCE qgit-1.4]
Date: Sat, 15 Jul 2006 09:31:12 +0200
Message-ID: <e5bfff550607150031g5cca3d02h61aa6e6565aad132@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Jul 15 09:31:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G1ecQ-0001xW-Ak
	for gcvg-git@gmane.org; Sat, 15 Jul 2006 09:31:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946002AbWGOHbO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Jul 2006 03:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946004AbWGOHbO
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Jul 2006 03:31:14 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:64679 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1946003AbWGOHbN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jul 2006 03:31:13 -0400
Received: by py-out-1112.google.com with SMTP id x31so1268108pye
        for <git@vger.kernel.org>; Sat, 15 Jul 2006 00:31:12 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=RRGvoh0zXOYhBgxlHJyFxyccKaNmLTsR/0UJHuWz3ESrs2WolZsFq1VHKFQ83Cnq5wkWaqO7YD8LaOg+g4oJAJaaVAv6wCSUSm0s86Hf6a0ZeiIBB1soj4Y1hPfQRXLMmcRD7gcMC5h4T+AEYAvGMLUK0ztrnbwBtKz6Qp+M8mM=
Received: by 10.35.63.2 with SMTP id q2mr617851pyk;
        Sat, 15 Jul 2006 00:31:12 -0700 (PDT)
Received: by 10.35.52.17 with HTTP; Sat, 15 Jul 2006 00:31:12 -0700 (PDT)
To: "GIT list" <git@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23925>

This is qgit-1.4

With qgit you will be able to browse revision histories, view patch content
and changed files, graphically following different development branches.


FEATURES

 - View revisions, diffs, files history, files annotation, archive tree.

 - Commit changes visually cherry picking modified files.

 - Apply or format patch series from selected commits, drag and
   drop commits between two instances of qgit.

 - Associate commands sequences, scripts and anything else executable
   to a custom action. Actions can be run from menu and corresponding
   output is grabbed by a terminal window.

  - qgit implements a GUI for the most common StGIT commands like push/pop
   and apply/format patches. You can also create new patches or refresh
   current top one using the same semantics of git commit, i.e. cherry
   picking single modified files.


NEW IN THIS RELEASE

To let user to quickly invoke native git commands from the menu bar a
'custom action' build dialog has been added.

It is possible to associate commands sequences, scripts and anything
else executable to a custom action, give it a name and then call from
menu when needed. The corresponding output is grabbed by a terminal
window.

An action can also ask for command line arguments before to run so
to allow for maximum flexibility.

Just to name a few, I have created some stuff like 'git pull', make,
'make install', git pull with input argument and so on, and I've found
them quite useful.

There is also some work on near tag information and better tag markers,
see changelog for details.


Please note that you will need git 1.4.0 or newer.


DOWNLOAD

Tarball is
http://prdownloads.sourceforge.net/qgit/qgit-1.4.tar.bz2?download

Git archive is
git://git.kernel.org/pub/scm/qgit/qgit.git

See http://digilander.libero.it/mcostalba/ for detailed download information.


INSTALLATION

git 1.4.0 is required.

To install from tarball:

./configure
make
make install-strip

To install from git archive:

autoreconf -i
./configure
make
make install-strip

Or check the shipped README for detailed information.


CHANGELOG from 1.3

- added custom action support

- use markers for refs instead of background color in short log line

- added "Copy link sha1" context menu entry in revision description

- CTRL+right click on a revision to toggle 'diff to selected sha' mode

- added support for applying patches to working directory only

- better diagnostic when a command fails to start

- show branches that revision belongs to

- show near tags information in revision description

- show children list in revision description

- added a tool button to highlight filter matches instead of filtering

For a complete changelog see shipped ChangeLog file or git repository
revision's history

	Marco
