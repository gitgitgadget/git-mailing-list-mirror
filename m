From: Peter Krefting <peter@softwolves.pp.se>
Subject: Having Git follow symlinks
Date: Tue, 28 Jan 2014 14:49:57 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.02.1401281443330.17426@perkele.intern.softwolves.pp.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 28 15:12:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W89Oo-0005mL-HR
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jan 2014 15:12:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754522AbaA1OLw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jan 2014 09:11:52 -0500
Received: from cm-84.215.89.29.getinternet.no ([84.215.89.29]:47944 "EHLO
	perkele.intern.softwolves.pp.se" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754161AbaA1OLv (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jan 2014 09:11:51 -0500
X-Greylist: delayed 1311 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Jan 2014 09:11:51 EST
Received: from peter (helo=localhost)
	by perkele.intern.softwolves.pp.se with local-esmtp (Exim 4.80)
	(envelope-from <peter@softwolves.pp.se>)
	id 1W8937-0004bT-9z
	for git@vger.kernel.org; Tue, 28 Jan 2014 14:49:57 +0100
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241186>

Hi!

Is there a (per-repo) setting to get Git to follow symlinks in the 
working directory, i.e., to not store the symlinks themselves but 
rather work on what they point to?

Background: I have a repository that stores a number of my dotfiles, 
shared between all my machines (Linux, OSX, Windows/CygWin, Solaris). 
It is currently a CVS repo that I wish to convert to Git since CVS is 
getting more and more scarce. However, I have the repo set up so that 
I check it out into a subdirectory of its own, and have symlinks 
(junctions on Windows) both coming into it (for files that live in ~) 
and out of it (for subdirectories of ~ that cannot be symlinks 
themselves, such as ~/.ssh, or that live elsewhere, such as under 
AppData on Windows or ~/Library on MacOS). CVS handles this by 
simply not knowing anything about symlinks, and I would like to 
get Git to do the same.

I could probably get away with junctions on Windows and directory 
hardlinks on OSX, but that would not work on Linux.

-- 
\\// Peter - http://www.softwolves.pp.se/
