From: Anand Kumria <wildfire@progsoc.org>
Subject: When a merge turns into a conflict
Date: Thu, 6 Dec 2007 04:49:27 +0000 (UTC)
Message-ID: <pan.2007.12.06.04.49.25@progsoc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 06 05:50:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J08gV-0000Yj-GG
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 05:50:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752549AbXLFEtn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 23:49:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752534AbXLFEtn
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 23:49:43 -0500
Received: from main.gmane.org ([80.91.229.2]:35158 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752486AbXLFEtn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 23:49:43 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1J08g5-0004MI-Hv
	for git@vger.kernel.org; Thu, 06 Dec 2007 04:49:37 +0000
Received: from 82-35-82-57.cable.ubr03.dals.blueyonder.co.uk ([82.35.82.57])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 06 Dec 2007 04:49:37 +0000
Received: from wildfire by 82-35-82-57.cable.ubr03.dals.blueyonder.co.uk with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 06 Dec 2007 04:49:37 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 82-35-82-57.cable.ubr03.dals.blueyonder.co.uk
User-Agent: Pan/0.132 (Waxed in Black)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67235>


Hi,

I've just had an odd experience with git (1.5.3.1) and wondered if this 
was a known issue.

One of my co-developers has a project, with a README.txt file.  I branch 
from it and begin some edits:

	- make it more AsciiDoc like (ala git)

	- put in the README.txt a few patches that need to be applied

I had no issues 'git add' the file, and performing changes.

However when my colleague came to merge my patches in; git complained 
that the file had conflict because:

	a. it found the ========= AsciiDoc header line

	b. it found the diff markers in the file

I do not know git well enough to know if this is a heurestic that can be 
tweaked via the config file or something else. I am presently learning 
git-filter-branch so I can prepare something to show -- but I just wanted 
to flag and see if anyone else had had the same issue.

Thanks,
Anand
