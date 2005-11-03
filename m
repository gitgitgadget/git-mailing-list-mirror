From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: binary safe?
Date: 03 Nov 2005 14:02:20 -0800
Message-ID: <86br115r0z.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Nov 03 23:03:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXnAE-00013P-Bj
	for gcvg-git@gmane.org; Thu, 03 Nov 2005 23:02:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbVKCWC0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Nov 2005 17:02:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbVKCWC0
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Nov 2005 17:02:26 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:62357 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1750920AbVKCWCZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Nov 2005 17:02:25 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 12EA18F727
	for <git@vger.kernel.org>; Thu,  3 Nov 2005 14:02:21 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 20763-01-68 for <git@vger.kernel.org>;
 Thu,  3 Nov 2005 14:02:20 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id A6B428F761; Thu,  3 Nov 2005 14:02:20 -0800 (PST)
To: git@vger.kernel.org
x-mayan-date: Long count = 12.19.12.13.15; tzolkin = 12 Men; haab = 13 Zac
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11099>


I'm currently about to abandon CVS for my website management,
replacing it with git.

What problems, if any, will I have using git to manage the binary
files for my site, like the custom icons?  CVS is doing that just fine
now.

I presume emailing diff-patches is out of the question, but if all I'm
doing is git-push and git-pull (using the shared central repository
model), and if I'm stupid enough to have a merge error it's OK to just
blow up on a binary file, will everything else work fine?

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
