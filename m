From: Junio C Hamano <junkio@cox.net>
Subject: Re: [POOL] Who likes running Git without make install?
Date: Sat, 01 Jul 2006 17:08:07 -0700
Message-ID: <7vhd20dg2g.fsf@assigned-by-dhcp.cox.net>
References: <7vwtb6yip5.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0606241147480.6483@g5.osdl.org>
	<7vhd2atid1.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0606241338370.6483@g5.osdl.org>
	<7vd5cyt8a3.fsf@assigned-by-dhcp.cox.net>
	<20060625010202.GX21864@pasky.or.cz>
	<20060625014009.GA21864@pasky.or.cz>
	<7vac82q6mb.fsf@assigned-by-dhcp.cox.net>
	<20060625152157.GG21864@pasky.or.cz>
	<7vk674mmyo.fsf@assigned-by-dhcp.cox.net>
	<20060701235906.GE29115@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 02 02:08:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwpVW-0003Nm-7E
	for gcvg-git@gmane.org; Sun, 02 Jul 2006 02:08:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbWGBAIL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Jul 2006 20:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWGBAIL
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Jul 2006 20:08:11 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:47027 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751320AbWGBAII (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Jul 2006 20:08:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060702000808.TQXV27967.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 1 Jul 2006 20:08:08 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060701235906.GE29115@pasky.or.cz> (Petr Baudis's message of
	"Sun, 2 Jul 2006 01:59:06 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23088>

Petr Baudis <pasky@suse.cz> writes:

> Dear diary, on Mon, Jun 26, 2006 at 08:48:31AM CEST, I got a letter
> where Junio C Hamano <junkio@cox.net> said that...
>> I remember myself getting utterly discusted when I saw the
>> inclusion of the build-time blib directory in the search path in
>> some other Perl code outside git.
>
> Well, yes, it is ugly, but it was really cool that we could have used
> Git without installing it anywhere.
>
> But perhaps that's just me refusing to break his old ways of doing
> things. Does anyone else care about it? (And why?)

Well, for a quick test to see if I haven't broken anything, I
use a new shell and do ". ./+denv" in my git repository where
that file has something like this:

        $ cat ./+denv
        :

        GIT_EXEC_PATH=`pwd`
        PATH=`pwd`:/usr/bin:/bin

        export GIT_EXEC_PATH PATH

So to a certain degree, yes I do care.
