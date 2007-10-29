From: Wincent Colaiuta <win@wincent.com>
Subject: Bug in git-show with "%ai" and "%ci" formats?
Date: Mon, 29 Oct 2007 14:18:56 +0100
Message-ID: <4A647262-B69A-4DB6-942C-18C45458B169@wincent.com>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 29 14:19:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImUWP-00012p-4Z
	for gcvg-git-2@gmane.org; Mon, 29 Oct 2007 14:19:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752343AbXJ2NTA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2007 09:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751829AbXJ2NTA
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Oct 2007 09:19:00 -0400
Received: from wincent.com ([72.3.236.74]:54436 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751293AbXJ2NS7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2007 09:18:59 -0400
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l9TDIvcB029357
	for <git@vger.kernel.org>; Mon, 29 Oct 2007 08:18:58 -0500
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62616>

Can anybody reproduce the following behaviour? Basically all the  
author and committer date formats documented in the git-show man page  
work except for "%ai" and "%ci". This is with Git 1.5.2.4 running on  
Darwin 9.0.0:

$ git show -s --pretty=format:"%ad"
Sun Oct 28 20:58:39 2007 +0100
$ git show -s --pretty=format:"%aD"
Sun, 28 Oct 2007 20:58:39 +0100
$ git show -s --pretty=format:"%ar"
17 hours ago
$ git show -s --pretty=format:"%at"
1193601519
$ git show -s --pretty=format:"%ai"
%ai
$ git show -s --pretty=format:"%cd"
Sun Oct 28 20:58:39 2007 +0100
$ git show -s --pretty=format:"%cD"
Sun, 28 Oct 2007 20:58:39 +0100
$ git show -s --pretty=format:"%cr"
17 hours ago
$ git show -s --pretty=format:"%ct"
1193601519
$ git show -s --pretty=format:"%ci"
%ci

Cheers,
Wincent
