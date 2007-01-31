From: Junio C Hamano <junkio@cox.net>
Subject: Re: newbie questions about git design and features (some wrt hg)
Date: Tue, 30 Jan 2007 20:57:47 -0800
Message-ID: <7vodofx06s.fsf@assigned-by-dhcp.cox.net>
References: <3c6c07c20701300820l42cfc8dbsb80393fc1469f667@mail.gmail.com>
	<7v8xfkz8oj.fsf@assigned-by-dhcp.cox.net>
	<3c6c07c20701301938u4d1503a2m3e0af51121b8e6db@mail.gmail.com>
	<Pine.LNX.4.64.0701302029460.3611@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jan 31 05:57:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HC7Xb-0005CS-R4
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 05:57:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752156AbXAaE5t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 23:57:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752158AbXAaE5t
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 23:57:49 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:46483 "EHLO
	fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752156AbXAaE5s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 23:57:48 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070131045748.UYWK15640.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>;
          Tue, 30 Jan 2007 23:57:48 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Hgxm1W01A1kojtg0000000; Tue, 30 Jan 2007 23:57:47 -0500
In-Reply-To: <Pine.LNX.4.64.0701302029460.3611@woody.linux-foundation.org>
	(Linus Torvalds's message of "Tue, 30 Jan 2007 20:35:02 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38228>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> But I'll admit - my main reason going with C is (a) it's what I know and 
> (b) I absolutely _hate_ being constrained by the language. The great thing 
> about C (still) is that you can do *anything* in it. You're literally 
> limited by hardware, and by your own abilities. Nothing else.
>
> 			Linus

Well, if you count "time" as part of your own ability then that
is true.  Some things are too cumbersome and not performance
critical enough to do in C.
