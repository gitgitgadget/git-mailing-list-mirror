From: Bill Lear <rael@zopyra.com>
Subject: Error converting from 1.4.4.1 to 1.5.0?
Date: Wed, 14 Feb 2007 10:12:44 -0600
Message-ID: <17875.13564.622087.63653@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 14 17:13:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHMkl-0004kR-6r
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 17:13:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbXBNQMy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 11:12:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932354AbXBNQMy
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 11:12:54 -0500
Received: from mail.zopyra.com ([65.68.225.25]:61179 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932353AbXBNQMx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 11:12:53 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l1EGCpx24765;
	Wed, 14 Feb 2007 10:12:51 -0600
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39663>

I have a 1.4.4.1 repository, non-bare, cloned from my public
repository.  I just installed and am using the new 1.5.0 git.

On my master branch, I cleaned out some cvs ids in our text files and
did a git diff --- all was well.

I then did a commit, and something went wrong:

% git commit -a -m "Nuke CVS Id strings"
error: Could not read ab66b31e390889e6bcbb2002111e2803c51f42b5
error: unable to read tree object HEAD
# On branch master
error: Could not read ab66b31e390889e6bcbb2002111e2803c51f42b5
error: unable to read tree object HEAD
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       src/ledef/
nothing added to commit but untracked files present (use "git add" to track)

The "Untracked files:" part is fine, but what's up with the other
errors?

I now do a git status and it shows all of my files that I changed
as still modified, and git diff seems to show the same output.


Bill
