From: Peter Krefting <peter@softwolves.pp.se>
Subject: git-gui: Warn when username and e-mail address is unconfigured?
Date: Thu, 4 Dec 2008 11:43:15 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0812041141160.9969@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 04 11:44:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8BhK-0000bM-97
	for gcvg-git-2@gmane.org; Thu, 04 Dec 2008 11:44:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756117AbYLDKnU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2008 05:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755998AbYLDKnT
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Dec 2008 05:43:19 -0500
Received: from ds9.cixit.se ([193.15.169.228]:43092 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755435AbYLDKnS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2008 05:43:18 -0500
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id mB4AhFac029730
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 4 Dec 2008 11:43:15 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id mB4AhFR1029722;
	Thu, 4 Dec 2008 11:43:15 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Thu, 04 Dec 2008 11:43:16 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102334>

Hi!

When using Git on Windows, it doesn't pick up a user name from the
environment, which leads to commits made by git gui (and probably by
git itself) to show up as being made by "unknown <username@.(none)>"
(where "username" is the Windows account name).

Is it possible to add a warning to git-gui the first time a commit is
attempted if the e-mail address is not configured, and have the user
open the configuration dialogue to set up the name properly?

-- 
\\// Peter - http://www.softwolves.pp.se/
