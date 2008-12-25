From: David Aguilar <davvid@gmail.com>
Subject: [ANNOUNCE] git-cola 1.3.4
Date: Thu, 25 Dec 2008 15:36:26 -0800
Message-ID: <20081225233625.GA11029@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 26 00:44:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFzs5-0003LM-2J
	for gcvg-git-2@gmane.org; Fri, 26 Dec 2008 00:44:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752088AbYLYXmS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Dec 2008 18:42:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752082AbYLYXmS
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Dec 2008 18:42:18 -0500
Received: from rv-out-0506.google.com ([209.85.198.236]:22965 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752061AbYLYXmR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Dec 2008 18:42:17 -0500
Received: by rv-out-0506.google.com with SMTP id k40so3326606rvb.1
        for <git@vger.kernel.org>; Thu, 25 Dec 2008 15:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=tSRo/OoqKWqOmT0b3c8Yso9GJBxjQmWPDUyAoWU2ufY=;
        b=Sn2gTkgTvh8DTzDD+tSh6zHF6GTVnKZvOGRACmjPhmZRk1vj5joZxiD3bSF9PBPU88
         7dKstK2BCGe+QXhEcq3GOHIatzTV0hkPS7MBSlL+U1tj4sYuOm918OxCzRPGH/poSlmW
         JOyTBBXHHyRWHjuhT38WqYcBDxvj57NMfaI08=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=xQ46dTJkpSTXU5nj9+fhtxeACD5uKRUetD8/bQQPWXkoUgfeFojSnaHX4MnYAmrpmj
         N60uPanODngUJGD9mTRJQWIVfO7q+pI9GJqKlqSK5QTlNBsh9/WH3HcBpAxqPm4qH8Bg
         f4rrTyUcc82peHnTcfQVaS+ZlZNArMTrwcqB4=
Received: by 10.140.207.2 with SMTP id e2mr5006203rvg.65.1230248534134;
        Thu, 25 Dec 2008 15:42:14 -0800 (PST)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id c20sm15286070rvf.5.2008.12.25.15.42.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Dec 2008 15:42:13 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103911>

The latest git-cola release v1.3.4 is available at the
usual places:

git-cola homepage:
	http://cola.tuxfamily.org/

git-cola on github:
	git clone git://github.com/davvid/git-cola.git 
	http://github.com/davvid/git-cola/tree/master


git-cola is a powerful git gui written in Python.
git-cola uses the PyQt4 gui toolkit and is supported on all
platforms where git is available, including Windows/msysgit.

The latest versions of git-cola sport a fresh new interface and
several new helpful dialogs.  One of the newer git-cola dialogs
is the 'Commit Comparison' dialog which allows you to compare
arbitrary commits using standard merge tools (e.g. xxdiff).

git-cola uses a custom git command called git-difftool to
drive the merge tools.  This is useful if you'd like
to use the functionality in your own scripts or from the
command line.  I will post the current version of git-difftool
to the list for feedback and possible inclusion in the
git contrib/ area since it is a generally useful utility.

See the online documentation for more information.

---------------------------------------------------------------

Changes since v1.3.3 are as follows:

Barry Roberts (3):
      Fix stash typo
      Context menu items for Commits list
      Speed up file identification

David Aguilar (15):
      i18n: fix a few more places where we weren't unicode-safe
      compare: reinstate the Commit -> Compare File... menu action
      views: fix obsolete references to the old dockwidgets
      diff gui: properly restore the scroll bar values on update
      cola: pass --no-color to 'git diff' to avoid receiving ANSI sequences
      controllers: fix a typo when restoring the scrollbar values on rescan
      options dialog: fix some annoyances with the font handling
      compare: fix an edge case when decreasing the number of log results
      Use 'utf-8' instead of 'utf8' in core.encode()
      models: call 'git update-index --refresh' in get_workdir_state()
      rebase: list all branches in the branch chooser, not just local ones
      INSTALL: remove references to the now unused 'file' command
      win32: add a win32/ folder for storing all of the win32 hacks
      INSTALL: fix a typo in the windows installation section
      remote: add a rebase checkbox to the pull dialog

-- 

	David
