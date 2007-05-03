From: Thomas Glanzmann <thomas@glanzmann.de>
Subject: git-fast-export hg mutt (24M vs 184M)
Date: Thu, 3 May 2007 20:56:24 +0200
Message-ID: <20070503185623.GA11817@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 03 21:20:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hjgql-0004oQ-1l
	for gcvg-git@gmane.org; Thu, 03 May 2007 21:20:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965747AbXECTUU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 May 2007 15:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965748AbXECTUU
	(ORCPT <rfc822;git-outgoing>); Thu, 3 May 2007 15:20:20 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:63911 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965747AbXECTUT (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 May 2007 15:20:19 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id 266A13F316; Thu,  3 May 2007 20:56:24 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.14 (2007-02-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46097>

Hello,
I just tried to vendor track / import the mutt hg repository into git.
git-fast-export-hg is quiet amazing but the resulting git repository
blows up in size and I have not the slightes clue why.

        git clone git://repo.or.cz/fast-export.git
        hg clone http://dev.mutt.org/hg/mutt

Could someone have a look at this? I used Debian Etch with a git version
I build myself using an ugly script. I had to upgrade mecurial as well
because the version didn't had the cmdlog.py. I used the unstable debian
package for that.

        (thinkpad) [~/work/mutt] git-init-db
        Initialized empty Git repository in .git/
        (thinkpad) [~/work/mutt] ~/work/fast-export/hg-fast-export.sh -r /tmp/mutt

git version 1.5.2.rc0.56.g6169a

        Thomas
