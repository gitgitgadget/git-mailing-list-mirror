From: Jeff Garzik <jeff@garzik.org>
Subject: RFE:  Fix IMAP-send TCP connect
Date: Fri, 14 Apr 2006 21:10:07 -0400
Message-ID: <444047EF.1010904@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Apr 15 03:10:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUZIq-0004tA-BY
	for gcvg-git@gmane.org; Sat, 15 Apr 2006 03:10:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbWDOBKK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Apr 2006 21:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbWDOBKK
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Apr 2006 21:10:10 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:43916 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751460AbWDOBKJ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Apr 2006 21:10:09 -0400
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75] helo=[10.10.10.99])
	by mail.dvmed.net with esmtpsa (Exim 4.60 #1 (Red Hat Linux))
	id 1FUZIe-0004Zh-1t
	for git@vger.kernel.org; Sat, 15 Apr 2006 01:10:08 +0000
User-Agent: Thunderbird 1.5 (X11/20060313)
To: Git Mailing List <git@vger.kernel.org>
X-Spam-Score: -3.9 (---)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-3.9 points, 5.0 required)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18718>


Request:  Somebody please fix imap-send.c to use git_tcp_connect() so 
that it supports IPv6 and getaddrinfo().

Bonus points for also fixing:

On Linux, daemon should use the default Linux behavior, binding to both 
IPv4 and IPv6 sockets at the same time.  git is actually doing _more 
work_ to avoid this.

	Jeff
