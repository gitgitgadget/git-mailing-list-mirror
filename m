From: Junio C Hamano <junkio@cox.net>
Subject: Re: gitweb.cgi in C
Date: Thu, 08 Dec 2005 16:42:45 -0800
Message-ID: <7vhd9j9k3e.fsf@assigned-by-dhcp.cox.net>
References: <43988299.4090101@tiscali.cz> <20051208222759.GO22159@pasky.or.cz>
	<7vfyp3b4ki.fsf@assigned-by-dhcp.cox.net>
	<20051208224626.GP22159@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Dec 09 01:44:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EkWLa-0006QR-NO
	for gcvg-git@gmane.org; Fri, 09 Dec 2005 01:42:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932768AbVLIAms (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Dec 2005 19:42:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932770AbVLIAms
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Dec 2005 19:42:48 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:41437 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932768AbVLIAmr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2005 19:42:47 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051209004121.BPWQ26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 8 Dec 2005 19:41:21 -0500
To: git@vger.kernel.org
In-Reply-To: <20051208224626.GP22159@pasky.or.cz> (Petr Baudis's message of
	"Thu, 8 Dec 2005 23:46:26 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13406>

Petr Baudis <pasky@suse.cz> writes:

>> It _might_ make sense to do gitweb using libified git Smurf is
>> working on, in order to reduce forks and execs, but that is
>> mostly independent of rewriting that in C.
>
> I'd see having Perl XS for libgit as something much more sensible. And
> you could do cute porcelain stuff with that as well.

Yes, that is exactly what I meant by what Smurf is working on --
libified git with Pyrex.
