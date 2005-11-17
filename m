From: takis@lumumba.uhasselt.be (Panagiotis Issaris)
Subject: [BUG] git-svnimport doesn't import actual code
Date: Thu, 17 Nov 2005 17:06:45 +0100
Message-ID: <20051117160645.GA26871@lumumba.uhasselt.be>
Reply-To: takis@issaris.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Nov 17 17:17:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcmGl-000646-Lk
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 17:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbVKQQFn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 11:05:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbVKQQFn
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 11:05:43 -0500
Received: from lumumba.uhasselt.be ([193.190.9.252]:37393 "EHLO
	lumumba.uhasselt.be") by vger.kernel.org with ESMTP id S932308AbVKQQFm
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 11:05:42 -0500
Received: by lumumba.uhasselt.be (Postfix, from userid 1000)
	id 5718EEDB66; Thu, 17 Nov 2005 17:06:46 +0100 (CET)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12128>

Hi,

When importing a Subversion tree into a GIT tree using git-svnimport I
ended up with a git tree containing the number of expected commits,
complete with logmessages and timestamps, but no files showed up.
Using gitk shows me a large list of commits, but again, no diffs show
up. Using "cg-log -f" shows all the commits, but no files are shown
related to the commits.

This was the command used to import the Subversion repository:
git-svnimport -v svn://svn.berlios.de/rtnet/trunk

Here's a screenshot of gitk viewing the GIT-repository:
http://flickr.com/photos/takis/64214074/

With friendly regards,
Takis

-- 
OpenPGP key: http://issaris.org/~takis/takis_public_key.txt
fingerprint: 6571 13A3 33D9 3726 F728  AA98 F643 B12E ECF3 E029
