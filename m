From: Seth Falcon <sethfalcon@gmail.com>
Subject: gui gui and global.excludesfile config
Date: Wed, 26 Mar 2008 07:59:45 -0700
Message-ID: <18410.25825.457498.244378@ziti.evri.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 26 16:28:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeXUL-00010T-JB
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 16:24:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753394AbYCZPXW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2008 11:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753417AbYCZPXW
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Mar 2008 11:23:22 -0400
Received: from dsl017-040-092.sea1.dsl.speakeasy.net ([69.17.40.92]:33283 "EHLO
	zimbra.evri.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753394AbYCZPXV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2008 11:23:21 -0400
X-Greylist: delayed 1333 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 Mar 2008 11:23:21 EDT
Received: from localhost (localhost [127.0.0.1])
	by zimbra.evri.com (Postfix) with ESMTP id E7B1379C02D
	for <git@vger.kernel.org>; Wed, 26 Mar 2008 08:01:00 -0700 (PDT)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: 3.844
X-Spam-Level: ***
X-Spam-Status: No, score=3.844 tagged_above=-10 required=5 tests=[AWL=0.620,
	BAYES_00=-2.599, HELO_LOCALHOST=3.941, RCVD_IN_PBL=0.905,
	RCVD_IN_SORBS_DUL=0.877, RDNS_DYNAMIC=0.1]
Received: from zimbra.evri.com ([127.0.0.1])
	by localhost (zimbra.evri.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r8ud4Ael8sKR for <git@vger.kernel.org>;
	Wed, 26 Mar 2008 08:00:54 -0700 (PDT)
Received: from localhost (c-71-197-245-84.hsd1.or.comcast.net [71.197.245.84])
	by zimbra.evri.com (Postfix) with ESMTP id 3EEBF79C02B
	for <git@vger.kernel.org>; Wed, 26 Mar 2008 08:00:54 -0700 (PDT)
X-Mailer: VM 7.19 under Emacs 22.1.91.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78285>

Hi,

I tried adding a global exclude file by adding this to my
~/.gitconfig:

[core]
	excludesfile = ~/.gitignore

The presense of this option seems to cause git gui to ignore _all_
untracked files.  For example, if ~/.gitignore is empty (or contains a
bogus ignore like foo), then git gui doesn't show any untracked files.

I'm seeing this on OS X with git version 1.5.5.rc1

+ seth

--
Seth Falcon
