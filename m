From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Disable USE_SYMLINK_HEAD by default
Date: Tue, 15 Nov 2005 00:24:39 -0800
Message-ID: <7vpsp2qpx4.fsf@assigned-by-dhcp.cox.net>
References: <1132034390.22207.18.camel@dv>
	<7vveyuqto5.fsf@assigned-by-dhcp.cox.net>
	<1132042427.3512.50.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 15 09:28:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ebw8q-0006Ue-Rv
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 09:26:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbVKOIYm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 03:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbVKOIYm
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 03:24:42 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:29599 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751379AbVKOIYl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 03:24:41 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051115082329.GZUO20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 15 Nov 2005 03:23:29 -0500
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <1132042427.3512.50.camel@dv> (Pavel Roskin's message of "Tue, 15
	Nov 2005 03:13:47 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11888>

Pavel Roskin <proski@gnu.org> writes:

> In particular, StGIT still needs fixing.
>
>> The only thing I can think of that might be inconvenient is if
>> you try doing "cp -a" off of a filesystem that supports symlinks
>> to another filesystem that does not -- probably that would fail
>> copying the symlinked .git/HEAD.  But if that is the problem,
>> you could always git-clone, which should do the right thing, I
>> think.
>
> I'm talking from my experience now.  If there is an option, there are
> users that have it enabled and those who have it disabled (by
> definition).  As is often happens, one of the configurations is more
> popular with developers.  The other configuration almost inevitably
> starts suffering from the "bit rot".

That's a real concern, I should agree.
