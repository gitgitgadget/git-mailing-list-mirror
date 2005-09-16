From: Jeff Garzik <jgarzik@pobox.com>
Subject: nit: missing branch error message
Date: Fri, 16 Sep 2005 02:35:47 -0400
Message-ID: <432A67C3.2010205@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Sep 16 08:37:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EG9pR-0005Rd-An
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 08:36:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161052AbVIPGfu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 02:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161055AbVIPGfu
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 02:35:50 -0400
Received: from mail.dvmed.net ([216.237.124.58]:45532 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1161052AbVIPGfu (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Sep 2005 02:35:50 -0400
Received: from cpe-069-134-188-146.nc.res.rr.com ([69.134.188.146] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.52 #1 (Red Hat Linux))
	id 1EG9p7-0006No-Hq
	for git@vger.kernel.org; Fri, 16 Sep 2005 06:35:49 +0000
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8666>

Just tried accidentally to check out a non-existent branch:

> [jgarzik@pretzel libata-dev]$ git checkout -f upstream
> fatal: Needed a single revision

> [jgarzik@pretzel libata-dev]$ ls .git/refs/heads/
> adma      chs-support  master    pata-drivers       sil24-original  vsc-mwi
> adma-mwi  iomap        ncq       promise-sata-pata  sil-lbt
> ALL       iomap-step1  passthru  sil24              upstream-fixes

Better error message would be "hey dummy, branch doesn't exist"

	Jeff
