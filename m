From: Thomas Glanzmann <thomas@glanzmann.de>
Subject: GIT Packages for Debian Etch
Date: Mon, 18 Jun 2007 23:25:24 +0200
Message-ID: <20070618212524.GC16393@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>,
	GIT <git@vger.kernel.org>
To: carlo@alinoe.com, Linus Torvalds <torvalds@osdl.org>,
	LKML <linux-kernel@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 18 23:25:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0Oj8-00069q-MY
	for gcvg-git@gmane.org; Mon, 18 Jun 2007 23:25:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764527AbXFRVZ3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jun 2007 17:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764465AbXFRVZ2
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jun 2007 17:25:28 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:42127 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1764567AbXFRVZ1 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Jun 2007 17:25:27 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id 0AB3B3F3E2; Mon, 18 Jun 2007 23:25:25 +0200 (CEST)
Mail-Followup-To: Thomas Glanzmann <thomas@glanzmann.de>,
	carlo@alinoe.com, Linus Torvalds <torvalds@osdl.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>,
	GIT <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.15 (2007-05-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50411>

Hello,
a friend of mine always builds the Debian Packages from unstable for
Debian Etch. I have on all my machines the following line in
/etc/apt/sources.list:

        deb http://rmdir.de/~michael/git/ ./

apt-get update; apt-get dist-upgrade

and you're up2speed.

If you don't trust that packages it is very easy to build them yourself:

        wget http://ftp.debian.org/debian/pool/main/g/git-core/git-core_1.5.2.1-1.dsc
        wget http://ftp.debian.org/debian/pool/main/g/git-core/git-core_1.5.2.1.orig.tar.gz
        wget http://ftp.debian.org/debian/pool/main/g/git-core/git-core_1.5.2.1-1.diff.gz
        dpkg-source -x git-core_1.5.2.1-1.dsc
        cd git-core-1.5.2.1/
        fakeroot debian/rules binary

It runs the whole test suite and only contiues producing debs if they're good
to go. It might be possible that you have to install some build dependencies by
yourself. If some new git version hits unstable you can get the references for
the three files above from:

        http://packages.debian.org/git-core
                => unstable
                => scroll to end of page
                => Source Packages
                => Source Package: git-core, Download: [dsc] ...

        Thomas
