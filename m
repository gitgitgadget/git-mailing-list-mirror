From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] GIT: Support [address] in URLs
Date: Wed, 21 Dec 2005 14:16:50 -0800
Message-ID: <7v64pi5c4t.fsf@assigned-by-dhcp.cox.net>
References: <20051221.192342.132228413.yoshfuji@linux-ipv6.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 21 23:17:25 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpCGj-00024B-T4
	for gcvg-git@gmane.org; Wed, 21 Dec 2005 23:17:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964823AbVLUWQy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Dec 2005 17:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964831AbVLUWQx
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Dec 2005 17:16:53 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:31998 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S964823AbVLUWQw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2005 17:16:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051221221452.BHSO17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 21 Dec 2005 17:14:52 -0500
To: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
In-Reply-To: <20051221.192342.132228413.yoshfuji@linux-ipv6.org> (YOSHIFUJI
	Hideaki's message of "Wed, 21 Dec 2005 19:23:42 +0900 (JST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13905>

[somehow the first reply seems to have been lost]

YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org> writes:

> Allow address enclosed by [] in URLs, like:
>    git push '[3ffe:ffff:...:1]:GIT/git'
> or
>    git push 'ssh://[3ffe:ffff:...:1]/GIT/git'

I am not familiar with how things are done in ipv6 land, but I
wonder if the former is consistent with the existing practice.

That is, how does one do something like this, with an ipv6
literal address?

	telnet 127.0.0.1 80

Is it done like this

	telnet '[::1]' 80

or
	telnet '::1' 80

Your patch suggests the former, but I just wanted to make sure.

The latter "ssh://[...]" looks like RFC 3986, and I do not have
problems with.
