From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-http-push and hooks
Date: Tue, 07 Feb 2006 15:41:22 -0800
Message-ID: <7v8xsmspnh.fsf@assigned-by-dhcp.cox.net>
References: <20060206205203.GA20973@guybrush.melee>
	<20060206232231.GK3873@reactrix.com>
	<20060207195458.GA7217@c165.ib.student.liu.se>
	<20060207202351.GA3833@reactrix.com>
	<20060207205709.GB7217@c165.ib.student.liu.se>
	<4fb292fa0602071302p551aca02j53d40e3f8e25ff8a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 08 00:41:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6cT0-0005jG-L7
	for gcvg-git@gmane.org; Wed, 08 Feb 2006 00:41:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030285AbWBGXl0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Feb 2006 18:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030283AbWBGXl0
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Feb 2006 18:41:26 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:21957 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1030285AbWBGXlY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2006 18:41:24 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060207233904.JKSO17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 7 Feb 2006 18:39:04 -0500
To: Bertrand Jacquin <beber.mailing@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15723>

Bertrand Jacquin <beber.mailing@gmail.com> writes:

> On 2/7/06, Fredrik Kuivinen <freku045@student.liu.se> wrote:
>> You can't push to a git daemon, can you?
>>
>> Furthermore, if the user has a working http/DAV server installed it
>> might be the case that she prefers to use that one instead of
>> installing a new daemon.
>
> Personaly is use http because at work i've a $$@#! proxy and allow dav
> and nothing else.
> Could you push over http/proxy with gitdaemon ? Isn't it just a read
> only method ?

I think you are agreeing with what Fredrik said.  git-daemon is
a read-only thing.  You would want to SSH into the repository
machine.

If you are using git at work for work, and the benefit git gives
you outweigh the cost and trouble to modify the proxy and/or
firewalling settings, maybe you can convince your management to
allow you to SSH out to make you more productive?  That way you
can use git-push over native git protocol.

If you are using git while at work but not for work, then maybe
I should not be giving an advice ;-).
