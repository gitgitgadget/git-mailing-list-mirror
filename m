From: Jeff Garzik <jeff@garzik.org>
Subject: git-clone failures abound
Date: Wed, 26 Jul 2006 00:38:46 -0400
Message-ID: <44C6F1D6.5020208@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "David S. Miller" <davem@davemloft.net>
X-From: git-owner@vger.kernel.org Wed Jul 26 06:39:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5bAl-0001zK-N5
	for gcvg-git@gmane.org; Wed, 26 Jul 2006 06:39:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030379AbWGZEiu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Jul 2006 00:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030380AbWGZEiu
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Jul 2006 00:38:50 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:61581 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030379AbWGZEiu (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Jul 2006 00:38:50 -0400
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75] helo=[10.10.10.99])
	by mail.dvmed.net with esmtpsa (Exim 4.62 #1 (Red Hat Linux))
	id 1G5bAV-0003Jz-SB; Wed, 26 Jul 2006 04:38:48 +0000
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@osdl.org>
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24205>

I've been seeing several reports lately, from different users on various 
Linux platforms, with the same basic bug report

* "git:// clone of linus's repo times out after 10 minutes"

* someone says, "use rsync:// for the initial clone"

* "it works, thanks!"

People seems to note that this behavior only started recently.  I wonder 
if linux-2.6.git crossed some sort of size threshold that's too much for 
kernel.org CPU load to bear?  I wonder if git-clone is attempting to 
delta-ify, when it really should just be sending the objects in bulk?

	Jeff
