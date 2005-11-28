From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] bisect: quote pathnames for eval safety.
Date: Sun, 27 Nov 2005 18:12:30 -0800
Message-ID: <7virud34hd.fsf@assigned-by-dhcp.cox.net>
References: <7voe48gqg9.fsf@assigned-by-dhcp.cox.net>
	<7vek52e4ve.fsf@assigned-by-dhcp.cox.net>
	<20051127151134.0eac7019.tihirvon@gmail.com>
	<Pine.LNX.4.64.0511271106360.13959@g5.osdl.org>
	<7vmzjp35gk.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Timo Hirvonen <tihirvon@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 28 03:13:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgYVQ-0004oh-18
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 03:12:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbVK1CMc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Nov 2005 21:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbVK1CMc
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Nov 2005 21:12:32 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:14248 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751212AbVK1CMc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Nov 2005 21:12:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051128021233.TXFP25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 27 Nov 2005 21:12:33 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vmzjp35gk.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 27 Nov 2005 17:51:23 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12848>

Junio C Hamano <junkio@cox.net> writes:

> Linus Torvalds <torvalds@osdl.org> writes:
>
>> Almost totally untested, and I guarantee that if your pathnames have 
>> spaces in them (or your GIT_DIR has spaces in it) this won't work. I don't 
>> know how to fix that, my shell programming isn't good enough.
>
> Like this?  I've placed the bisect patch with this in the
> proposed updates.

Not like that ;-).  Fixed one is in pu.
