From: Jeff Garzik <jgarzik@pobox.com>
Subject: RFE: git relink
Date: Thu, 09 Jun 2005 14:35:51 -0400
Message-ID: <42A88C07.5050907@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Jun 09 20:35:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgRpL-0003ge-TP
	for gcvg-git@gmane.org; Thu, 09 Jun 2005 20:32:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262443AbVFISgN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Jun 2005 14:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262449AbVFISgF
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jun 2005 14:36:05 -0400
Received: from mail.dvmed.net ([216.237.124.58]:28631 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262448AbVFISf4 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jun 2005 14:35:56 -0400
Received: from cpe-065-184-065-144.nc.res.rr.com ([65.184.65.144] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.51 #1 (Red Hat Linux))
	id 1DgRsg-0004pm-Lu
	for git@vger.kernel.org; Thu, 09 Jun 2005 18:35:56 +0000
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


It would be nice if somebody were motivated enough to create a command 
that functions like:

	git relink repoA repoB repoC repoD... repoX

which would examine

	repoA/.git
	repoB/.git
	repoC/.git
	repoD/.git

and verify (updating, if necessary) that each of the A/B/C/D repos are 
hardlinked to repoX.

	Jeff



