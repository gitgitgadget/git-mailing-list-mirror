From: Jens Bauer <jens-lists@gpio.dk>
Subject: CRLF, LF ... CR ?
Date: Thu, 13 Sep 2012 17:09:43 +0200
Message-ID: <20120913170943725232.01d717ef@gpio.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 13 17:16:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCB9g-0003g0-Vv
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 17:16:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755696Ab2IMPQ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 11:16:28 -0400
Received: from [92.246.25.51] ([92.246.25.51]:62104 "EHLO mail.multitrading.dk"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1755609Ab2IMPQ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Sep 2012 11:16:27 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Sep 2012 11:16:27 EDT
Received: (qmail 83063 invoked from network); 13 Sep 2012 15:09:44 -0000
Received: from unknown (HELO ?10.0.2.26?) (jb@multitrading.dk@92.246.25.51)
  by audiovideo.dk with ESMTPA; 13 Sep 2012 15:09:44 -0000
X-Mailer: GyazMail version 1.5.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205385>

Hi everyone.

I'm quite fond of git, and have used it for a while.
Recently, I've started making printed circuit boards (PCBs) using an application called OsmondPCB (for Mac), and I'd like to use git to track changes on these.
This application was originally written for the old Mac OS (Mac OS 6 to Mac OS 9.2).
The old Mac OS does not use LF, nor CRLF for line endings, but only CR.

I've read that git supports two different line endings; either CRLF or LF, but it does not support CR.
Would it make sense to add support for CR (if so, I hereby request it as a new feature) ?
The alternative is to ask the developer if he would change the file format, so that new versions of his software would change the files to end in LF, but he'd have to be careful not to break compatibility.
If the software is to be changed, this would not fix similar issues that other people might have.


Love
Jens
