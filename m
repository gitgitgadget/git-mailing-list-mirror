From: Adam Panayis <adam@movency.com>
Subject: Strange branch merging.
Date: Thu, 12 Feb 2009 11:52:51 +0000
Message-ID: <49940D93.6000204@movency.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 12 13:08:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXaN4-000665-MB
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 13:08:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756462AbZBLMHU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 07:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753608AbZBLMHT
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 07:07:19 -0500
Received: from august.movency.com ([87.194.169.126]:65496 "EHLO
	august.movency.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751060AbZBLMHS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 07:07:18 -0500
X-Greylist: delayed 861 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Feb 2009 07:07:17 EST
Received: from [192.168.1.68] (bashful.movency.com [192.168.1.68])
	(authenticated bits=0)
	by august.movency.com (8.14.2/8.13.8) with ESMTP id n1CBouOb022256
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Thu, 12 Feb 2009 11:50:57 GMT
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
X-Virus-Scanned: ClamAV 0.93.3/8981/Thu Feb 12 00:28:11 2009 on march.movency.com
X-Virus-Status: Clean
X-Spam-Status: No, score=-1.3 required=5.0 tests=ALL_TRUSTED,AWL autolearn=ham
	version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on march.movency.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109607>

Hi, I have just started using git and am having  a problem with 2 
branches appearing merged.

I have a local machine, on this I have 2 branches. The master and one 
named blah. My git repository is in the following location: /git/.git/

I have made changes to a file on the blah branch and committed these 
changes.

I checkout the master branch and as expected the changes are no longer 
there. I flip back to blah and I can see my changes. So far so good.

I then, on a remote machine use the pull command, the remote machine 
shows only the master branch as I have not asked it to pull blah. The 
command I use is as follows: git pull -v ssh://user@machine one/git/.git/

Once this is done I double check my branches and it shows I still only 
have the master. Perfect. However, when I check the file I edited on my 
local machine on the blah branch, the changes are there.

Am I fundamentally misunderstanding the correct usage of git? Is this 
result expected?

Thanks
