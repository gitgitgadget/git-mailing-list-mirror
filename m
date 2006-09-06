From: Jeff Garzik <jeff@garzik.org>
Subject: file rename causes history to disappear
Date: Wed, 06 Sep 2006 10:52:43 -0400
Message-ID: <44FEE0BB.2060601@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Sep 06 16:53:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKylm-0005dd-6x
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 16:52:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbWIFOwr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 10:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbWIFOwr
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 10:52:47 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:18393 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751207AbWIFOwp (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Sep 2006 10:52:45 -0400
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75] helo=[10.10.10.99])
	by mail.dvmed.net with esmtpsa (Exim 4.62 #1 (Red Hat Linux))
	id 1GKylg-0001pX-B9
	for git@vger.kernel.org; Wed, 06 Sep 2006 14:52:44 +0000
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
To: Git Mailing List <git@vger.kernel.org>
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26532>

I moved a bunch of SATA drivers in the Linux kernel from drivers/scsi to 
drivers/ata.

When I tried to look at the past history of a file using 
git-whatchanged, post-rename, it only shows the history from HEAD to the 
point of rename.  Everything prior to the rename is lost.

I also tried git-whatchanged on the old path, but that produces an error.

[jgarzik@pretzel libata-dev]$ rpm -q git-core
git-core-1.4.1-1.fc5

Repository ("upstream" branch):
git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
