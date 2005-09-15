From: Junio C Hamano <junkio@cox.net>
Subject: Re: dumb transports not being welcomed..
Date: Thu, 15 Sep 2005 02:17:25 -0700
Message-ID: <7v1x3q4rmi.fsf@assigned-by-dhcp.cox.net>
References: <7vek7s1xsh.fsf@assigned-by-dhcp.cox.net>
	<20050913211444.GA27029@mars.ravnborg.org>
	<7vacig1wrb.fsf@assigned-by-dhcp.cox.net>
	<7vpsrcwrc1.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0509131525250.26803@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Ravnborg <sam@ravnborg.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 15 11:18:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFps2-0005Uy-MZ
	for gcvg-git@gmane.org; Thu, 15 Sep 2005 11:17:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbVIOJR1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Sep 2005 05:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932330AbVIOJR1
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Sep 2005 05:17:27 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:48606 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932305AbVIOJR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2005 05:17:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050915091726.BVXK20473.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 15 Sep 2005 05:17:26 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509131525250.26803@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 13 Sep 2005 15:29:35 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8599>

Linus Torvalds <torvalds@osdl.org> writes:

> Also, I really do think that the dumb transports are oversold, and 
> git-daemon is undersold. I know all about firewalls, but I also think that 
> if people used the smart protocols more, that's a problem that would 
> largely solve itself. 

This reminds me of one thing I've been wanting to have on the
client side (git-fetch-pack): HTTP CONNECT passthru ala
"tn-gw-nav -H", which is one of the ways many people ssh out
over firewalls if I understand correctly.  CVS pserver protocol
seems to do the same using `proxy' connection option.

Anybody interested?
