From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: dumb transports not being welcomed..
Date: Wed, 14 Sep 2005 09:21:00 -0400
Message-ID: <432823BC.30305@pobox.com>
References: <7vek7s1xsh.fsf@assigned-by-dhcp.cox.net>	<20050913211444.GA27029@mars.ravnborg.org>	<7vacig1wrb.fsf@assigned-by-dhcp.cox.net>	<7vpsrcwrc1.fsf@assigned-by-dhcp.cox.net> <432750E1.3020508@pobox.com> <7v7jdkwqj0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Sam Ravnborg <sam@ravnborg.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 14 15:24:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFXCP-00040z-B1
	for gcvg-git@gmane.org; Wed, 14 Sep 2005 15:21:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965203AbVINNVO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Sep 2005 09:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965202AbVINNVN
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Sep 2005 09:21:13 -0400
Received: from mail.dvmed.net ([216.237.124.58]:53421 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965203AbVINNVM (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Sep 2005 09:21:12 -0400
Received: from cpe-069-134-188-146.nc.res.rr.com ([69.134.188.146] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.52 #1 (Red Hat Linux))
	id 1EFXCA-0002E5-CV; Wed, 14 Sep 2005 13:21:04 +0000
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7jdkwqj0.fsf@assigned-by-dhcp.cox.net>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8524>

Junio C Hamano wrote:
> Jeff Garzik <jgarzik@pobox.com> writes:
> 
> 
>>Junio C Hamano wrote:
>>
>>>The file $GIT_DIR/info/refs was introduced to solve this by
>>>listing the available refs for discovery, and hooks/post-update,
>>>when enabled, runs update-server-info to update the file (among
>>>other things) whenever you push into the repository.
>>
>>This is helpful.  I'll run git-update-server-info before each push, now.
> 
> 
> Just to make sure I am not misunderstanding you, is your "publish"
> workflow like this?
> 
>     - do your work on your private machine
>     - git-update-server-info in your private repository
>     - rsync that out to master.kernel.org
> 
> If so, then "before each push" makes sense.  

Correct.

	Jeff
