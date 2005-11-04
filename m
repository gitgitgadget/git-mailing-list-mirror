From: Junio C Hamano <junkio@cox.net>
Subject: Re: CFLAGS usage
Date: Fri, 04 Nov 2005 09:45:38 -0800
Message-ID: <7voe50wblp.fsf@assigned-by-dhcp.cox.net>
References: <118833cc0511040721w7f3990fbw631feaa6a4bda936@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 04 18:47:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EY5dp-0005ne-F3
	for gcvg-git@gmane.org; Fri, 04 Nov 2005 18:46:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbVKDRpm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Nov 2005 12:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbVKDRpl
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Nov 2005 12:45:41 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:4027 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1750765AbVKDRpk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2005 12:45:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051104174457.YYJI29333.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 4 Nov 2005 12:44:57 -0500
To: Morten Welinder <mwelinder@gmail.com>
In-Reply-To: <118833cc0511040721w7f3990fbw631feaa6a4bda936@mail.gmail.com>
	(Morten Welinder's message of "Fri, 4 Nov 2005 10:21:55 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11148>

Morten Welinder <mwelinder@gmail.com> writes:

> Various stuff is being added to CFLAGS, but CFLAGS is not being used
> after being composed in CFLAGS_ALL.

True.

We should move ALL_CFLAGS definition at the very end; is
anything else needed?
