From: Geert Bosch <bosch@adacore.com>
Subject: Re: RFC: New diff-delta.c implementation
Date: Sat, 22 Apr 2006 05:12:35 -0400
Message-ID: <A2284531-175D-4357-B766-B87BDB357B32@adacore.com>
References: <602974A9-09A3-46E9-92D6-D30728923C11@adacore.com> <Pine.LNX.4.64.0604212220070.22622@alien.or.mcafeemobile.com>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Apr 22 19:18:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FXLkK-0007bS-4Q
	for gcvg-git@gmane.org; Sat, 22 Apr 2006 19:18:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbWDVRSH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 22 Apr 2006 13:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbWDVRSH
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Apr 2006 13:18:07 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:25749 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1750757AbWDVRSG (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Apr 2006 13:18:06 -0400
Received: from nile.gnat.com (nile.gnat.com [205.232.38.5])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id k3M9D8me000574
	for <git@vger.kernel.org>; Sat, 22 Apr 2006 09:13:09 GMT
Received: from localhost (localhost [127.0.0.1])
	by filtered-nile.gnat.com (Postfix) with ESMTP id 434B048CEE4;
	Sat, 22 Apr 2006 05:12:36 -0400 (EDT)
Received: from nile.gnat.com ([127.0.0.1])
 by localhost (nile.gnat.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 12601-01; Sat, 22 Apr 2006 05:12:36 -0400 (EDT)
Received: from [172.16.1.2] (sdsl-216-220-103-157.dsl.bway.net [216.220.103.157])
	by nile.gnat.com (Postfix) with ESMTP id D82FB48CEDE;
	Sat, 22 Apr 2006 05:12:35 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0604212220070.22622@alien.or.mcafeemobile.com>
To: Davide Libenzi <davidel@xmailserver.org>
X-Mailer: Apple Mail (2.749.3)
X-Virus-Scanned: ClamAV 0.88/1414/Fri Apr 21 22:58:39 2006 on zeus1.kernel.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19037>


On Apr 22, 2006, at 01:21, Davide Libenzi wrote:

> Geert, the code needs some works IMO ;), but otherwise very lever  
> idea to use Rabin's polynomials and impressive results!

I'm fixing the obvious mistakes: as the code was lifted from
my stand-alone command processing a single source file, I didn't
bother freeing memory, as process exit would do that anyway.

Also, there are a few issues that cropped up as I adapted
the output from GDIFF format to the one used by GIT.
I'll post a new version when I'm done.
Please withhold further judgment until then. :)

   -Geert
