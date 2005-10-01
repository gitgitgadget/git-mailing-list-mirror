From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [howto] Kernel hacker's guide to git, updated
Date: Fri, 30 Sep 2005 20:17:25 -0400
Message-ID: <433DD595.4070508@pobox.com>
References: <200509301813.j8UIDXr5015488@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 01 02:18:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ELV4Q-0002Rk-6c
	for gcvg-git@gmane.org; Sat, 01 Oct 2005 02:17:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030517AbVJAARb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Sep 2005 20:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030518AbVJAARb
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Sep 2005 20:17:31 -0400
Received: from mail.dvmed.net ([216.237.124.58]:11913 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030517AbVJAARa (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Sep 2005 20:17:30 -0400
Received: from cpe-069-134-188-146.nc.res.rr.com ([69.134.188.146] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.52 #1 (Red Hat Linux))
	id 1ELV4C-0003la-3x; Sat, 01 Oct 2005 00:17:29 +0000
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Horst von Brand <vonbrand@inf.utfsm.cl>
In-Reply-To: <200509301813.j8UIDXr5015488@laptop11.inf.utfsm.cl>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9580>

Horst von Brand wrote:
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
>>Thanks for all the comments.  I just updated the KHGtG with the
>>feedback I received.  Go to
>>
>>	http://linux.yyz.us/git-howto.html
>>
>>and click reload.  Continued criticism^H^H^Hcomments welcome!
> 
> 
> - To know the current branch, "git branch" is enough (the one '*'-ed)

Click reload, this is already mentioned.


> - rsync(1) a repository is dangerous, it might catch it in the middle of
>   a update and give you an incomplete/messed up copy. Repeat rsync until no
>   change, perhaps?

Usually that's just unlucky.  I have caught kernel.org in the middle of 
a sync once, maybe twice.


> - I understand "git checkout -f" blows away any local changes, no questions
>   asked. Not very nice to suggest that to a newbie...

I constantly run into problems if I -do not- use the "-f" flag.  I 
habitually use it at all times, now.

Thanks,

	Jeff
