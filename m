From: Christian Jaeger <christian@jaeger.mine.nu>
Subject: git tag -s: TAG_EDITMSG should not be deleted upon failures
Date: Wed, 03 Dec 2008 16:53:24 +0100
Message-ID: <4936AB74.3090901@jaeger.mine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 03 16:55:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7u4B-0002kn-Lx
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 16:55:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbYLCPx2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 10:53:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbYLCPx2
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 10:53:28 -0500
Received: from ethlife-a.ethz.ch ([129.132.49.178]:36415 "HELO ethlife.ethz.ch"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751190AbYLCPx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 10:53:27 -0500
Received: (qmail 19445 invoked from network); 3 Dec 2008 15:53:24 -0000
Received: from unknown (HELO elvis-jaeger.mine.nu) (127.0.0.1)
  by localhost with SMTP; 3 Dec 2008 15:53:24 -0000
Received: (qmail 1845 invoked from network); 3 Dec 2008 15:53:24 -0000
Received: from unknown (HELO ?127.0.0.1?) (10.0.5.1)
  by elvis-jaeger.mine.nu with SMTP; 3 Dec 2008 15:53:24 -0000
User-Agent: Mozilla-Thunderbird 2.0.0.17 (X11/20081018)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102267>

Before I've now set my default signing key id in my ~/.gitconfig, I've 
run at least half a dozen times into the case where I'm running "git tag 
-s $tagname", carefully preparing a tag message, saving the file & 
exiting from the editor, only to be greeted with an error message that 
no key could be found for my (deliberately host-specific) email address, 
and my message gone. If it would keep the TAG_EDITMSG file (like git 
commit seems to be doing with COMMIT_EDITMSG anyway), I could rescue the 
message from there. I relentlessly assume that this small change would 
also make a handful of other people happier.

Christian.
