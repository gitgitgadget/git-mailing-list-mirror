From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [ANNOUNCE qgit-1.5]
Date: Sat, 9 Sep 2006 15:23:49 +0200
Message-ID: <e5bfff550609090623t6c51e23bh9101a5a78db9ef64@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Sep 09 15:24:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GM2ob-0003Yj-Un
	for gcvg-git@gmane.org; Sat, 09 Sep 2006 15:24:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbWIINXv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Sep 2006 09:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932171AbWIINXv
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Sep 2006 09:23:51 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:31891 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932173AbWIINXu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Sep 2006 09:23:50 -0400
Received: by py-out-1112.google.com with SMTP id n25so1301270pyg
        for <git@vger.kernel.org>; Sat, 09 Sep 2006 06:23:49 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=mykSD3js1W3H/7HRWA0kDuB4zf6KFzSZIZYk6y/zc3/ad2u394vO/SB7x8KBxgCMoFp2a+PVoy2FbtWy8A/QWqLBWApWH1ZW9y2KpE6Qt6gI9aa0O90pGw5vPTS05/ulmOWoNtm2PvFi3Bh/nQqNJnioSvvqk6ZwREKqj4JDxVc=
Received: by 10.35.115.18 with SMTP id s18mr4914712pym;
        Sat, 09 Sep 2006 06:23:49 -0700 (PDT)
Received: by 10.35.95.9 with HTTP; Sat, 9 Sep 2006 06:23:49 -0700 (PDT)
To: "Git Mailing List" <git@vger.kernel.org>,
	linux-kernel@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26747>

This is qgit-1.5

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

Multi tab support and source highlighter are the cool new features.

Multi tab allows the user to open many patch or file view tabs, each
linked on a different revision.

If GNU Source-highlight (http://www.gnu.org/software/src-highlite/) is
installed and in PATH then it is possible to toggle source code highlight
pressing the Color text tool button in file viewer. Please refer to
Source-highlight site for the list of supported languages and additional
documentation.

Some bugs squashed too. Not a lot though...qgit-1.4 has been a
very stable release ;-)

Finally, some performance tweaking.


Please note that you will need git 1.4.0 or newer.


DOWNLOAD

Tarball is
http://prdownloads.sourceforge.net/qgit/qgit-1.5.tar.bz2?download

Git archive is
git://git.kernel.org/pub/scm/qgit/qgit.git

See http://digilander.libero.it/mcostalba/ for detailed download information.


INSTALLATION

git 1.4.0 or better is required.

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


CHANGELOG from 1.4

- use GNU Source-highlight external tool with file viewer

- show file rename/copy info on patch and file list views

- show the currently checked-out head in bold font

- show stat info at the beginning of patch view also for merges

- added support for multi tab patch viewers aka 'view patch in a new tab'

- added support for multi tab file viewers aka 'view file in a new tab'

- improve size compression of revision's files saved data

- disable 'close tab' button if current tab is the main view

- replace "git-" commands with "git ". Most git commands are now built-in

- other small fixes and some performance tweaks


For a complete changelog see shipped ChangeLog file or git repository
revision's history

	Marco
