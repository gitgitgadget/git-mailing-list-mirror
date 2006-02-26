From: Junio C Hamano <junkio@cox.net>
Subject: Re: the war on trailing whitespace
Date: Sat, 25 Feb 2006 19:38:20 -0800
Message-ID: <7v1wxq7psj.fsf@assigned-by-dhcp.cox.net>
References: <20060225174047.0e9a6d29.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 26 04:38:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDCk8-00008z-Uz
	for gcvg-git@gmane.org; Sun, 26 Feb 2006 04:38:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbWBZDiY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Feb 2006 22:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbWBZDiY
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Feb 2006 22:38:24 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:45454 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1750793AbWBZDiX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Feb 2006 22:38:23 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060226033653.YIZT20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 25 Feb 2006 22:36:53 -0500
To: Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060225174047.0e9a6d29.akpm@osdl.org> (Andrew Morton's message
	of "Sat, 25 Feb 2006 17:40:47 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16768>

Andrew Morton <akpm@osdl.org> writes:

> It's invariably pointless to add lines which have trailing whitespace. 
> Nobody cares much, but my scripts spam me when it happens, so I've become
> obsessive....

I do not call me obsessive, but I do enable pre-commit and
pre-applypatch hooks I ship with git myself.

> I realise that we cannot do this when doing git fetches, but when importing
> patches and mboxes, git ought to whine loudly about input which matches the
> above regexp, and it should offer an option to tidy it up.  Perhaps by
> default.

I stole the policy the sample hook scripts use from you; it is
not enabled by default, and as the tool manufacturer I am a bit
reluctant to do so.

However, as a kernel project maintainer high in the foodchain,
I'd imagine your plea to your fellow maintainers who apply
patches using git tools would be heard well.
