From: Marco Costalba <mcostalba@yahoo.it>
Subject: [ANNOUNCE qgit-0.97]
Date: Fri, 4 Nov 2005 12:42:34 -0800 (PST)
Message-ID: <20051104204234.84044.qmail@web26307.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Fri Nov 04 21:45:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EY8Oa-0005xS-3h
	for gcvg-git@gmane.org; Fri, 04 Nov 2005 21:42:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750852AbVKDUml (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Nov 2005 15:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750853AbVKDUml
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Nov 2005 15:42:41 -0500
Received: from web26307.mail.ukl.yahoo.com ([217.146.176.18]:41879 "HELO
	web26307.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750851AbVKDUml (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2005 15:42:41 -0500
Received: (qmail 84046 invoked by uid 60001); 4 Nov 2005 20:42:34 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=hAJj5Ym4g569Eyl+pOw559coEKQXH2aP36eQ9f0H5f5gTwWkmgcrESm/Vlptcr1pBDpWGa+lppe6xKV6SAtY9jw3JEJKniGYufKK+wIiCjMDAWEfLp0rI3dptD/jwiOqeKRjRjrb/x8OQ7YVA/TRQ4h78FR2xg9Rh9gGwxSvHzc=  ;
Received: from [151.56.10.179] by web26307.mail.ukl.yahoo.com via HTTP; Fri, 04 Nov 2005 12:42:34 PST
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11156>

qgit, a git GUI viewer.

With qgit you will be able to browse revisions history, view patch content and changed 
files, graphically following different development branches.


FEATURES

 - View revisions, diffs, files history, files annotation, archive tree.

 - Commit changes visually cherry picking modified files.

 - Apply or format patch series from selected commits, drag and
   drop commits between two instances of qgit.

 - qgit implements a GUI for the most common StGIT commands like push/pop
   and apply/format patches. You can also create new patches or refresh 
   current top one using the same semantics of git commit, i.e. cherry picking
   single modified files.


NEW IN THIS RELEASE

This release is build around the wonderful new "--dense" option of git-rev-list,
i.e. git-rev-list can now filter revs according to a file list.

Because of this, makes now sense to show the archive tree and let the user to select 
files and/or directory (treeview supports multi-selection) to filter on the main view 
on the fly (by a new toolbar toggle button).

Also file history retrieving is now based on --dense option, so to let annotations be
more consistent with "legacy" file history. Because of this, annotation window gains a
graph column on file history, independent from main view, and updatable trough tree 
browsing.

Under the hood improvements to event handling and external process launching complete 
the picture.


DOWNLOAD

Download from sourceforge project page:
http://prdownloads.sourceforge.net/qgit/qgit-0.97.tar.bz2?download

There is also a git archive with the latest stuff

 QGit repository (GIT): http://digilander.libero.it/mcostalba/qgit.git

You can use 'cg-clone http://digilander.libero.it/mcostalba/qgit.git' 
to create and populate a local qgit directory.

Finally, there is a version built against Qt 3.3:
http://digilander.libero.it/mcostalba/qgit


INSTALLATION

You need scons and qt-mt developer libs, version 3.3.4 or better, already installed.

qgit is NOT compatible with Qt4.

On some platforms (Debian) you should set QTDIR before to compile.

- unpack tar file
- make
- make install

qgit will be installed in $HOME/bin


CHANGELOG

- added tree view on archive files/directories, double clicking on a file opens
  file annotation window.

- took advantage of git-rev-list "--dense" option to retrieve file history.

- added a file history graph in annotation viewer.

- took advantage of --dense option to compress revision list to show only selected
  files/directories in tree view. Tree view supports multi-selection.

- rewritten external processes launching to be more stable and fast.

- rewritten event handling to be much more clean and easy to follow. This also
  fixes some subtle bugs.



     Marco


	
		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
