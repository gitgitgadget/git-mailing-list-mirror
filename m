From: =?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <lukass@etek.chalmers.se>
Subject: git-ls-remotes slightly broken
Date: Thu, 01 Dec 2005 23:19:22 +0100
Message-ID: <438F76EA.2030104@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	=?UTF-8?B?THVrYXMgU2FuZHN0csO2?= =?UTF-8?B?bQ==?= 
	<lukass@etek.chalmers.se>
X-From: git-owner@vger.kernel.org Thu Dec 01 23:22:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ehwlw-0006Zz-8Y
	for gcvg-git@gmane.org; Thu, 01 Dec 2005 23:19:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932527AbVLAWTV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Dec 2005 17:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932523AbVLAWTV
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Dec 2005 17:19:21 -0500
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:5271 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S932521AbVLAWTU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Dec 2005 17:19:20 -0500
Received: from [192.168.0.82] (213.66.95.18) by pne-smtpout1-sn2.hy.skanova.net (7.2.060.1)
        id 438C7D00000CDEA3; Thu, 1 Dec 2005 23:18:39 +0100
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051015)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13083>

The commit e8cc80d03934cc607e3a4d89a05350c238dbf9c5 broke git-ls-remote.

git-sh-setup is no longer included, thus I get the following error.

# cg-fetch 
Fetching pack (head and objects)...
Fetching tags...
fatal: unexpected EOF
/home/lukas/bin/git-ls-remote: line 73: die: command not found
Up to date.

/Lukas
