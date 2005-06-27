From: Jeff Garzik <jgarzik@pobox.com>
Subject: git-pull-branch script
Date: Mon, 27 Jun 2005 08:27:58 -0400
Message-ID: <42BFF0CE.1040209@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040105030905090805030305"
X-From: git-owner@vger.kernel.org Mon Jun 27 14:25:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DmsfT-0000hw-1o
	for gcvg-git@gmane.org; Mon, 27 Jun 2005 14:24:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbVF0M3R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Jun 2005 08:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262107AbVF0M2z
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jun 2005 08:28:55 -0400
Received: from mail.dvmed.net ([216.237.124.58]:39632 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262006AbVF0M2J (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Jun 2005 08:28:09 -0400
Received: from cpe-065-184-065-144.nc.res.rr.com ([65.184.65.144] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.51 #1 (Red Hat Linux))
	id 1DmsiV-0007RL-Sm
	for git@vger.kernel.org; Mon, 27 Jun 2005 12:28:00 +0000
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------040105030905090805030305
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


I've attached the 1-line git-pull-branch script that I just whipped 
together, in case anybody finds it useful.

On occasion, I need to pull one branch into another branch, inside the 
same repo.  For this case, the objects are already present, so we can 
skip the git-fetch-script step of git-pull-script completely.  I also 
modify the commit message so that we log the fact that we pulled a branch.



--------------040105030905090805030305
Content-Type: text/plain;
 name="git-pull-branch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="git-pull-branch"

#!/bin/sh

git-resolve-script HEAD $1 "`pwd` branch '$1'"


--------------040105030905090805030305--
