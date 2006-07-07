From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/3] configure: Add test for Perl
Date: Fri, 07 Jul 2006 04:20:33 -0700
Message-ID: <7vlkr5zmny.fsf@assigned-by-dhcp.cox.net>
References: <20060706124025.G325584e9@leonov.stosberg.net>
	<20060706161011.ccc2ea1c.tihirvon@gmail.com>
	<20060707110655.GR29115@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 07 13:20:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FyoNx-0006Sk-R8
	for gcvg-git@gmane.org; Fri, 07 Jul 2006 13:20:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbWGGLUf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Jul 2006 07:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbWGGLUf
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Jul 2006 07:20:35 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:1529 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751055AbWGGLUe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jul 2006 07:20:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060707112034.PFME6303.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 7 Jul 2006 07:20:34 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060707110655.GR29115@pasky.or.cz> (Petr Baudis's message of
	"Fri, 7 Jul 2006 13:06:55 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23430>

Petr Baudis <pasky@suse.cz> writes:

>> "which" isn't portable. On SunOS 5.9 "which foo" prints error message to
>> stdout and returns 0.
>
> Wait, Git runs on SunOS 5.9?

I thought so.  In any case, the traditionalist way is to split $PATH
by hand with "IFS=:" -- somebody already posted that on this
thread.
