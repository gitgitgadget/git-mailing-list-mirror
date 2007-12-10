From: "Marcus D. Hanwell" <marcus@cryos.net>
Subject: git-svn init from Avogadro SVN repo - deleted files showing
Date: Sun, 09 Dec 2007 19:24:40 -0500
Message-ID: <475C8748.6000005@cryos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Mon Dec 10 01:47:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1Wnv-0003BD-Gy
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 01:47:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbXLJArF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2007 19:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751527AbXLJArE
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 19:47:04 -0500
Received: from client124.sevenl.net ([66.241.137.124]:55390 "EHLO
	diane.bettison.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751109AbXLJArD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2007 19:47:03 -0500
X-Greylist: delayed 1328 seconds by postgrey-1.27 at vger.kernel.org; Sun, 09 Dec 2007 19:47:03 EST
Received: from localhost (localhost [127.0.0.1])
	by diane.bettison.org (Postfix) with ESMTP id 27B8BC017E6B;
	Mon, 10 Dec 2007 00:24:52 +0000 (GMT)
X-Virus-Scanned: amavisd-new at bettison.org
Received: from diane.bettison.org ([127.0.0.1])
	by localhost (diane.bettison.org [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id VlacbNjh2FsN; Mon, 10 Dec 2007 00:24:41 +0000 (GMT)
Received: from Iridium.local (c-67-186-57-174.hsd1.pa.comcast.net [67.186.57.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by diane.bettison.org (Postfix) with ESMTP id 7025FC017E60;
	Mon, 10 Dec 2007 00:24:41 +0000 (GMT)
User-Agent: Thunderbird 2.0.0.9 (Macintosh/20071031)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67665>

Hi,

I am quite new to git and git-svn but have been using both for my 
development work recently. I imported the Avogadro subversion repository 
(hosted on Sourceforge) using the following commands,

git svn init -t tags -b branches -T trunk 
https://avogadro.svn.sourceforge.net/svnroot/avogadro

git svn fetch


The files avogadro.pro and README in the trunk/ directory appear in my 
imported git repository but not in Avogadro subversion trunk. We also 
had trunk/src/ and all its files/subdirectories appearing in the git 
checkout but not in subversion trunk. We deleted this using git and git 
svn which removed it from the git checkouts too after r858.

I have been talking to Peter who confirmed this and pointed out that the 
repo was reorganised several times in the past. Please CC me on replies 
as I am not on the list. There is a copy of my git repo at 
http://platinum.cryos.net/avogadro.git/ if you would rather skip the 
import. Other than that everything has been working great. It would be 
good to get rid of this bug if possible. Let me know if there is 
anything else I can do to help.

Thanks,

Marcus
