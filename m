From: William Morgan <wmorgan-git@masanjin.net>
Subject: [ANN] ditz 0.4 released
Date: Mon, 28 Jul 2008 13:26:38 -0700
Message-ID: <1217276766-sup-6139@entry>
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 28 23:15:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNa4A-0005CO-EL
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 23:15:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761620AbYG1VOV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 17:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761615AbYG1VOV
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 17:14:21 -0400
Received: from masanjin.net ([209.20.72.13]:59270 "EHLO entry.masanjin.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761608AbYG1VOU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 17:14:20 -0400
X-Greylist: delayed 2862 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Jul 2008 17:14:20 EDT
Received: from w by entry.masanjin.net with local (Exim 4.69)
	(envelope-from <w@masanjin.net>)
	id 1KNZIk-0008EZ-Ek
	for git@vger.kernel.org; Mon, 28 Jul 2008 13:26:38 -0700
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90506>

Ditz version 0.4 has been released! This release features improved git
integration.

http://ditz.rubyforge.org

Ditz is a simple, light-weight distributed issue tracker designed to work with
distributed version control systems like git, darcs, Mercurial, and Bazaar. It
can also be used with centralized systems like SVN.

Ditz maintains an issue database directory on disk, with files written in a
line-based and human-editable format. This directory can be kept under version
control, alongside project code.

Ditz provides a simple, console-based interface for creating and updating the
issue database file, and some rudimentary HTML generation capabilities for
producing world-readable status pages. It currently offers no central public
method of bug submission.

Synopsis:

# set up project. creates the bugs.yaml file.
1. ditz init
2. ditz add-release

# add an issue
3. ditz add

# where am i?
4. ditz status
5. ditz todo (or simply "ditz")

# do work
6. write code
7. ditz close <issue-id>
8. commit
9. goto 3

# finished!
10. ditz release <release-name>

Changes:

## 0.4 / 2008-07-27
* bugfix: HOME environment variable now correctly detected on windows
* hooks loaded from both home directory and project directory
* added bash shell completion
* plugin architecture for tighter SCM integration, etc
* 'ditz grep' should also grep against comments, log messages, etc
* added man page
* removed ditz-convert-from-monolith
* lots of HTML output tweaking
-- 
William <wmorgan-git@masanjin.net>
