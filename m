From: Junio C Hamano <junkio@cox.net>
Subject: Re: [POOL] Who likes running Git without make install?
Date: Sun, 02 Jul 2006 10:19:29 -0700
Message-ID: <7virmf6i1q.fsf@assigned-by-dhcp.cox.net>
References: <7vhd2atid1.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0606241338370.6483@g5.osdl.org>
	<7vd5cyt8a3.fsf@assigned-by-dhcp.cox.net>
	<20060625010202.GX21864@pasky.or.cz>
	<20060625014009.GA21864@pasky.or.cz>
	<7vac82q6mb.fsf@assigned-by-dhcp.cox.net>
	<20060625152157.GG21864@pasky.or.cz>
	<7vk674mmyo.fsf@assigned-by-dhcp.cox.net>
	<20060701235906.GE29115@pasky.or.cz>
	<7vlkrcdg6d.fsf@assigned-by-dhcp.cox.net>
	<20060702113057.GF29115@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 02 19:19:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fx5bZ-0006S3-Bi
	for gcvg-git@gmane.org; Sun, 02 Jul 2006 19:19:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbWGBRTb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Jul 2006 13:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932217AbWGBRTa
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Jul 2006 13:19:30 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:13812 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932189AbWGBRTa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jul 2006 13:19:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060702171929.CEIK6235.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 2 Jul 2006 13:19:29 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060702113057.GF29115@pasky.or.cz> (Petr Baudis's message of
	"Sun, 2 Jul 2006 13:30:57 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23108>

Petr Baudis <pasky@suse.cz> writes:

> Dear diary, on Sun, Jul 02, 2006 at 02:05:46AM CEST, I got a letter
> where Junio C Hamano <junkio@cox.net> said that...
>> That's fixed in ancient past in git timescale.  Why are you
>> bringing it up again? ;-)
>
> Because, it is, well, not fixed? ;-) (Apparently.)

That response is about "Worse yet, the order is wrong -- ah you
are right" exchange, not about in-place execution.

>> Well, for a quick test to see if I haven't broken anything, I
>> use a new shell and do ". ./+denv" in my git repository where
>> that file has something like this:
>> 
>>         $ cat ./+denv
>>         :
>> 
>>         GIT_EXEC_PATH=`pwd`
>>         PATH=`pwd`:/usr/bin:/bin
>> 
>>         export GIT_EXEC_PATH PATH
>> 
>> So to a certain degree, yes I do care.
>
> But it is currently broken:

I know.  The scriptlet needs to muck with PERL5LIB too.
