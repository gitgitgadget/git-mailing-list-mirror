From: David Aguilar <davvid@gmail.com>
Subject: [ANNOUNCE] git-cola 1.4.1.2
Date: Thu, 31 Dec 2009 17:48:00 -0800
Message-ID: <20100101014757.GA10475@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 01 02:48:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQWd4-0000hI-1z
	for gcvg-git-2@lo.gmane.org; Fri, 01 Jan 2010 02:48:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751648Ab0AABsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Dec 2009 20:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751636Ab0AABsL
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Dec 2009 20:48:11 -0500
Received: from mail-gx0-f211.google.com ([209.85.217.211]:54739 "EHLO
	mail-gx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751531Ab0AABsK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2009 20:48:10 -0500
Received: by gxk3 with SMTP id 3so937736gxk.1
        for <git@vger.kernel.org>; Thu, 31 Dec 2009 17:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=VdzhJ6Nh2naomTgjADqheMgz7hGgJx/GeNNpLMkqKPM=;
        b=I8xoImiq7s8GAoS3u/sNgOATG3sleKmBpUIfhkcCQvYj+bQlLhZL2b58LFJjfszo0q
         VV/3ySCWYpzRwDu60yqX02klMzYk1IC7oHiM7NQyxAlFDQvxJPvNlAHL5Unnnl09+dF8
         nq/B9zvn/NoNULQvvIBiCC2++7r5YzyARzJjY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=TIGBwj2E5B/mXL78F3tX8Ht5LbHO5E+yBMf2FpduHBLFphLTssYPzTJhqZEkeBmocj
         bCgR/+eyJPclWuhP+y7JkMUVtbaR3Y5yQQ6i3iqLfzAy8S3RGfR3/G+6vrh6QycyvCzH
         tCW9TH+vzeLMnT1bLT6pYcpJ3rXcBY10fPi+Q=
Received: by 10.91.18.32 with SMTP id v32mr4550435agi.33.1262310489705;
        Thu, 31 Dec 2009 17:48:09 -0800 (PST)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 39sm6017833yxd.27.2009.12.31.17.48.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 31 Dec 2009 17:48:07 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135995>

git-cola is a powerful GUI for Git written in Python/PyQt4

git-cola v1.4.1.2 has been tagged and released:

* git clone git://github.com/davvid/git-cola.git
* http://github.com/davvid/git-cola
* http://cola.tuxfamily.org/

I haven't sent an announcement in a long time but we've
been quite busy working on enhancements nonetheless.
The release notes below summarize all changes since 1.3.8
in case you haven't kept up with the latest cola.

NYE is fast approaching here on the west coast so I've got a
party to catch.  Thus, this is the last git-cola for 2009 ;-)
Happy New Years everybody!


git-cola v1.4.1.2
=================

Usability, bells and whistles
-----------------------------
* It is now possible to checkout from the index as well
  as from `HEAD`.  This corresponds to the
  `Removed Unstaged Changes` action in the `Repository Status` tool.
* The `remote` dialogs (fetch, push, pull) are now slightly
  larger by default.
* Bookmarks can be selected when `git-cola` is run outside of a Git repository.
* Added more user documentation.  We now include many links to
  external git resources.

Fixes
-----
* Fixed a missing ``import`` when showing `right-click` actions
  for unmerged files in the `Repository Status` tool.
* ``git update-index --refresh`` is no longer run everytime
  ``git cola version`` is run.
* Don't try to watch non-existant directories when using `inotify`.

Packaging
---------
* The ``Makefile`` will now conditionally include a ``config.mak``
  file located at the root of the project.  This allows for user
  customizations such as changes to the `prefix` variable
  to be stored in a file so that custom settings do not need to
  be specified every time on the command-line.
* The build scripts no longer require a ``.git`` directory to
  generate the ``builtin_version.py`` module.  The release tarballs
  now include a ``version`` file at the root of the project which
  is used in lieu of having the Git repository available.
  This allows for ``make clean && make`` to function outside of
  a Git repository.
* Added maintainer's ``make dist`` target to the ``Makefile``.
* The built-in `simplejson` and `jsonpickle` libraries can be
  excluded from ``make install`` by specifying the ``standalone=true``
  `make` variable.  For example, ``make standalone=true install``.
  This corresponds to the ``--standalone`` option to ``setup.py``.


git-cola v1.4.1.1
=================

Usability, bells and whistles
-----------------------------
* We now use patience diff by default when it is available via
  `git diff --patience`.

* Allow closing the `cola classic` tool with `Ctrl+W`.

* Update desktop menu entry to read `Cola Git GUI`.

Fixes
-----
* Fixed an unbound variable error in the `push` dialog.

Packaging
---------
* Don't include `simplejson` in MANIFEST.in.
* Update desktop entry to read `Cola Git GUI`.


git-cola v1.4.1
===============

This feature release adds two new features directly from
`git-cola`'s github issues backlog.  On the developer
front, further work was done towards modularizing the code base.

Usability, bells and whistles
-----------------------------
* Dragging and dropping patches invokes `git-am`

  http://github.com/davvid/git-cola/issues/closed#issue/3

* A dialog to allow opening or cloning a repository
  is presented when `git-cola` is launched outside of a git repository.

  http://github.com/davvid/git-cola/issues/closed/#issue/22

* Warn when `push` is used to create a new branch

  http://github.com/davvid/git-cola/issues/closed#issue/35

* Optimized startup time by removing several calls to `git`.


Portability
-----------
* `git-cola` is once again compatible with PyQt 4.3.x.

Developer
---------
* `cola.gitcmds` was added to factor out git command-line utilities
* `cola.gitcfg` was added for interacting with `git-config`
* `cola.models.browser` was added to factor out repobrowser data
* Added more tests


git-cola v1.4.0.5
=================

Fixes
-----
* Fix launching external applications on Windows
* Ensure that the `amend` checkbox is unchecked when switching modes
* Update the status tree when amending commits


git-cola v1.4.0.4
=================

Packaging
---------
* Fix Lintian warnings


git-cola v1.4.0.3
=================

Fixes
-----
* Fix X11 warnings on application startup


git-cola v1.4.0.2
=================

Fixes
-----
* Added missing 'Exit Diff Mode' button for 'Diff Expression' mode

  http://github.com/davvid/git-cola/issues/closed/#issue/31

* Fix a bug when initializing fonts on Windows

  http://github.com/davvid/git-cola/issues/closed/#issue/32


git-cola v1.4.0.1
=================

Fixes
-----
* Keep entries in sorted order in the `cola classic` tool
* Fix staging untracked files

  http://github.com/davvid/git-cola/issues/closed/#issue/27

* Fix the `show` command in the Stash dialog

  http://github.com/davvid/git-cola/issues/closed/#issue/29

* Fix a typo when loading merge commit messages

  http://github.com/davvid/git-cola/issues/closed/#issue/30


git-cola v1.4.0
===============

This release focuses on a redesign of the git-cola user interface,
a tags interface, and better integration of the `cola classic` tool.
A flexible interface based on configurable docks is used to manage the
various cola widgets.

Usability, bells and whistles
-----------------------------
* New GUI is flexible and user-configurable
* Individual widgets can be detached and rearranged arbitrarily
* Add an interface for creating tags
* Provide a fallback `SSH_ASKPASS` implementation to prompt for
  SSH passwords on fetch/push/pull
* The commit message editor displays the current row/column and
  warns when lines get too long
* The `cola classic` tool displays upstream changes
* `git cola --classic` launches `cola classic` in standalone mode
* Provide more information in log messages

Fixes
-----
* Inherit the window manager's font settings
* Miscellaneous PyQt4 bug fixes and workarounds

Developer
---------
* Removed all usage of Qt Designer `.ui` files
* Simpler model/view architecture
* Selection is now shared across tools
* Centralized notifications are used to keep views in sync
* The `cola.git` command class was made thread-safe
* Less coupling between model and view actions
* The status view was rewritten to use the MVC architecture
* Added more documentation and tests


git-cola v1.3.9
===============

Usability, bells and whistles
-----------------------------
* Added a `cola classic` tool for browsing the entire repository
* Handle diff expressions with spaces
* Handle renamed files

Portability
-----------
* Handle carat `^` characters in diff expressions on Windows
* Worked around a PyQt 4.5/4.6 QThreadPool bug

Documentation
-------------
* Added a keyboard shortcuts reference page
* Added developer API documentation

Fixes
-----
* Fix the diff expression used when reviewing branches
* Fix a bug when pushing branches
* Fix X11 warnings at startup
* Fix more interrupted system calls on Mac OS X



-- 
		David
