From: Peter Karlsson <peter@softwolves.pp.se>
Subject: Merge problems with git-mingw
Date: Mon, 8 Oct 2007 12:06:42 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0710081203020.29715@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 08 13:19:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeqeH-0003Fr-LO
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 13:19:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753617AbXJHLTd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2007 07:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753663AbXJHLTc
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Oct 2007 07:19:32 -0400
Received: from ds9.cixit.se ([193.15.169.228]:54741 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753617AbXJHLTb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2007 07:19:31 -0400
X-Greylist: delayed 767 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Oct 2007 07:19:31 EDT
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id l98B6hnQ001197
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 8 Oct 2007 13:06:43 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id l98B6gvs001189;
	Mon, 8 Oct 2007 13:06:42 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Mon, 08 Oct 2007 13:06:43 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60312>

Hi!

I am running the mingw port of Git from a Cygwin environment, because I
had problems with the Cygwin version (not sure what the problem was,
probably a CRLF issue). Everything works fine, except for merging:

  $ git merge master
  usage: git-var [-l | <variable>]
  $

Does anyone have any idea on what could cause that? (I've checked that
git-var is indeed the mingw version and not the Cygwin version).

  $ git --version
  git version 1.5.3.mingw.1

I'm running on top of another version control system, so I need to
switch back to master and update the sources from upstream using that
system's tools, and then merge it back into my branch. Without "git
merge" working, that is a bit problematic, to say the least... :-)

-- 
\\// Peter - http://www.softwolves.pp.se/
