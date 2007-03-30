From: Timur Tabi <timur@freescale.com>
Subject: Did I miss something? git-clone doesn't grab all branches????
Date: Fri, 30 Mar 2007 10:57:34 -0500
Organization: Freescale
Message-ID: <460D336E.9040708@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 30 17:58:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXJUD-00028w-4c
	for gcvg-git@gmane.org; Fri, 30 Mar 2007 17:57:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753368AbXC3P5m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Mar 2007 11:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753521AbXC3P5m
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Mar 2007 11:57:42 -0400
Received: from de01egw01.freescale.net ([192.88.165.102]:63583 "EHLO
	de01egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753368AbXC3P5l (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2007 11:57:41 -0400
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id l2UFvYsf029575
	for <git@vger.kernel.org>; Fri, 30 Mar 2007 08:57:39 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l2UFvYQn029640
	for <git@vger.kernel.org>; Fri, 30 Mar 2007 10:57:34 -0500 (CDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.8.1.2pre) Gecko/20070111 SeaMonkey/1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I used to be able to do this:

git-clone http://ftp.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git
cd powerpc
git-checkout for-2.6.22

But that doesn't work any more.  Why not?  It was working perfectly fine before.

So someone told me I need to do this:

git-clone http://ftp.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git
cd powerpc
git-fetch http://www.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git 
for-2.6.22:for-2.6.22
git-checkout for-2.6.22

Ok, fine, but now when I do git-pull, I get this:

[snip]
* refs/remotes/origin/merge: fast forward to branch 'merge' of 
http://ftp.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc
   old..new: e0f2e3a..190a440
Warning: No merge candidate found because value of config option
          "branch.for-2.6.22.merge" does not match any remote branch fetched.
No changes.

What does the warning mean?  And why is it so difficult to clone branches now?

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
