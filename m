From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-gui: use themed tk widgets with Tk 8.5
Date: Wed, 27 Jan 2010 18:56:47 -0800
Message-ID: <20100128025647.GB8166@spearce.org>
References: <878wbln0oa.fsf@users.sourceforge.net> <20100128005142.GK5452@spearce.org> <alpine.DEB.1.00.1001280244430.4985@pacific.mpi-cbg.de> <20100128014205.GA8166@spearce.org> <7v4om7ndm4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	git@vger.kernel.org, msysgit@googlegroups.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 28 03:57:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaKZ1-0000qA-IA
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jan 2010 03:56:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752626Ab0A1C4v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 21:56:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752021Ab0A1C4u
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 21:56:50 -0500
Received: from mail-iw0-f186.google.com ([209.85.223.186]:45589 "EHLO
	mail-iw0-f186.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751972Ab0A1C4u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2010 21:56:50 -0500
Received: by iwn16 with SMTP id 16so286054iwn.5
        for <git@vger.kernel.org>; Wed, 27 Jan 2010 18:56:49 -0800 (PST)
Received: by 10.231.145.196 with SMTP id e4mr1461741ibv.54.1264647408897;
        Wed, 27 Jan 2010 18:56:48 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 23sm434850iwn.7.2010.01.27.18.56.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Jan 2010 18:56:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7v4om7ndm4.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138222>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> >> On Wed, 27 Jan 2010, Shawn O. Pearce wrote:
> >> > Pat Thoyts <patthoyts@users.sourceforge.net> wrote:
> >> > > 
> >> > > This patch enables the use of themed Tk widgets with Tk 8.5 and above.
> > ...
> >> > Thanks.  I've been running with this pretty much all day today;
> >> > it seems sane.  I'll probably push it shortly.
> >> 
> >> Thanks.  Can you notify me when you do so?  I will merge into 4msysgit.git 
> >> directly then.
> >
> > Its already there.
> 
> Is that an insn for me to pull?

You can pull my master branch if you like; though I wouldn't suggest
it for anything other than 'next' yet:


The following changes since commit 87cd09f43e56de5235d09aef3ff5d840419fef49:
  Giuseppe Bilotta (1):
        git-gui: work from the .git dir

are available in the git repository at:

  git://git.spearce.org/git-gui.git master

Christian Stimming (1):
      git-gui: Update German translation (12 new or changed strings).

Giuseppe Bilotta (4):
      git-gui: handle non-standard worktree locations
      git-gui: handle bare repos correctly
      git-gui: update shortcut tools to use _gitworktree
      git-gui: set GIT_DIR and GIT_WORK_TREE after setup

Jeff Epler (1):
      git-gui: Support applying a range of changes at once

Jens Lehmann (2):
      git-gui: Use git diff --submodule when available
      git-gui: Add a special diff popup menu for submodules

Pat Thoyts (1):
      git-gui: use themed tk widgets with Tk 8.5

Peter Oberndorfer (1):
      git-gui: use different icon for new and modified files in the index

Shawn O. Pearce (2):
      git-gui: Remove unused icon file_parttick
      git-gui: Update translation template

 git-gui.sh                   |  397 +++++++++++++++------
 lib/about.tcl                |   37 +--
 lib/blame.tcl                |   22 +-
 lib/branch_checkout.tcl      |   20 +-
 lib/branch_create.tcl        |   45 ++--
 lib/branch_delete.tcl        |   24 +-
 lib/branch_rename.tcl        |   32 +-
 lib/browser.tcl              |   41 ++-
 lib/choose_font.tcl          |   31 +-
 lib/choose_repository.tcl    |   94 +++---
 lib/choose_rev.tcl           |   51 ++--
 lib/class.tcl                |    7 +
 lib/console.tcl              |   17 +-
 lib/database.tcl             |   20 +-
 lib/diff.tcl                 |  259 ++++++++------
 lib/error.tcl                |   15 +-
 lib/index.tcl                |   13 +-
 lib/merge.tcl                |   14 +-
 lib/option.tcl               |   67 ++--
 lib/remote_add.tcl           |   37 +-
 lib/remote_branch_delete.tcl |   51 ++--
 lib/search.tcl               |   11 +-
 lib/shortcut.tcl             |    7 +-
 lib/sshkey.tcl               |   20 +-
 lib/status_bar.tcl           |   14 +-
 lib/themed.tcl               |  174 +++++++++
 lib/tools_dlg.tcl            |   87 ++---
 lib/transport.tcl            |   48 ++--
 po/de.po                     |  824 ++++++++++++++++++++++--------------------
 po/git-gui.pot               |  584 +++++++++++++++--------------
 30 files changed, 1772 insertions(+), 1291 deletions(-)
 create mode 100644 lib/themed.tcl

-- 
Shawn.
