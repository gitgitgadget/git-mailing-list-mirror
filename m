From: Peter Karlsson <peter@softwolves.pp.se>
Subject: Canonical method of merging two projects
Date: Mon, 14 Apr 2008 07:37:17 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0804140733500.7014@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 14 08:38:12 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlIKP-0001mm-2K
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 08:38:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753083AbYDNGhX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2008 02:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753196AbYDNGhX
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 02:37:23 -0400
Received: from ds9.cixit.se ([193.15.169.228]:51557 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752964AbYDNGhW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2008 02:37:22 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m3E6bIBs010007
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 14 Apr 2008 08:37:18 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m3E6bHeR010002;
	Mon, 14 Apr 2008 08:37:17 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Mon, 14 Apr 2008 08:37:18 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79463>

Hi!

What is the canonical way of merging an unrelated project into another
so that all of the merged project's files appear in a sub-directory of
the first?

I have two projects, A with files "a.txt" and "b.txt", and B with files
"a.txt" and "c.txt", each in a separate Git repoistory. I want to merge
those two projects, throwing away the B repository, and achieve a
file layout that has "a.txt" and "b.txt" from A, and "B/a.txt" and
"B/c.txt" from B. I.e, the two files with the same name are unrelated,
and all of B's file should end up in a sub-directory.

I do not want to use submodules, since I am planning on throwing B
away.


When I did this, I did a regular "git merge --no-commit", and then
moved the files manually. Thankfully, I only had one duplicated file
name, so fixing the conflict was easy enough. I looked through the
git-merge manual page, but could not find any information about this
use-case.

-- 
\\// Peter - http://www.softwolves.pp.se/
