From: Mark Burton <markb@ordern.com>
Subject: gitk touching paths highlighting oddity
Date: Fri, 14 Nov 2008 17:51:59 +0000 (UTC)
Message-ID: <loom.20081114T173548-920@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 14 18:53:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L12rL-00022O-2o
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 18:53:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbYKNRwR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 12:52:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752042AbYKNRwR
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 12:52:17 -0500
Received: from main.gmane.org ([80.91.229.2]:55186 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750936AbYKNRwQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2008 12:52:16 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1L12q1-0007s5-38
	for git@vger.kernel.org; Fri, 14 Nov 2008 17:52:09 +0000
Received: from host86-128-20-200.range86-128.btcentralplus.com ([86.128.20.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 14 Nov 2008 17:52:09 +0000
Received: from markb by host86-128-20-200.range86-128.btcentralplus.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 14 Nov 2008 17:52:09 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 86.128.20.200 (Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.9.0.3) Gecko/2008092510 Ubuntu/8.04 (hardy) Firefox/3.0.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100993>


Hi,

Using gitk (1.6.0.4) within a given subdirectory of a working tree, I wanted to
see those commits that affected files in the current directory so I selected
touching paths" and then typed "." into the entry field (That's right isn't it?)

On pressing the Next button, not only was a relevant commit successfully found
and highlighted (commit message boldened) but all of the "." characters in the
commit message list were given a yellow background (as if I was 
searching the text for "."). Surely the yellow text highlighting shouldn't
happen when finding paths?

A quick look at the gitk code left me no wiser hence this email.

Mark
