From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Silent File Mods Being Committed
Date: Thu, 23 Mar 2006 15:32:08 -0800
Message-ID: <7vodzw4u13.fsf@assigned-by-dhcp.cox.net>
References: <E1FMH3o-0001B5-Dw@jdl.com>
	<7vek0t68we.fsf@assigned-by-dhcp.cox.net>
	<20060323214710.GV18185@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Loeliger <jdl@jdl.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 24 00:32:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMZHq-00014k-VC
	for gcvg-git@gmane.org; Fri, 24 Mar 2006 00:32:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422634AbWCWXcM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Mar 2006 18:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932558AbWCWXcM
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Mar 2006 18:32:12 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:20702 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1422634AbWCWXcL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Mar 2006 18:32:11 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060323233209.UVDW26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 23 Mar 2006 18:32:09 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060323214710.GV18185@pasky.or.cz> (Petr Baudis's message of
	"Thu, 23 Mar 2006 22:47:10 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17885>

Petr Baudis <pasky@suse.cz> writes:

> Dear diary, on Thu, Mar 23, 2006 at 06:13:21AM CET, I got a letter
> where Junio C Hamano <junkio@cox.net> said that...
>>  (2) audit all the scripts to make sure they do not get upset if
>>      we add trailing +/- to the status letter, and do that
>>      unconditionally, like the attached patch does.
>
> Cogito will get upset since we assume the mode field is one-char in our
> regexps, and when we don't, we compare the mode field with strings and
> that would obviously fail if you add random stuff to it.
>
> Otherwise, I like this idea, though.

Likewise.  If it was not obvious, I am not going to commit that
myself.  If jdl or somebody cares enough, he or she can prepare
a patch to accomodate set of patches to git-core, Cogito and
StGIT (at least these three should be covered) _and_ parrot my
patch back at me.  Hint, hint...
