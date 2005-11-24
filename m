From: Andreas Ericsson <ae@op5.se>
Subject: Re: Linux 2.6.15-rc2
Date: Thu, 24 Nov 2005 14:07:08 +0100
Message-ID: <4385BAFC.7070906@op5.se>
References: <Pine.LNX.4.64.0511191934210.8552@g5.osdl.org> <200511240737.59153.tomlins@cam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 24 14:09:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfGop-0000Y0-TF
	for gcvg-git@gmane.org; Thu, 24 Nov 2005 14:07:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860AbVKXNHM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Nov 2005 08:07:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750853AbVKXNHM
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Nov 2005 08:07:12 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:31383 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1750811AbVKXNHK
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Nov 2005 08:07:10 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id CAC676BCBE; Thu, 24 Nov 2005 14:07:08 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: Ed Tomlinson <tomlins@cam.org>
In-Reply-To: <200511240737.59153.tomlins@cam.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12707>

Ed Tomlinson wrote:
> Something strange here.   After a cg-update, I had no tag for rc2.   Checking
> showed no problems so I used cg-clone to get another copy of the repository.
> Still no rc2.
> 
> ed@grover:/usr/src/2.6$ cg-version
> cogito-0.16rc2 (73874dddeec2d0a8e5cd343eec762d98314def63)
> ed@grover:/usr/src/2.6$ git --version
> git version 0.99.9.GIT
> 
> cg-clone http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git 2.6
> 

This happened a while ago to someone else too. Apparently the http 
transport needs serverside help (git-update-server-info or some such 
must be run on the remote side).

Unless you're restricted by firewalls and other you could try

git clone 
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git 2.6

which works flawlessly for me although it takes quite some time to 
transfer all the data.

Linus, HPA: Are the packs cached on kernel.org? It seems to be at least 
a minute before the transfers start.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
