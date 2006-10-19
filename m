From: Petr Baudis <pasky@suse.cz>
Subject: [ANNOUNCE] Cogito-0.18.1
Date: Thu, 19 Oct 2006 02:53:23 +0200
Message-ID: <20061019005323.GB20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 19 02:53:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaMA6-0005L6-3K
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 02:53:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945937AbWJSAx0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 20:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423207AbWJSAxZ
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 20:53:25 -0400
Received: from w241.dkm.cz ([62.24.88.241]:13539 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1423209AbWJSAxZ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Oct 2006 20:53:25 -0400
Received: (qmail 4101 invoked by uid 2001); 19 Oct 2006 02:53:23 +0200
To: git@vger.kernel.org
Content-Disposition: inline
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29311>

  Hello,

  I've released cogito-0.18.1, bringing few minor new features and
random bugfixes to the cogito-0.18 version. Nothing groundshattering.

* cg-switch -c as a shortcut for cg-switch -r HEAD - use it to create a new
  branch with less typing
* cg-patch -e to edit log message before autocommitting (useful esp. as
  cg-patch -m -e)
* Support for cg-version --lib-dir, --share-dir
* cg-admin-rewritehist now defines a map() function for filters' use,
  translating from old to new commit ids
* cg-commit -e now runs editor on /dev/tty even if input is not a tty
* Trivial documentation improvements
* Random details fixed

  Happy hacking,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
