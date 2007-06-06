From: joel reed <joelwreed@gmail.com>
Subject: merging two repositories
Date: Wed, 06 Jun 2007 10:56:49 -0400
Message-ID: <4666CB31.9070007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 06 16:53:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hvwsl-0001E9-Fe
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 16:53:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbXFFOw6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 10:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbXFFOw6
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 10:52:58 -0400
Received: from ag-out-0708.google.com ([72.14.246.250]:33454 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750949AbXFFOw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 10:52:57 -0400
Received: by ag-out-0708.google.com with SMTP id 35so133998aga
        for <git@vger.kernel.org>; Wed, 06 Jun 2007 07:52:56 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=HY8IebROrluZ5x7Cam10F8DG1XXitYrFxvMgGclQC8P+LSri3L/eYTY37gqFWhMs8KqLwEzJpJycuLqKOfbzl8mCoNs32O6HCq0BsAPaaDhppCn+jl9RGTJi5+0zTFJt/E4HGdnSI1yofeopE4Tw9O889fTsq706ciTkohq9gBM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=NYB6gCkmpsssLe06ZH5VbKjziUNzwIFI1H++56Qbp177cl5QjBwmvLRu8cLssz7gN/HkMDOPsuQc2P4pxXxi3msOc1Hx5KvV6pcWZ6uLDRvolBIclWnljGpddmuJja86xKvKuYDhvQCVv2pm26yFRVRERZADPkrQVciCCklHsJ8=
Received: by 10.90.89.5 with SMTP id m5mr507802agb.1181141573849;
        Wed, 06 Jun 2007 07:52:53 -0700 (PDT)
Received: from ?172.22.50.60? ( [207.190.44.13])
        by mx.google.com with ESMTP id 10sm12455720nzo.2007.06.06.07.52.52;
        Wed, 06 Jun 2007 07:52:53 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.0 (X11/20070326)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49290>

I've been maintaining a project in git for a while and making use of 
http://repo.or.cz/w/tfs.git as a public repository. Since I also needed 
a project site, I set something up at Google Code, which of course, 
forces you to use subversion.

I added the files to subversion, checked them in, then a few weeks later 
decided I should learn how to use git-svn. So now I have two trees, one 
pure git using repo.or.cz, and the other made by git-svn against Google' 
subversion.

Is there anyway to merge these two repositories into one? I don't want 
to lose the http://repo.or.cz/w/tfs.git history, but I don't care about 
the Google subversion history.

I tried moving the .git/svn folder from the git-svn managed repository 
into the repo.or.cz .git folder, but as I expected, that didn't work. 
Life's never that easy! Anyway, if anyone knows how to merge these two 
repos, I would love to hear about it.

jr

PS. Maybe, a more generalized use case here is
  a) maintain a git tree for a while
  b) decide you have to stick code in subversion for others sometime 
later, but you still want to use git and keep your git history
