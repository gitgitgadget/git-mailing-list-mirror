From: Peter Karlsson <peter@softwolves.pp.se>
Subject: External diff viewer and stage/merge tool and git-gui?
Date: Tue, 3 Jun 2008 08:24:28 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0806030819310.31572@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 03 09:25:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3QtZ-0005lU-1f
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 09:25:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751516AbYFCHYc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 03:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbYFCHYc
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 03:24:32 -0400
Received: from ds9.cixit.se ([193.15.169.228]:59078 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751311AbYFCHYb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 03:24:31 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m537OT5e002396
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 3 Jun 2008 09:24:29 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m537OS34002390;
	Tue, 3 Jun 2008 09:24:28 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Tue, 03 Jun 2008 09:24:29 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83623>

Hi!

As I continue to introduce Git at my workplace, I got the question on
how to integrate external diff tools with Git. I figured out a way to
get it to work with the command-line "git-diff", by setting
GIT_EXTERNAL_DIFF and hacking together a small batch file (yeah, this
is on Windows) that opens the diff in the viewer. For myself, I would
like to use tkdiff, whereas the rest of the team is used to another
side-by-side diff viewer.

However, I cannot seem to find a way to do it from git-gui, which is
the tool I have taught the rest of the team to use as their primary
interface. Is there a way to view the currently selected difference in
an external diff viewer?


Even better would be a way to allow that external tool to edit what is
to be staged - we are having some problems with version-controlling
sources in some of Borland's tools which have the bad habit of storing
local configuration in the project files, and git-gui's "hunk" picker
cannot be used to pick the relevant changes (we have to set "show less
differences" to the lowest value to get a proper hunk view, and then
git-gui cannot stage anything).

-- 
\\// Peter - http://www.softwolves.pp.se/
