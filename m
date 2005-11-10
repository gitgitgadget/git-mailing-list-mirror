From: Junio C Hamano <junkio@cox.net>
Subject: Re: Expected Behavior?
Date: Wed, 09 Nov 2005 16:03:30 -0800
Message-ID: <7vacgd8j3h.fsf@assigned-by-dhcp.cox.net>
References: <E1EZKOB-0002j5-VY@jdl.com>
	<7vwtjjllw4.fsf@assigned-by-dhcp.cox.net>
	<20051108210332.GB23265@c165.ib.student.liu.se>
	<20051109112452.GD30496@pasky.or.cz>
	<46a038f90511091504l7218df18k251bec75491891e9@mail.gmail.com>
	<7virv18kc3.fsf@assigned-by-dhcp.cox.net>
	<20051109234212.GJ30496@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 01:04:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZzuh-0005yo-Jj
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 01:03:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbVKJADd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Nov 2005 19:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbVKJADd
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 19:03:33 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:446 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751093AbVKJADc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Nov 2005 19:03:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051110000229.LIEY2059.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 9 Nov 2005 19:02:29 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051109234212.GJ30496@pasky.or.cz> (Petr Baudis's message of
	"Thu, 10 Nov 2005 00:42:12 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11450>

Petr Baudis <pasky@suse.cz> writes:

> I'm not sure I follow you here - what exactly does not feel disturbing
> and what good reasons are there for whatever they are? :-)

My misunderstanding, I guess.  I somehow thought you were
suggesting that recursive should implement mergeFile through
merge-index.  Going the other way, to make the current
merge-index users to feed mergeFile with what is stored as three
stages in an index file, would make a lot more sense.
