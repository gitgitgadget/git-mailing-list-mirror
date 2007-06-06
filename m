From: James Peach <jamespeach@mac.com>
Subject: git-svn "cannot lock ref" error during fetch
Date: Wed, 6 Jun 2007 10:17:49 -0700
Message-ID: <50C9688F-9C62-43AC-A84D-D84561671BAC@mac.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 06 19:25:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvzFs-0004i6-IK
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 19:25:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755807AbXFFRYj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 13:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756010AbXFFRYj
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 13:24:39 -0400
Received: from smtpout.mac.com ([17.250.248.172]:59428 "EHLO smtpout.mac.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755807AbXFFRYi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 13:24:38 -0400
X-Greylist: delayed 357 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Jun 2007 13:24:38 EDT
Received: from mac.com (smtpin08-en2 [10.13.10.153])
	by smtpout.mac.com (Xserve/smtpout02/MantshX 4.0) with ESMTP id l56HIfqO008998
	for <git@vger.kernel.org>; Wed, 6 Jun 2007 10:18:41 -0700 (PDT)
Received: from [17.255.104.95] ([17.255.104.95])
	(authenticated bits=0)
	by mac.com (Xserve/smtpin08/MantshX 4.0) with ESMTP id l56HHxqf003841
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Wed, 6 Jun 2007 10:18:15 -0700 (PDT)
X-Mailer: Apple Mail (2.752.3)
X-Brightmail-Tracker: AAAAAA==
X-Brightmail-scanned: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49296>

Hi all,

I'm new to git, and I'm experimenting with using git-svn to interact  
with a large SVN repository with lots of branches.

I initially did an init like this:

git-svn init -t tags -b branches -T trunk svn+ssh://server/svn/project

Then I did a git-svn fetch, which started pulling all the branches.  
After a while, however, it hit a branch that it couldn't pull:

Found branch parent: (tags/project-92~9)  
767f1f1601a4deae459c99ea6c1d1b9ba8f57a65
Following parent with do_update
...
Successfully followed parent
fatal: refs/remotes/tags/project-92~9: cannot lock the ref
update-ref -m r13726 refs/remotes/tags/project-92~9  
950638ff72acc278156a0d55baafbabb43f2b772: command returned error: 128

Some amount of searching failed to turn up any hints on what this  
error means or how I can work around it. I'd appreciate any advice ...

James
