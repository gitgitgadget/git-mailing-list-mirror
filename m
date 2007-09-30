From: Wincent Colaiuta <win@wincent.com>
Subject: Obliterating a commit
Date: Sun, 30 Sep 2007 13:32:36 +0200
Message-ID: <D2BD14BD-44F2-4D01-AAEE-6CBC2A2DE85B@wincent.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 30 13:33:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ibx2l-0005e6-8A
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 13:33:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753017AbXI3Lcw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2007 07:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752536AbXI3Lcw
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Sep 2007 07:32:52 -0400
Received: from wincent.com ([72.3.236.74]:37215 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752497AbXI3Lcv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2007 07:32:51 -0400
Received: from [192.168.0.129] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l8UBWkrv027831
	for <git@vger.kernel.org>; Sun, 30 Sep 2007 06:32:49 -0500
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59534>

A couple of days ago I mistakenly checked in a file that had some  
confidential information in it. I immediately realized and amended my  
commit, and this is a local repository whose contents won't be  
visible until I push them out.

So how do I *really* get rid of the that commit before publishing? I  
couldn't find any porcelain or plumbing to do this. Do I have to  
manually destroy it? ie. wind back the HEAD, manually remove the  
commit object, the corresponding tree object, the corresponding file  
blobs, and probably manually remove the entry from the reflog as well?

Is there a "shortcut" wherein I can somehow mark this commit and its  
related tree and file blobs as unreachable, and then use git-prune to  
erradicate them?

Cheers,
Wincent
