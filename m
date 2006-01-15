From: Nick Williams <njw@jarb.freeserve.co.uk>
Subject: dangling commits
Date: Sun, 15 Jan 2006 21:05:54 +0000
Message-ID: <dqebk9$75f$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Jan 15 21:41:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EyEgX-0005z8-8X
	for gcvg-git@gmane.org; Sun, 15 Jan 2006 21:41:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbWAOUlF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jan 2006 15:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbWAOUlF
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jan 2006 15:41:05 -0500
Received: from main.gmane.org ([80.91.229.2]:43931 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750729AbWAOUlE (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Jan 2006 15:41:04 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1EyEgE-0005v7-2z
	for git@vger.kernel.org; Sun, 15 Jan 2006 21:40:50 +0100
Received: from modem-2654.jaguar.dialup.pol.co.uk ([81.76.186.94])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 15 Jan 2006 21:40:50 +0100
Received: from njw by modem-2654.jaguar.dialup.pol.co.uk with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 15 Jan 2006 21:40:50 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: modem-2654.jaguar.dialup.pol.co.uk
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14707>

Hi, after cloning the git repo with

cg-clone http://www.kernel.org/pub/scm/git/git.git git

and then doing

git-fsck-objects --full

I get the following

dangling commit 42db15448ea3c21ae458d5ea873157449042c07c
dangling commit 4d04a4022e7f9f3ada3a64e2010ce65e1fcc5c64
dangling commit a773f5bda1835d739ee7209589e137ddd7199142
dangling commit ceb90a511add3b362f1384aa6ea35370d12db315

However if I do cg-clone git://git.kernel.org/pub/scm/git/git.git
there's no output from git-fsck --full

git version = 1.1.GIT
cogito version = cogito-0.17pre.GIT

did I do something wrong (again)?
