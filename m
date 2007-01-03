From: Josef Sipek <jsipek@cs.sunysb.edu>
Subject: [ANNOUNCE] Guilt 0.15
Date: Wed, 3 Jan 2007 15:37:42 -0500
Message-ID: <20070103203742.GA29200@filer.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jan 03 21:51:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2D4w-0007WM-FL
	for gcvg-git@gmane.org; Wed, 03 Jan 2007 21:51:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbXACUvP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Jan 2007 15:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932109AbXACUvP
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jan 2007 15:51:15 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:53249 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932105AbXACUvP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jan 2007 15:51:15 -0500
X-Greylist: delayed 810 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Jan 2007 15:51:15 EST
Received: from filer.fsl.cs.sunysb.edu (IDENT:m2VLynnB/0UmaifGz9uexHauO0yiwKM1@localhost.localdomain [127.0.0.1])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l03Kbg1Q030069
	for <git@vger.kernel.org>; Wed, 3 Jan 2007 15:37:42 -0500
Received: (from jsipek@localhost)
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1/Submit) id l03Kbg1F030067
	for git@vger.kernel.org; Wed, 3 Jan 2007 15:37:42 -0500
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35891>

Guilt (Git Quilt, formerly Git Queues - gq) is a series of bash scripts
which add a Mercurial queues-like [1] functionality and interface to git.
The one distinguishing feature from other quilt-like porcelains, is the
format of the patches directory. _All_ the information is stored as plain
text - a series file and the patches (one per file). This easily lends
itself to versioning the patches using any number of of SCMs.

The scripts have changed considerably since the initial announcement two
months ago. The current scripts are much more reliable, and follow more of
the quilt/mq semantics.

Tarballs:
http://www.kernel.org/pub/linux/kernel/people/jsipek/guilt/

Git repository:
git://git.kernel.org/pub/scm/linux/kernel/git/jsipek/guilt.git


The code is licensed under GPLv2.

Of course, contributions and feedback are welcomed :)

Josef "Jeff" Sipek.

[1] http://www.selenic.com/mercurial/wiki/index.cgi/MqExtension
[2] http://marc.theaimsgroup.com/?l=git&m=116349911807684&w=2
