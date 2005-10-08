From: Junio C Hamano <junkio@cox.net>
Subject: Re: Seeing various mode changes on cygwin
Date: Sat, 08 Oct 2005 11:51:55 -0700
Message-ID: <7vfyrbrgdw.fsf@assigned-by-dhcp.cox.net>
References: <20051008180023.GC28875@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Oct 08 20:52:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EOJni-0002tW-Mr
	for gcvg-git@gmane.org; Sat, 08 Oct 2005 20:52:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbVJHSwE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Oct 2005 14:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751049AbVJHSwD
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Oct 2005 14:52:03 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:36555 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751027AbVJHSwB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Oct 2005 14:52:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051008185150.OKFX16347.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 8 Oct 2005 14:51:50 -0400
To: git@vger.kernel.org
In-Reply-To: <20051008180023.GC28875@diku.dk> (Jonas Fonseca's message of
	"Sat, 8 Oct 2005 20:00:23 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9851>

Jonas Fonseca <fonseca@diku.dk> writes:

> ... It seems that cygwin overrides the previous
> modes and sets the executable bit. git-reset doesn't fix it. Can this even be
> fixed then?
>
> A few examples below ...
>
> jonas@cygwin /usr/local/dev/git/git
> $ git reset
> Documentation/sort_glossary.pl: needs update
> t/lib-read-tree-m-3way.sh: needs update

I do not have an access to Cygwin environment so cannot be of
help on this directly, but 'git reset' without flags defaults
"--mixed" and leaves the modified files intact.  Maybe hard
reset would help here, but the real solution is to figure out
why these files acquired the extra executable bits in the first
place.
