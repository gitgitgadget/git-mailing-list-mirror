From: Ray Morgan <raycmorgan@mac.com>
Subject: Removing a merge commit
Date: Wed, 10 Dec 2008 12:20:00 -0800
Message-ID: <4A07B3ED-D048-4455-B4C3-5DAB1F8E6965@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 10 22:21:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAWUo-0002DX-Du
	for gcvg-git-2@gmane.org; Wed, 10 Dec 2008 22:21:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755001AbYLJVUH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 16:20:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754170AbYLJVUH
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 16:20:07 -0500
Received: from asmtpout018.mac.com ([17.148.16.93]:41298 "EHLO
	asmtpout018.mac.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753997AbYLJVUG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 16:20:06 -0500
X-Greylist: delayed 3600 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Dec 2008 16:20:06 EST
Received: from [10.206.184.90] (lvccfg1.zappos.com [208.91.36.4])
 by asmtp018.mac.com
 (Sun Java(tm) System Messaging Server 6.3-7.03 (built Aug  7 2008; 32bit))
 with ESMTPSA id <0KBO00CNWGHCTW60@asmtp018.mac.com> for git@vger.kernel.org;
 Wed, 10 Dec 2008 12:20:06 -0800 (PST)
X-Mailer: Apple Mail (2.929.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102723>

Hello,

To build a release for our site, we merge branches that developers  
create. We do this with --no-ff in order to make it only one commit to  
pull if it fails QA. Say the qa branch's history has 4 merge commits  
in a row, is there any way to remove the 3rd (just pulling it out..  
much like how a rebase works)?

Currently we just checkout below that failed branch and re-merge  
everything above it.. but that just seems very clumsy (and manual).

Thanks!
Ray
