From: Jeff Garzik <jeff@garzik.org>
Subject: Losing branches (whee, data loss)
Date: Wed, 16 May 2007 01:18:04 -0400
Message-ID: <464A940C.3080906@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 16 07:18:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoBtt-00080K-9O
	for gcvg-git@gmane.org; Wed, 16 May 2007 07:18:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754665AbXEPFSJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 May 2007 01:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759891AbXEPFSJ
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 01:18:09 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:53417 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754665AbXEPFSI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 01:18:08 -0400
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75] helo=[10.10.10.10])
	by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1HoBtl-00062p-Sz
	for git@vger.kernel.org; Wed, 16 May 2007 05:18:06 +0000
User-Agent: Thunderbird 1.5.0.10 (X11/20070302)
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.8 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47409>

Grumble!

When all this started, the branch 'upstream-fixes' exists, and branch 
'tmp' does not exist.  This is my local clone of 
git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git


[jgarzik@pretzel libata-dev]$ git branch -m upstream-fixes tmp
error: Could not open config file!
fatal: Branch rename failed

[jgarzik@pretzel libata-dev]$ git-branch -m upstream-fixes tmp
fatal: A branch named 'tmp' already exists.

[jgarzik@pretzel libata-dev]$ git branch -D tmp
Deleted branch tmp.

[jgarzik@pretzel libata-dev]$ git-branch -m upstream-fixes tmp
error: refname refs/heads/upstream-fixes not found
fatal: Branch rename failed
