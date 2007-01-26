From: Junio C Hamano <junkio@cox.net>
Subject: Re: Seriously broken "git pack-refs"
Date: Thu, 25 Jan 2007 22:08:41 -0800
Message-ID: <7vireu2uc6.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0701251636060.25027@woody.linux-foundation.org>
	<7v7iva4glo.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0701252202130.25027@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jan 26 07:08:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAKGU-00025S-9W
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 07:08:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030774AbXAZGIn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 01:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030777AbXAZGIn
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 01:08:43 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:65395 "EHLO
	fed1rmmtao06.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030774AbXAZGIm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 01:08:42 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070126060842.BOHP2628.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>;
          Fri, 26 Jan 2007 01:08:42 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Fi7k1W00b1kojtg0000000; Fri, 26 Jan 2007 01:07:45 -0500
In-Reply-To: <Pine.LNX.4.64.0701252202130.25027@woody.linux-foundation.org>
	(Linus Torvalds's message of "Thu, 25 Jan 2007 22:05:18 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37803>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> So now the default isn't really "pack only tags", but "pack only tags *or* 
> things that were already packed".
>
> The reason, of course, is that if we don't pack stuff that used to be 
> packed, it will just be dropped entirely. Oops.

Sorry again.

On the other hand, I do not think it is worth unpacking non-tags
that are packed when --all is not given, so...
