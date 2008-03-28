From: Peter Karlsson <peter@softwolves.pp.se>
Subject: PVCS (or RCS) importer for Git?
Date: Fri, 28 Mar 2008 17:17:39 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0803281713230.24460@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 28 17:19:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfHHg-0007d0-5F
	for gcvg-git-2@gmane.org; Fri, 28 Mar 2008 17:18:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753849AbYC1QRr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2008 12:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753285AbYC1QRr
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Mar 2008 12:17:47 -0400
Received: from ds9.cixit.se ([193.15.169.228]:38202 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753342AbYC1QRq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2008 12:17:46 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m2SGHewE001729
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 28 Mar 2008 17:17:40 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m2SGHdWR001724;
	Fri, 28 Mar 2008 17:17:40 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Fri, 28 Mar 2008 17:17:40 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78424>

Hi!

Has anyone written an importer to import sources stored in PVCS into
Git? Or perhaps an RCS importer that actually uses the RCS binaries
(ci, co, rlog) instead of parsing the ,v files directly?

I am looking at exporting some PVCS sources into Git, but my attempts
so far hasn't got very far, and I was thinking that maybe someone else
had done something similar?

One problem with PVCS is that it, like RCS, has file-local revision
numbering, and that it does not have named branches, the branches are
on the same file-local revisions, so there is no way of telling what a
branch is supposed to point to, except by looking at tags set to what
the branch created.

RCS is quite similar (PVCS seems to be designed to be a RCS clone), so
perhaps the problem has already been solved?


I have had some limited success by running a the pvcs2rcs.pl script
from CVS's sources and converting that to Git using cvs2svn, but I
believe the result could be better if I converted directly.

-- 
\\// Peter - http://www.softwolves.pp.se/
