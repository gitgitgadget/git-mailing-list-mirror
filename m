From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: cvs2svn/cvs2git version 2.2.0 has been released
Followup-To: gmane.comp.version-control.subversion.cvs2svn.user
Date: Sun, 23 Nov 2008 10:00:18 +0100
Message-ID: <49291BA2.2050604@alum.mit.edu>
Reply-To: cvs2svn users <users@cvs2svn.tigris.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: announce@cvs2svn.tigris.org,
	Git Mailing List <git@vger.kernel.org>,
	mercurial@selenic.com, Bazaar <bazaar@lists.canonical.com>
X-From: git-owner@vger.kernel.org Sun Nov 23 10:01:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4Aqk-0002wP-46
	for gcvg-git-2@gmane.org; Sun, 23 Nov 2008 10:01:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752812AbYKWJAd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Nov 2008 04:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752828AbYKWJAd
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Nov 2008 04:00:33 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:38257 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752411AbYKWJAc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Nov 2008 04:00:32 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.129] ([77.21.84.251])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id mAN90IKM031972
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 23 Nov 2008 10:00:19 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.17) Gecko/20080925 Thunderbird/2.0.0.17 Mnenhy/0.7.5.666
X-Enigmail-Version: 0.95.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101567>

cvs2svn/cvs2git 2.2.0 has been released.

cvs2svn/cvs2git [1] is a free program that converts CVS repositories to
Subversion, git, Mercurial, or Bazaar, including all project history and
metadata.  cvs2svn can convert just about any CVS repository we've ever
seen, including gcc, Mozilla, FreeBSD, KDE, and GNOME.  Conversion to
the DVCSs is via dumping output in git-fast-import format.

cvs2svn infers what happened in the history of your CVS repository and
replicates that history as accurately as possible in the target SCM.
All revisions, branches, tags, log messages, author names, and commit
dates are converted.  cvs2svn deduces what CVS modifications were made
at the same time, and outputs these modifications grouped together as
changesets in the target SCM.  cvs2svn also deals with many CVS quirks
and is highly configurable.  See the comprehensive feature list [2].


Significant changes in release 2.2.0:

* By default, omit trivial CVS import branches from conversion.

* Allow vendor branches to be excluded (grafting child symbols to
  trunk).

* By default, don't include .cvsignore files in output (except as
  svn:ignore).

* Allow arbitrary SVN directories to be created when a project is
  created.

* cvs2git:
  - Omit the tag fixup branch if a tag can be copied from an existing
    revision.
  - Generate lightweight rather than annotated tags.

* Converting to Mercurial:
  - Add an option to set the maximum number of merge sources per commit.
    (Mercurial only allows a commit to have 0, 1, or 2 ancestors.)
  - Allow file contents to be written inline in git-fast-import streams
    (hg fast-import doesn't support predefined blobs).

* Allow the user to specify templates for cvs2svn-generated log
  messages.

* Fixed a few minor bugs.


For more information, see the latest CHANGES file [3].

You can download the new release here [4].  (Its MD5 checksum is
466b757fdef5378a46bba4ceefd047a4.)

Please send any bug reports and comments to users@cvs2svn.tigris.org.

Michael Haggerty, on behalf of the cvs2svn development team.

[1] http://cvs2svn.tigris.org
[2] http://cvs2svn.tigris.org/features.html
[3]
http://cvs2svn.tigris.org/source/browse/cvs2svn/tags/2.2.0/CHANGES?view=markup
[4]
http://cvs2svn.tigris.org/files/documents/1462/44372/cvs2svn-2.2.0.tar.gz
