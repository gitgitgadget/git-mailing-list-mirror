From: Paul Mackerras <paulus@samba.org>
Subject: New features in gitk
Date: Sun, 28 Oct 2007 12:39:34 +1100
Message-ID: <18211.59478.188419.397886@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 28 02:40:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ilx8b-00087c-3D
	for gcvg-git-2@gmane.org; Sun, 28 Oct 2007 02:40:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbXJ1Bjr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Oct 2007 21:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbXJ1Bjr
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Oct 2007 21:39:47 -0400
Received: from ozlabs.org ([203.10.76.45]:57493 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751413AbXJ1Bjq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2007 21:39:46 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id E157FDDF67; Sun, 28 Oct 2007 12:39:44 +1100 (EST)
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62519>

I just pulled the dev branch of gitk into the master branch, so the
master branch now has the new features and improvements that I have
been working on, namely:

* The find and highlight functions have been combined into a single
  function, and there is now a button for finding backwards as well as
  a find forwards button.  Thus you can now search for commits that
  modify certain files or directories, or commits that add/remove a
  given string, as well as searching for commits by commit message,
  author, committer or headline.

* Combining the find and highlight functions freed up space that is
  now used for a progress bar and a status window.

* There is now a font chooser accessible from the edit/preferences
  window.

* Gitk now uses a new graph layout algorithm, which means it doesn't
  have to generate the whole layout from top to bottom at startup
  time, making startup faster.  Gitk also uses a new style for drawing
  short diagonal line segments that join an existing vertical line,
  which is visually clearer when the segment crosses another line.

* Gitk caches the topology information used for the previous/next tag
  and branch information, making startup faster.

Tk 8.5 is now in beta, meaning that some distros now have it
packaged.  Gitk looks much nicer in Tk8.5 since it supports
anti-aliased fonts, so I strongly suggest that people install and use
Tk8.5 if possible.

Paul.
