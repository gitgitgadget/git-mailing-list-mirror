From: Johan Herland <johan@herland.net>
Subject: Refactoring the tag object; Introducing soft references (softrefs);
 Git 'notes' (take 2)
Date: Mon, 04 Jun 2007 02:51:05 +0200
Message-ID: <200706040251.05286.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 04 02:51:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hv0mx-0001g1-Ox
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 02:51:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbXFDAvK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 20:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750877AbXFDAvK
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 20:51:10 -0400
Received: from smtp.getmail.no ([84.208.20.33]:43145 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750758AbXFDAvJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 20:51:09 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJ300K016D7N900@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 04 Jun 2007 02:51:07 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJ300FXT6D51K20@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 04 Jun 2007 02:51:05 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJ300JID6D5Q010@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Mon, 04 Jun 2007 02:51:05 +0200 (CEST)
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49052>

(In response to the earlier thread on the git 'notes' feature/idea: "[PATCH 
00/15] git-note: A mechanism for providing free-form after-the-fact 
annotations on commits")

Ok, this is getting too big for me to ship all in one patch series, so I'm 
gonna have to split it up. Right now I'm thinking three patch series, but 
as I'm not near finished yet, that may change.

The three patch series I'm talking about are:

1. Refactoring the git tag object. This lays down part of the groundwork 
needed to support the second incarnation of git 'notes'. This is all ready 
to go and should follow shortly after this mail.

2. Introducing soft references (softrefs). Softrefs is the general mechanism 
behind the "reverse mapping" needed to support 'notes', as discussed in the 
previous thread. I'm still working on this patch series, and it will 
hopefully be ready soon-ish.

3. Reimplementing git 'notes' on top of (1) and (2). This should be fairly 
easy (once (2) is done), as it's mostly a matter of building a simple 
porcelain on top of (1) and (2).


Have fun!

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
