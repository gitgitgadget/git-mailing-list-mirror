From: Joe Fiorini <joe@faithfulgeek.org>
Subject: Apply patch on server w/o git
Date: Tue, 25 Mar 2008 14:25:58 -0400
Message-ID: <CA08AA77-A9EA-4490-B1BE-25E8B7402290@faithfulgeek.org>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 19:28:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeDso-0002of-Ma
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 19:28:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753017AbYCYS1p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 14:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753185AbYCYS1p
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 14:27:45 -0400
Received: from mail-out1.fuse.net ([216.68.8.175]:55530 "EHLO
	mail-out1.fuse.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750707AbYCYS1p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 14:27:45 -0400
X-CNFS-Analysis: v=1.0 c=1 a=PVXGJzZWqKX419bFDx0A:9 a=6uWNWE5YVf3_AEFYl4rO9ogkweQA:4 a=gi0PWCVxevcA:10
X-CM-Score: 0
X-Scanned-by: Cloudmark Authority Engine
Authentication-Results: gwout1 smtp.user=jfiorini@zoomtown.com; auth=pass (LOGIN)
Received: from [66.93.11.195] ([66.93.11.195:63153] helo=[192.168.1.33])
	by mail-out1.fuse.net (ecelerity 2.1.1.22 r(17669)) with ESMTPA
	id 1B/6B-08390-6B349E74 for <git@vger.kernel.org>; Tue, 25 Mar 2008 14:25:59 -0400
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78202>

I am trying to generate a diff patch on my local dev box.  I want to  
upload this patch to a server (running Windows Server 2008) and apply  
it to my staging code.  The catch is: I cannot install git on the  
server to accept the patch.  Therefore, I would like to use a generic  
patching tool (such as patch from the GnuWin32 tools).  I tried  
generating a unified diff with the following command:

git diff -U > diff.patch

and then tried to apply it using:

patch -u -i ..\other_dir\diff.patch

and I got the error:

"patch unexpectedly ends in middle of line" ... "Only garbage was  
found in the patch input"

It might be a problem with how I'm using patch, and if so, forgive  
me.  If not, then how can I generate a generic diff format from git so  
I can do what I want?

Thanks all!
Joe Fiorini
