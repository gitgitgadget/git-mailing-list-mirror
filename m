From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: does git prune packs?
Date: Wed, 14 Sep 2005 11:14:46 -0400
Message-ID: <43283E66.5080101@pobox.com>
References: <432805E6.6030905@pobox.com> <Pine.LNX.4.58.0509140808010.26803@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 14 17:18:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFYyK-0006DD-Ul
	for gcvg-git@gmane.org; Wed, 14 Sep 2005 17:14:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965240AbVINPOu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Sep 2005 11:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965230AbVINPOt
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Sep 2005 11:14:49 -0400
Received: from mail.dvmed.net ([216.237.124.58]:36016 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965240AbVINPOt (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Sep 2005 11:14:49 -0400
Received: from cpe-069-134-188-146.nc.res.rr.com ([69.134.188.146] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.52 #1 (Red Hat Linux))
	id 1EFYyG-0002RL-Il; Wed, 14 Sep 2005 15:14:48 +0000
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509140808010.26803@g5.osdl.org>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8530>

Linus Torvalds wrote:
> 
> On Wed, 14 Sep 2005, Jeff Garzik wrote:
> 
>>Does git-prune-packed eliminate packs that have been superceded by other 
>>packs?
> 
> 
> Nope. Pretty hard to do. Unless you just repack everything, at which point
> 
> 	git repack -a -d
> 
> will do the right thing.

I never repack, I just use your packs.

Easier on my hard disk, vastly reduces upload time (cable modem == slow 
uploads), since I can ssh to master.kernel.org and hardlink, and easier 
on kernel.org.

I'll remove the old packs manually.

Thanks,

	Jeff
