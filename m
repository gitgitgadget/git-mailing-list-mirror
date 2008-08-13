From: Jan Wielemaker <J.Wielemaker@uva.nl>
Subject: [BUG] Path issue in git-csvserver
Date: Wed, 13 Aug 2008 10:36:04 +0200
Organization: HCS, University of Amsterdam
Message-ID: <200808131036.04620.J.Wielemaker@uva.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 13 10:38:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTBrv-0006q2-EJ
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 10:38:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754436AbYHMIhD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 04:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755332AbYHMIhB
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 04:37:01 -0400
Received: from korteweg.uva.nl ([146.50.98.70]:25794 "EHLO korteweg.uva.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755261AbYHMIhA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 04:37:00 -0400
Received: from gollem.science.uva.nl ([146.50.26.20]) by korteweg.uva.nl with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 13 Aug 2008 10:36:58 +0200
User-Agent: KMail/1.9.9
Content-Disposition: inline
X-OriginalArrivalTime: 13 Aug 2008 08:36:58.0904 (UTC) FILETIME=[C01DA180:01C8FD1F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92192>

Hi,

Using GIT installed with prefix=/usr/local I get this using anonymous
cvs access:

cvs checkout: warning: unrecognized response `Can't exec "git": No such file 
or directory at /usr/local/libexec/git-core/git-cvsserver line 2895, <STDIN> 
line 19.' from cvs server

I had similar issues before (reported a few days ago) which could be
`fixed' by including /usr/local/bin in $PATH in the xinetd config file for
this server. Somehow that doesn't appear to work here.  I hacked around
by making a link from /usr/local/libexec/git-core/git to /usr/local/bin/git.

	Cheers --- Jan
