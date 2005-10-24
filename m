From: Jeff Garzik <jgarzik@pobox.com>
Subject: RFE: git rm
Date: Mon, 24 Oct 2005 15:02:56 -0400
Message-ID: <435D2FE0.3060307@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Oct 24 21:05:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EU7b5-00059X-5I
	for gcvg-git@gmane.org; Mon, 24 Oct 2005 21:03:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750928AbVJXTDA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Oct 2005 15:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750945AbVJXTDA
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Oct 2005 15:03:00 -0400
Received: from mail.dvmed.net ([216.237.124.58]:40138 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750928AbVJXTC7 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Oct 2005 15:02:59 -0400
Received: from cpe-069-134-188-146.nc.res.rr.com ([69.134.188.146] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.52 #1 (Red Hat Linux))
	id 1EU7b0-0001RZ-TE
	for git@vger.kernel.org; Mon, 24 Oct 2005 19:02:59 +0000
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10555>


It would be nice to say "git rm files..." and have two operations occur:

* list of files is passed to rm(1)
* list of files is passed to git-update-index --remove
