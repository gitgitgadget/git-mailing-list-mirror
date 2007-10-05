From: Jan Wielemaker <wielemak@science.uva.nl>
Subject: git-cvsserver (absent) interaction with --shared=
Date: Fri, 5 Oct 2007 12:08:35 +0200
Organization: HCS, University of Amsterdam
Message-ID: <200710051208.35358.wielemak@science.uva.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 05 12:14:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdkCV-0001sG-4j
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 12:14:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751533AbXJEKOW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 06:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751524AbXJEKOW
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 06:14:22 -0400
Received: from imap.science.uva.nl ([146.50.4.51]:53108 "EHLO
	imap.science.uva.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751348AbXJEKOV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 06:14:21 -0400
Received: from gollem.science.uva.nl [146.50.26.20]
          by imap.science.uva.nl with ESMTP (sendmail 8.13.8/config 11.38).
          id l95AEJtR025868; Fri, 5 Oct 2007 12:14:19 +0200
X-Organisation: Faculty of Science, University of Amsterdam, The Netherlands
X-URL: http://www.science.uva.nl/
User-Agent: KMail/1.9.5
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60064>

Hi,

Before I forget. The notion of --shared=all/group is very useful for
avoiding permission issues in git. GIT repos used for CVS will often be
shared. Unfortunately git-cvsserver doesn't make the SQLite databases
group-writable if core.sharedrepository = 1.

	--- Jan
