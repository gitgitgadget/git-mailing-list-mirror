From: Junio C Hamano <junkio@cox.net>
Subject: Re: Something wrong with pickaxe?
Date: Wed, 18 Jan 2006 16:25:17 -0800
Message-ID: <7v3bjlt66q.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0601190004130.15298@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0601181541150.3240@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu Jan 19 01:25:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzNcE-0002BU-FW
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 01:25:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161093AbWASAZV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jan 2006 19:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161094AbWASAZV
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jan 2006 19:25:21 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:22409 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1161093AbWASAZU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jan 2006 19:25:20 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060119002423.NZLG15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 18 Jan 2006 19:24:23 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.64.0601181541150.3240@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 18 Jan 2006 15:55:13 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14872>

Linus Torvalds <torvalds@osdl.org> writes:

> So when you use pickaxe, you really want to match the whole line you're 
> looking for - otherwise you'll only see when people add or remove a 
> particular string, not when they change things around it. Even then, if 
> that particular line gets _moved_ (but otherwise is unchanged) pickaxe 
> won't pick it up.

True.  I always feed at least couple of lines to it.

> ... Junio would be open to 
> more friendly pickaxe semantics if the suggested semantics change was 
> accompanied by an actual diff to implement them.

True again.  It is hard to be "more friendly" without actually
generating a diff ;-).
