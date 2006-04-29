From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [ANNOUNCE] qgit-1.2
Date: Sat, 29 Apr 2006 09:54:33 +0200
Message-ID: <e5bfff550604290054m59a5b44bs4b5876ca4fee157b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Sat Apr 29 09:54:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZkHp-0004kj-TQ
	for gcvg-git@gmane.org; Sat, 29 Apr 2006 09:54:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751015AbWD2Hyf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Apr 2006 03:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751852AbWD2Hyf
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Apr 2006 03:54:35 -0400
Received: from wproxy.gmail.com ([64.233.184.224]:20183 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751046AbWD2Hye convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Apr 2006 03:54:34 -0400
Received: by wproxy.gmail.com with SMTP id i11so293026wra
        for <git@vger.kernel.org>; Sat, 29 Apr 2006 00:54:34 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=gy9VvEoxZqaAvjFO8SirWAMezXZkVFgDHbIY8XxXAYs5lTn7Cf4cy3Ba4ti9LLTuOR0jnjxRq+UhSBBH9jGpo+w3F5nZ9FzQkI/0gJAV8MqnyKjVYxXk20C6JsxrlRwpY9Xop77fL8Hykse3VT2u7KTjGdW9sWmT3FA/MIu4+Ho=
Received: by 10.65.23.20 with SMTP id a20mr895869qbj;
        Sat, 29 Apr 2006 00:54:33 -0700 (PDT)
Received: by 10.65.163.11 with HTTP; Sat, 29 Apr 2006 00:54:33 -0700 (PDT)
To: git@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19297>

This is qgit-1.2

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

A lot of work has been done from 1.1

Main new features:

*Add support for code range filtering*
To filter a mouse selected code text across all revisions file history,
this is very useful to quick search for revisions that modified a given
chunk of code.

*Much improved graph for partial repos views*
Thanks to new --boundary git-rev-list option graphs for partial repo
views are now much more clear and easy to follow.

*Support for launching an external diff viewer*
Useful, as example, to view the diffs in a 'tiled pane' mode. Default
is kompare, but it is easily user settable.

*Show stat info in patch viewer*
Use new --patch-with-stat git-diff-tree option to prepend stat info in
patch viewer.

*Adjustable font size in revision list view*
To squeeze revision graph without compromise patch and file content views.

*Key bindings for scrolling patch and revision logs*
Same keyboard navigation map of gitk. See help (F1) for details.

*Support for 'working dir' pseudo-tree in tree view*
To browse working dir changes and files in a tree like view. This is useful
for people coming from others SCM systems.

*Loading speed improvements*
Heavy optimization work to speed-up start up times, about 20%-30% from
qgit 1.1.1


NOTE: interface change.
Browsing file history revisions in annotate window does not update main view
anymore. Double click is now required to update main view. This makes qgit
less 'jumpy' and let browse file history without loosing main view selection.


Please note that you will need git 1.3.0 or newer.


DOWNLOAD

Tarball is at
http://prdownloads.sourceforge.net/qgit/qgit-1.2.tar.bz2?download

Git archive is at
http://digilander.libero.it/mcostalba/scm/qgit.git

See http://digilander.libero.it/mcostalba/ for detailed download information.


INSTALLATION

git 1.3.0 is required.

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


CHANGELOG from 1.2rc2

- do not update main view when browsing file history: double click is
now required

- show "working dir" pseudo rev also when there is no change

- add support for 'working dir' pseudo-tree in tree view

- add key bindings for scrolling patch and revision logs views

- add support for adjustable font size in revision list view

- add "revision diff" entry in context menu

- support lane mouse selection also for not free lanes

- help view should not be a top level window

- restore selection when removing code filtering

- fix a bad crash in diff viewer window

- fix a inconsistency in spinbox in annotation view

- fix an off by one bug that creates invalid pixmaps

- fix highlighting of selected revision if a reference name is used

- small GUI tweaks


For a complete changelog see shipped ChangeLog file or git repository
revision's history


	Marco
