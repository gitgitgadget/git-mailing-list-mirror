From: Peter Karlsson <peter@softwolves.pp.se>
Subject: Importing non-version controlled bits and pieces to Git
Date: Fri, 20 Jun 2008 10:42:22 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0806201036440.24013@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 20 11:43:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9d9N-0006zO-Mr
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 11:43:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751794AbYFTJm0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 05:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751821AbYFTJm0
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 05:42:26 -0400
Received: from ds9.cixit.se ([193.15.169.228]:43066 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751641AbYFTJmZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 05:42:25 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m5K9gN5e026922
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 20 Jun 2008 11:42:23 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m5K9gMGO026917;
	Fri, 20 Jun 2008 11:42:23 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Fri, 20 Jun 2008 11:42:23 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85611>

Hi!

I am looking at moving a project that has not been version-controlled
in the regular sense into Git. I have found it to currently consist of
40 directories with copies of the set of files in various shapes.

I have reconstructed something that looks like a probable revision tree
for these 40 directories, and I want to put this into Git so that I can
examine what changes have been made where, and merge the various
versions back together so that there can be one version with all the
various fixes.

I was looking for something that could do this for me, but found nothing
mentioned on the Wiki, and my Google karma was not good enough to find
something, either. The closest thing I know of is the import-tars.perl
script that I have used before, when importing something with a
(near-)linear history, but this is too far off from a linear history to
try to tar up the directories and import that way, I believe.

Has anyone written such an import tool, or should I start hacking?

-- 
\\// Peter, digital archeologist
