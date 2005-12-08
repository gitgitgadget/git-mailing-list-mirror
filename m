From: Junio C Hamano <junkio@cox.net>
Subject: Re: gitweb.cgi in C
Date: Thu, 08 Dec 2005 14:35:09 -0800
Message-ID: <7vfyp3b4ki.fsf@assigned-by-dhcp.cox.net>
References: <43988299.4090101@tiscali.cz> <20051208222759.GO22159@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 08 23:36:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EkUMI-0006CJ-3D
	for gcvg-git@gmane.org; Thu, 08 Dec 2005 23:35:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932680AbVLHWfN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Dec 2005 17:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932681AbVLHWfN
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Dec 2005 17:35:13 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:910 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932680AbVLHWfL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2005 17:35:11 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051208223354.PJDX17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 8 Dec 2005 17:33:54 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051208222759.GO22159@pasky.or.cz> (Petr Baudis's message of
	"Thu, 8 Dec 2005 23:27:59 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13381>

Petr Baudis <pasky@suse.cz> writes:

> Dear diary, on Thu, Dec 08, 2005 at 07:59:37PM CET, I got a letter
> where Majkls <majkls@tiscali.cz> said that...
>> What do you think about gitweb.cgi in C?
>
> To add to the collective dismay - why bother?

It _might_ make sense to do gitweb using libified git Smurf is
working on, in order to reduce forks and execs, but that is
mostly independent of rewriting that in C.
