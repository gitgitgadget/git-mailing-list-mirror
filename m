From: Jan Wielemaker <wielemak@science.uva.nl>
Subject: git filter-branch --subdirectory-filter error
Date: Mon, 22 Oct 2007 12:27:13 +0200
Organization: HCS, University of Amsterdam
Message-ID: <200710221227.13279.wielemak@science.uva.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 22 12:33:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ijubc-0007KY-4q
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 12:33:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798AbXJVKde (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 06:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751762AbXJVKde
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 06:33:34 -0400
Received: from smtp-vbr11.xs4all.nl ([194.109.24.31]:1953 "EHLO
	smtp-vbr11.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751515AbXJVKdd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 06:33:33 -0400
Received: from gollem.science.uva.nl (gollem.science.uva.nl [146.50.26.20])
	(authenticated bits=0)
	by smtp-vbr11.xs4all.nl (8.13.8/8.13.8) with ESMTP id l9MAXVHE005577
	for <git@vger.kernel.org>; Mon, 22 Oct 2007 12:33:32 +0200 (CEST)
	(envelope-from wielemak@science.uva.nl)
User-Agent: KMail/1.9.5
Content-Disposition: inline
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61981>

Hi,

Finished a big re-shuffle of a big project, while other developers
continued. Worked really well. Thanks guys! But now I have two top
directories and I want to create two new repositories, each containing
one of these directories (because the one holds copyrighted data and we
want the other to become public software). So, I happily run

	$ git filter-branch --subdirectory-filter RDF HEAD

Where RDF is an existing directory.  I get:

Rewrite 95807fe01c39d3092e3ac3a98061711323154d77 (1/12)fatal: Not a valid 
object name 95807fe01c39d3092e3ac3a98061711323154d77:RDF
Could not initialize the index

I tried the procedure on some smaller test projects and it all worked
just fine. Running git version 1.5.3.4 on SuSE Linux. Also ran "git fsck
--full", which completed without any message.

Git show says:

gollem (eculture) 121_> git show 95807fe01c39d3092e3ac3a98061711323154d77 | 
cat
commit 95807fe01c39d3092e3ac3a98061711323154d77
Merge: 76d2935... 58afb98...
Author: Jan Wielemaker <wielemak@science.uva.nl>
Date:   Thu Oct 18 17:32:22 2007 +0200

    Merge branch 'master' of /home/eculture/eculture

Any clue?  

	Thanks --- Jan
