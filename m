From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [howto] Kernel hacker's guide to git, updated
Date: Fri, 30 Sep 2005 10:08:49 -0400
Message-ID: <433D46F1.9010209@pobox.com>
References: <433BC9E9.6050907@pobox.com> <20050929200252.GA31516@redhat.com> <433C4B6D.6030701@pobox.com> <7virwjegb5.fsf@assigned-by-dhcp.cox.net> <433D1E5D.20303@pobox.com> <20050930120739.GB9328@harddisk-recovery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030313AbVI3OI5@vger.kernel.org Fri Sep 30 16:11:01 2005
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030313AbVI3OI5@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ELLZs-0004tN-2S
	for glk-linux-kernel-3@gmane.org; Fri, 30 Sep 2005 16:09:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030313AbVI3OI5 (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 30 Sep 2005 10:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030311AbVI3OI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 10:08:56 -0400
Received: from mail.dvmed.net ([216.237.124.58]:49540 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030307AbVI3OIz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 10:08:55 -0400
Received: from cpe-069-134-188-146.nc.res.rr.com ([69.134.188.146] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.52 #1 (Red Hat Linux))
	id 1ELLZE-0003J8-39; Fri, 30 Sep 2005 14:08:53 +0000
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Erik Mouw <erik@harddisk-recovery.com>
In-Reply-To: <20050930120739.GB9328@harddisk-recovery.com>
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9562>

Erik Mouw wrote:
> FYI, the rsync command to get the tags blows away .git/branches/origin,
> so on the next "git pull", git will tell you "Where do you want to
> fetch from today?".

Agreed, though I always run 'git pull $url' each time, so I never 
noticed this.

Since git clone pulls the tags, I have eliminated the first rsync 
completely.

	Jeff
