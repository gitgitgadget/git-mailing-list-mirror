From: Junio C Hamano <junkio@cox.net>
Subject: Re: Diffs "from" working directory
Date: Mon, 21 Nov 2005 13:40:32 -0800
Message-ID: <7vhda5of1r.fsf@assigned-by-dhcp.cox.net>
References: <200511201817.15780.blaisorblade@yahoo.it>
	<20051120174359.GA24177@fieldses.org>
	<Pine.LNX.4.64.0511201010490.13959@g5.osdl.org>
	<20051120205855.GA30346@fieldses.org>
	<4381287F.5080402@citi.umich.edu>
	<b0943d9e0511211328j7c062c07s@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 21 22:42:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeJPI-00017H-03
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 22:41:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbVKUVkh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 16:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751018AbVKUVkh
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 16:40:37 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:33007 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751059AbVKUVkf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 16:40:35 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051121213929.LDZF26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 21 Nov 2005 16:39:29 -0500
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <b0943d9e0511211328j7c062c07s@mail.gmail.com> (Catalin Marinas's
	message of "Mon, 21 Nov 2005 21:28:53 +0000")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12490>

Catalin Marinas <catalin.marinas@gmail.com> writes:

> My import command sets the author to the e-mail sender, which was you.
> Maybe this should be changed but I don't know which option is better.
> In the meantime, you can change the default e-mail template to set the
> From: line with to the author of the patch and maybe add a Reply-to:
> with your address.

... and Sender: perhaps?

The first lines in the commit log message sent over e-mail can
have "Subject: " (or "[PATCH] "), "From: ", and "Date: " to
override what is slurped from e-mail headers if you use mailinfo,
so that might be a better alternative to suggest.
