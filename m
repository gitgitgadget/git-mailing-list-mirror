From: Bryan Larsen <bryanlarsen@yahoo.com>
Subject: [PATCH 0/6] parameterize gnu tool names; add Portfile for OS X darwinports
Date: Mon, 11 Jul 2005 06:14:25 -0400
Message-ID: <20050711101417.10318.64006.sendpatchset@bryan-larsens-ibook-g4.local>
Cc: junkio@cox.net, torvalds@osdl.org,
	Bryan Larsen <bryanlarsen@yahoo.com>, pasky@suse.cz,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 11 12:15:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DrvJF-0008UA-KP
	for gcvg-git@gmane.org; Mon, 11 Jul 2005 12:14:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261536AbVGKKO3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 06:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261584AbVGKKO3
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 06:14:29 -0400
Received: from smtp105.mail.sc5.yahoo.com ([66.163.169.225]:6798 "HELO
	smtp105.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261536AbVGKKOZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2005 06:14:25 -0400
Received: (qmail 27081 invoked from network); 11 Jul 2005 10:14:22 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:From:To:Cc:Message-Id:Subject;
  b=KvtOdCixx2LVRMdjh8NM4dFqG22KFCpUWSp9y4K9B70st3BKlfKIdRQrw1KjlKUrTLjFX+87FdOontW2VbdhENkSZ0SOubUlMZN+YCYwbF1XBmc8XjnBwrStPUQ00ojIaIgVBtNeEzzrdpvBdXjDzkmcblMQ3QVCa/qz9q22eoY=  ;
Received: from unknown (HELO bryan-larsens-ibook-g4.local) (bryanlarsen@70.26.43.137 with plain)
  by smtp105.mail.sc5.yahoo.com with SMTP; 11 Jul 2005 10:14:22 -0000
To: bryan.larsen@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Cogito and git rely on the gnu version of 4 standard utilities:  cp,
date, stat and xargs.  On most non-Linux based Unix's, the gnu tools
are optional installs, and are installed under different names.

These patches parameterize the names of these 4 tools, determine what
name should be used, and verify that the tools work.  The final patch in
the series creates a Portfile that can be used with OS X's
darwinports.

In this series, patches 3 and 5 conflict:  patch 3 is for the git
Makefile, and patch 5 is for the cogito Makefile.

Patches 1-3 should be applied to git.
Patches 1,2,4,5,6 should be applied to cogito.
