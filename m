From: Benjamin Buch <benni.buch@gmx.de>
Subject: Deleted folder keeps showing up?
Date: Thu, 3 Sep 2009 18:59:18 +0200
Message-ID: <34230C98-81B8-4DC8-846F-8B6FA2A022DA@gmx.de>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 03 18:59:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjFf1-0000EB-0e
	for gcvg-git-2@lo.gmane.org; Thu, 03 Sep 2009 18:59:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756033AbZICQ7X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2009 12:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756031AbZICQ7X
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Sep 2009 12:59:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:42355 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756030AbZICQ7W (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2009 12:59:22 -0400
Received: (qmail invoked by alias); 03 Sep 2009 16:59:24 -0000
Received: from xdsl-78-34-147-22.netcologne.de (EHLO [192.168.1.100]) [78.34.147.22]
  by mail.gmx.net (mp059) with SMTP; 03 Sep 2009 18:59:24 +0200
X-Authenticated: #10686235
X-Provags-ID: V01U2FsdGVkX1/y/hI5u1fy9ty/h8fjWKSlJTDLAr+HuSrWnhKif/
	GdKC41Dg4ffdxT
X-Mailer: Apple Mail (2.930.3)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.73
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127662>

I made a branch and deleted a folder there with git rm -rf foldername.
So now i have to branches, A with the folder and B without the folder.

I'm on B, the folder is not there.
Then I check out A, the folder shows up like it should.
When I check out B again, the folder is still there.

A git rm -rf folder gives me:

	fatal: pathspec 'folder/' did not match any files

, so git is not tracking the folder.

I can rm -rf the filder without git and start the whole game from the  
beginning,
but there has to be a better way?

Strange enough this happens just to two folders I removed,
with others there is no problem.

-benjamin
  
