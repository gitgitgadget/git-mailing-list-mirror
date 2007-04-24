From: Junio C Hamano <junkio@cox.net>
Subject: Re: GIT vs Other: Need argument
Date: Mon, 23 Apr 2007 22:15:04 -0700
Message-ID: <7v1wiabbfr.fsf@assigned-by-dhcp.cox.net>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com>
	<20070417104520.GB4946@moonlight.home>
	<8b65902a0704170841q64fe0828mdefe78963394a616@mail.gmail.com>
	<200704171818.28256.andyparkins@gmail.com>
	<20070417173007.GV2229@spearce.org> <462521C7.2050103@softax.com.pl>
	<Pine.LNX.4.64.0704181130150.12094@racer.site>
	<alpine.LFD.0.98.0704180851060.2828@woody.linux-foundation.org>
	<Pine.LNX.4.64.0704191118050.8822@racer.site>
	<alpine.LFD.0.98.0704190940330.9964@woody.linux-foundation.org>
	<4627ABBB.8060709@softax.com.pl>
	<alpine.LFD.0.98.0704191341370.9964@woody.linux-foundation.org>
	<877is29b1l.wl%cworth@cworth.org>
	<7vps5ud91x.fsf@assigned-by-dhcp.cox.net>
	<87vefm7l6g.wl%cworth@cworth.org>
	<alpine.LFD.0.98.0704231609440.9964@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carl Worth <cworth@cworth.org>,
	Marcin Kasperski <Marcin.Kasperski@softax.com.pl>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Apr 24 07:15:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgDMu-0007Kk-61
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 07:15:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753106AbXDXFPI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Apr 2007 01:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753507AbXDXFPH
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 01:15:07 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:45326 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753106AbXDXFPG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2007 01:15:06 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070424051504.TISE1235.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Tue, 24 Apr 2007 01:15:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id qtF41W00C1kojtg0000000; Tue, 24 Apr 2007 01:15:05 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45410>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> I'd personally be ok with a
>
> 	git clone --default=<branch> <url>
>
> to create something where "master" defaults to some other remote branch, 
> but that just addresses the syntax. And quite frankly, I don't think we 
> *need* to. We should just tell people how _easy_ it is to track some other 
> branch now.

I agree with this (and everything you said in your message).
Keep the semantics the same, except that behave as if remote
HEAD pointed at a different branch than what it really points
at.

If Carl is also happy with the syntax, we can conclude this
discussion and:

 (1) have that as an enhancement to git-clone;

 (2) add a how-to document or a section to the manual to teach
     people how to track one or more branches, based on the
     messages already posted on this thread.
