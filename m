From: "Eivind LM" <eivliste@online.no>
Subject: Split a subversion repo into several git repos
Date: Thu, 11 Oct 2007 14:51:00 +0200
Message-ID: <op.tz09zaizjwclfx@ichi>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 11 15:17:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ifxus-0004gk-Mg
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 15:17:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751925AbXJKNRU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2007 09:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751851AbXJKNRU
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Oct 2007 09:17:20 -0400
Received: from mail-forward.uio.no ([129.240.10.42]:33600 "EHLO
	mail-forward.uio.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807AbXJKNRU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2007 09:17:20 -0400
X-Greylist: delayed 1560 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Oct 2007 09:17:19 EDT
Received: from mail-mx3.uio.no ([129.240.10.44])
	by pat.uio.no with esmtp (Exim 4.67)
	(envelope-from <eivliste@online.no>)
	id 1IfxVX-0001tA-1x
	for git@vger.kernel.org; Thu, 11 Oct 2007 14:51:19 +0200
Received: from cma-eivindlm.uio.no ([129.240.223.140] helo=ichi)
	by mail-mx3.uio.no with esmtp (Exim 4.67)
	(envelope-from <eivliste@online.no>)
	id 1IfxVU-0005DP-KX
	for git@vger.kernel.org; Thu, 11 Oct 2007 14:51:16 +0200
User-Agent: Opera Mail/9.23 (Linux)
X-UiO-ClamAV-Virus: No
X-UiO-Spam-info: not spam, SpamAssassin (score=-7.5, required=12.0, autolearn=disabled, AWL=2.500,UIO_CEREBRUM_EXTERN=-5,UIO_MAIL_IS_INTERNAL=-5)
X-UiO-Scanned: 85A7B7128AD5C00583C24C41902FF3709409B0E9
X-UiO-SPAM-Test: remote_host: 129.240.223.140 spam_score: -74 maxlevel 200 minaction 2 bait 0 mail/h: 2 total 12 max/h 2 blacklist 0 greylist 0 ratelimit 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60595>

Hi,
I would like to convert a subversion repository to Git. The subversion  
repository used to track development of several projects (only slightly  
related), and I would like to divide the repository into several smaller  
git repositories.

For example, I want to convert one subversion repository which contains  
the folders:
trunk/projectA
trunk/projectB

into two git repositories:
projectA.git
projectB.git

As far as I have understood, the way to do this is to
1) Convert the entire subversion repository to git with git-svn.
2) Make two copies of the whole new git-repository (projectA.git and  
projectB.git).
3) Use git-rm to remove projectB from projectA.git, and projectA from  
projectB.git.

This works fine, but both git-repositories now carries the history for  
both projects. If possible, I would like to "clean" the history in the  
repositories, so that I don't see history information for projectA when I  
am browsing logs in projectB.git. Has anyone been in the same situation?  
Do you have suggestions on how it can be solved?

Any help will be greatly appreciated.

Thanks,
Eivind
