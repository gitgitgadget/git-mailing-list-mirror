From: Jeff Garzik <jeff@garzik.org>
Subject: [BUG] Pulling tags no longer works in 1.5.3.4...
Date: Mon, 03 Dec 2007 21:00:15 -0500
Message-ID: <4754B4AF.8070408@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 04 03:00:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzN5V-0007zp-EI
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 03:00:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbXLDCAV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 21:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750955AbXLDCAV
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 21:00:21 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:60638 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750818AbXLDCAU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 21:00:20 -0500
Received: from cpe-069-134-071-233.nc.res.rr.com ([69.134.71.233] helo=core.yyz.us)
	by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1IzN59-0000dc-4T
	for git@vger.kernel.org; Tue, 04 Dec 2007 02:00:19 +0000
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
X-Spam-Score: -4.4 (----)
X-Spam-Report: SpamAssassin version 3.1.9 on srv5.dvmed.net summary:
	Content analysis details:   (-4.4 points, 5.0 required)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66991>

Using package git-core-1.5.3.3-3.fc7, I can do the following with kernel 
git trees:

1) git-clone --reference linux-2.6 linux-2.6 tmp-2.6

2) time passes (days or weeks)

3)	cd tmp-2.6
	git pull ../linux-2.6
	git pull --tags ../linux-2.6

Result:  works as expected.



Using package git-core-1.5.3.4-1.fc8, step #3 breaks:

[jgarzik@pretzel misc-2.6]$ git pull --tags ../linux-2.6/
You asked me to pull without telling me which branch you
want to merge with, and 'branch.master.merge' in
your configuration file does not tell me either.  Please
name which branch you want to merge on the command line and
try again (e.g. 'git pull <repository> <refspec>').
See git-pull(1) for details on the refspec.

If you often merge with the same branch, you may want to
configure the following variables in your configuration
file:

     branch.master.remote = <nickname>
     branch.master.merge = <remote-ref>
     remote.<nickname>.url = <url>
     remote.<nickname>.fetch = <refspec>

See git-config(1) for details.
