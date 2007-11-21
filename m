From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [ANNOUNCE] git-gui 0.9.0
Date: Wed, 21 Nov 2007 02:36:45 -0500
Message-ID: <20071121073645.GV14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 21 08:37:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iuk8x-0007EE-Ac
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 08:37:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759211AbXKUHgv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Nov 2007 02:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759197AbXKUHgv
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 02:36:51 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:56460 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755913AbXKUHgt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Nov 2007 02:36:49 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Iuk8c-0006D0-7w; Wed, 21 Nov 2007 02:36:46 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6C41A20FBAE; Wed, 21 Nov 2007 02:36:45 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65611>

git-gui 0.9.0 is now available on repo.or.cz:

  gitweb:  http://repo.or.cz/w/git-gui.git
  git:     git://repo.or.cz/git-gui.git
           http://repo.or.cz/r/git-gui.git

This is the first release that includes i18n support.  I'm kicking
it out as something between a pre-release and a full release.

The English version has been quite stable and is in heavy production
use by a lot of users so I figure its time to tag it.  Some of the
non-English translations may need to be updated, but many of them
are reasonably current.  I'm inclined to do a 0.9.1 in the near
future if updated translations come in.

Many thanks to all those who have contributed to this release.

-----

Major notable improvements over the 0.8 series:

* More native appearance on Mac OS X

  git-gui now displays "Git Gui" as its application name in the
  menu bar, instead of "Wish".  It also uses Henrik Nyh's Git
  logo in the dock and error dialogs.

* Window/shortcut icon on Microsoft Windows

  The icon in the upper left corner of each window's title bar
  (and on the taskbar) is now Henrik Nyh's Git logo instead of
  the Tcl feather.

  On Windows git-gui now creates true Windows shortcuts to launch
  git-gui in a specific repository.  This allows the icon to be a
  git specific icon instead of the generic Windows batch file icon.

* Repository creation/clone UI

  Starting git-gui outside of a repository allows the user to
  create a new repository, clone an existing repository or open a
  previously accessed repository. The clone process actually uses
  a pure Tcl implementation of git-clone, based on `git init &&
  git remote add origin ... && git fetch`.

  This makes it easier to create a shortcut to launch git-gui
  from desktop menu systems, e.g. the Windows Start menu or
  the Mac OS X dock.

* i18n translations for de, hu, it, ja, ru, zh_cn

  Some of these are still under development.  Hopefully we can
  get even more translations in 0.9.1.

-----

Changes since 0.8.4:

Alex Riesen (2):
      More updates and corrections to the russian translation of git-gu=
i
      Updated russian translation of git-gui

Christian Stimming (12):
      Mark strings for translation.
      Makefile rules for translation catalog generation and installatio=
n.
      Add glossary that can be converted into a po file for each langua=
ge.
      Add glossary translation template into git.
      German translation for git-gui
      German glossary for translation
      git-gui: Add more words to translation glossary
      git-gui: Update German glossary according to mailing list discuss=
ion
      git-gui: Incorporate glossary changes into existing German transl=
ation
      git-gui: Update German translation, including latest glossary cha=
nges
      git-gui: Add more terms to glossary.
      git-gui: Update German translation

Harri Ilari Tapio Liusvaara (1):
      git-gui: Disambiguate "commit"

Irina Riesen (1):
      git-gui: initial version of russian translation

Johannes Schindelin (7):
      Add po/git-gui.pot
      Ignore po/*.msg
      git-gui: Deiconify startup wizard so it raises to the top
      git-gui: add a simple msgfmt replacement
      po2msg: ignore entries marked with "fuzzy"
      po2msg: ignore untranslated messages
      po2msg: actually output statistics

Johannes Sixt (1):
      git-gui: Change main window layout to support wider screens

Junio C Hamano (2):
      git-gui po/README: Guide to translators
      git-gui: Update Japanese strings (part 2)

Kirill (1):
      Updated Russian translation.

Michele Ballabio (4):
      git-gui: remove dots in some UI strings
      git-gui: add some strings to translation
      git-gui: fix typo in lib/blame.tcl
      git-gui: update Italian translation

Miklos Vajna (1):
      Hungarian translation of git-gui

Paolo Ciarrocchi (1):
      Italian translation of git-gui

Shawn O. Pearce (55):
      git-gui: Locate the library directory early during startup
      git-gui: Initialize Tcl's msgcat library for internationalization
      git-gui: Update po/README as symlink process is not necessary
      git-gui: Correct stock message for 'Invalid font specified in %s'
      git-gui: Quiet the msgfmt part of the make process
      git-gui: Ensure msgfmt failure stops GNU make
      git-gui: Mark revision chooser tooltip for translation
      git-gui: Localize commit/author dates when displaying them
      git-gui: Support context-sensitive i18n
      git-gui: Document the new i18n context support
      git-gui: Make the tree browser also use lightgray selection
      git-gui: Paper bag fix missing translated strings
      git-gui: Fix missing i18n markup in push/fetch windows
      git-gui: Support native Win32 Tcl/Tk under Cygwin
      git-gui: Refactor some UI init to occur earlier
      git-gui: Allow users to choose/create/clone a repository
      git-gui: Avoid console scrollbars unless they are necessary
      git-gui: Don't bother showing OS error message about hardlinks
      git-gui: Keep the UI responsive while counting objects in clone
      git-gui: Copy objects/info/alternates during standard clone
      git-gui: Don't delete console window namespaces too early
      git-gui: Don't delete scrollbars in console windows
      git-gui: Switch the git-gui logo to Henrik Nyh's logo
      git-gui: Make the status bar easier to read in the setup wizard
      git-gui: Use Henrik Nyh's git logo icon on Windows systems
      git-gui: Support a native Mac OS X application bundle
      git-gui: Refer to ourselves as "Git Gui" and not "git-gui"
      git-gui: Allow forced push into remote repository
      git-gui: Refactor Henrik Nyh's logo into its own procedure
      git-gui: Refactor about dialog code into its own module
      git-gui: Include our Git logo in the about dialog
      git-gui: Use progress meter in the status bar during index update=
s
      git-gui: Consolidate the Fetch and Push menus into a Remote menu
      git-gui: Bind Cmd-, to Preferences on Mac OS X
      git-gui: Shorten the staged/unstaged changes title bar text
      git-gui: Updated po strings based on current sources
      git-gui: Move load_config procedure below git-version selection
      git-gui: Refactor git-config --list parsing
      git-gui: Support LFs embedded in config file values
      git-gui: Change repository browser radio buttons to hyperlinks
      git-gui: Offer repository management features in menu bar
      git-gui: Fix bind errors when switching repository chooser panels
      git-gui: Disable the text widget in the repository chooser
      git-gui: Bind n/c/o accelerators in repository chooser
      git-gui: Ensure copyright message is correctly read as UTF-8
      git-gui: Use proper Windows shortcuts instead of bat files
      git-gui: Support cloning Cygwin based work-dirs
      git-gui: Collapse $env(HOME) to ~/ in recent repositories on Wind=
ows
      git-gui: Honor a config.mak in git-gui's top level
      git-gui: Paper bag fix the global config parsing
      git-gui: Make sure we get errors from git-update-index
      git-gui: Protect against bad translation strings
      git-gui: Allow users to set font weights to bold
      git-gui: Bind Meta-T for "Stage To Commit" menu action
      git-gui 0.9.0

Steffen Prohaska (4):
      git-gui: add directory git-gui is located in to PATH (on Windows)
      git-gui: set NO_MSGFMT to force using pure tcl replacement in msy=
sgit
      git-gui: add mingw specific startup wrapper
      git-gui: offer a list of recent repositories on startup

Xudong Guan (2):
      Initial Chinese translation for git-gui
      git-gui: Added initial version of po/glossary/zh_cn.po

=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93 (2):
      Japanese translation of git-gui
      git-gui: Update Japanese strings

--=20
Shawn.
