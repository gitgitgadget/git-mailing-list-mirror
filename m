From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [howto] Kernel hacker's guide to git, updated
Date: Thu, 29 Sep 2005 16:15:41 -0400
Message-ID: <433C4B6D.6030701@pobox.com>
References: <433BC9E9.6050907@pobox.com> <20050929200252.GA31516@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964884AbVI2UPt@vger.kernel.org Thu Sep 29 22:17:49 2005
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964884AbVI2UPt@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EL4pF-0007RF-0I
	for glk-linux-kernel-3@gmane.org; Thu, 29 Sep 2005 22:16:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964884AbVI2UPt (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 29 Sep 2005 16:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbVI2UPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 16:15:48 -0400
Received: from mail.dvmed.net ([216.237.124.58]:17134 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932447AbVI2UPr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 16:15:47 -0400
Received: from cpe-069-134-188-146.nc.res.rr.com ([69.134.188.146] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.52 #1 (Red Hat Linux))
	id 1EL4oj-0002ej-RF; Thu, 29 Sep 2005 20:15:47 +0000
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Dave Jones <davej@redhat.com>
In-Reply-To: <20050929200252.GA31516@redhat.com>
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9504>

Dave Jones wrote:
> You wrote..
> 
> $ git clone rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git linux-2.6
> $ cd linux-2.6
> $ rsync -a --verbose --stats --progress \
>   rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/ \
>   .git/
> 
> Could be just..
> 
> $ git clone rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git linux-2.6
> $ cd linux-2.6
> $ git pull
> 
> Likewise, in the next section, git pull doesn't need an argument
> if pulling from the repo it cloned.


Nope.  It intentionally includes the manual rsync because clone/pull 
doesn't seem to grab tags.  Or at least last time I checked...

	Jeff
