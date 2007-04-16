From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Update git-am documentation
Date: Mon, 16 Apr 2007 00:48:30 -0700
Message-ID: <7vy7ksvjxt.fsf@assigned-by-dhcp.cox.net>
References: <7vabx8x0x7.fsf@assigned-by-dhcp.cox.net>
	<20070416072131.GA20722@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andrew Ruder <andy@aeruder.net>
X-From: git-owner@vger.kernel.org Mon Apr 16 09:48:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdLww-0005mB-NC
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 09:48:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419AbXDPHsb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 03:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbXDPHsb
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 03:48:31 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:43503 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932419AbXDPHsb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 03:48:31 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070416074831.TQUU1257.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Mon, 16 Apr 2007 03:48:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id njoW1W0041kojtg0000000; Mon, 16 Apr 2007 03:48:30 -0400
In-Reply-To: <20070416072131.GA20722@localdomain> (Andrew Ruder's message of
	"Mon, 16 Apr 2007 02:21:31 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44607>

Andrew Ruder <andy@aeruder.net> writes:

> Documentation/git-am.txt missing several short versions
> of options.  Added documentation for --resolvemsg=<msg>
> command-line option.
>
> Signed-off-by: Andrew Ruder <andy@aeruder.net>
> ---
>  Sometimes it is a bit difficult to gauge intention by reading the code.
>  :)  My initial thought was that it was just to aid in scripting git-am
>  and left it at that.  But I'd still much rather have all command-line
>  options in the man pages even if they are primarily for internal use as
>  sometimes they still will find themself useful in atypical situations.

It is _solely_ (not "primarily") for git-rebase and not even for
"scripting around".  In other words, it is an implementation
detail of git-rebase and I would rather reserve the right to
update that implementation detail by not setting that in stone
for users to abuse.
