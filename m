From: Geert Bosch <bosch@adacore.com>
Subject: Re: kde.git is now online
Date: Fri, 6 Apr 2007 07:32:53 -0400
Message-ID: <43336D7E-AFE7-4BAF-93C7-B302933363B5@adacore.com>
References: <46152BF5.3050502@zytor.com> <7vk5wqo6ms.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 06 13:43:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZmgw-0001fB-0I
	for gcvg-git@gmane.org; Fri, 06 Apr 2007 13:33:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752650AbXDFLc4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Apr 2007 07:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752683AbXDFLc4
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Apr 2007 07:32:56 -0400
Received: from nile.gnat.com ([205.232.38.5]:61576 "EHLO nile.gnat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752650AbXDFLcz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2007 07:32:55 -0400
Received: from localhost (localhost [127.0.0.1])
	by filtered-nile.gnat.com (Postfix) with ESMTP id 3923648CF76
	for <git@vger.kernel.org>; Fri,  6 Apr 2007 07:32:54 -0400 (EDT)
Received: from nile.gnat.com ([127.0.0.1])
 by localhost (nile.gnat.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 18516-01-10 for <git@vger.kernel.org>;
 Fri,  6 Apr 2007 07:32:54 -0400 (EDT)
Received: from [172.16.1.99] (sdsl-216-220-103-157.dsl.bway.net [216.220.103.157])
	by nile.gnat.com (Postfix) with ESMTP id B617948CDEF
	for <git@vger.kernel.org>; Fri,  6 Apr 2007 07:32:53 -0400 (EDT)
In-Reply-To: <7vk5wqo6ms.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43909>

On my Mac OS X system, cloning this fails with:

potomac:~/kde%git clone http://userweb.kernel.org/~hpa/kdegit/kde.git
Initialized empty Git repository in /Users/bosch/kde/kde/.git/
Getting alternates list for http://userweb.kernel.org/~hpa/kdegit/ 
kde.git/
Getting pack list for http://userweb.kernel.org/~hpa/kdegit/kde.git/
Getting index for pack c3df59bc67f69b3861ebef8de308156f1c5fe017
Getting pack c3df59bc67f69b3861ebef8de308156f1c5fe017
which contains ca908d2d51f154aab9f5727c1e57fb23a2942485
fatal: packfile /Users/bosch/kde/kde/.git/objects/pack/pack- 
c3df59bc67f69b3861ebef8de308156f1c5fe017.pack cannot be mapped.

Even worse, al files seem to have been deleted, so I have to
download this again. I guess, I shouldn't have used git clone...

   -Geert
