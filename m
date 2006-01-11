From: Junio C Hamano <junkio@cox.net>
Subject: Re: git binary size...
Date: Wed, 11 Jan 2006 11:40:10 -0800
Message-ID: <7vmzi2tuxx.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0601111021450.5073@g5.osdl.org>
	<43C558FB.3030102@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 11 20:43:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwlpT-00036U-5b
	for gcvg-git@gmane.org; Wed, 11 Jan 2006 20:40:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932465AbWAKTkN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jan 2006 14:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932467AbWAKTkN
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jan 2006 14:40:13 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:57989 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932465AbWAKTkM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2006 14:40:12 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060111193921.NDWJ3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 11 Jan 2006 14:39:21 -0500
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <43C558FB.3030102@op5.se> (Andreas Ericsson's message of "Wed, 11
	Jan 2006 20:14:03 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14502>

Andreas Ericsson <ae@op5.se> writes:

> I'd suggest adding
>
> strip:
> 	strip $(PROGRAMS)
>
> install: strip
>
> to Makefile instead.

That sounds sane.  Binary distribution _might_ hate us if we did
so, though.  IIRC Debian wanted to build with -g and strip
before installation themselves.  I do not know how this
interacts with rpmbuild.
