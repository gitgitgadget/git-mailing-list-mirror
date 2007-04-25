From: Junio C Hamano <junkio@cox.net>
Subject: Re: Making git disappear when talking about my code
Date: Wed, 25 Apr 2007 12:56:56 -0700
Message-ID: <7vzm4ww7lj.fsf@assigned-by-dhcp.cox.net>
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
	<7v1wiabbfr.fsf@assigned-by-dhcp.cox.net>
	<87mz0w7g3j.wl%cworth@cworth.org>
	<Pine.LNX.4.64.0704251345220.28708@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carl Worth <cworth@cworth.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Marcin Kasperski <Marcin.Kasperski@softax.com.pl>,
	git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Apr 25 21:57:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hgnbv-0005Yo-TD
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 21:57:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161807AbXDYT47 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 15:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161809AbXDYT47
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 15:56:59 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:57845 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161807AbXDYT46 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 15:56:58 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070425195657.JZXM1218.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Wed, 25 Apr 2007 15:56:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id rXww1W00Z1kojtg0000000; Wed, 25 Apr 2007 15:56:57 -0400
In-Reply-To: <Pine.LNX.4.64.0704251345220.28708@iabervon.org> (Daniel
	Barkalow's message of "Wed, 25 Apr 2007 15:44:11 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45555>

Daniel Barkalow <barkalow@iabervon.org> writes:

> Linus has stated a preference on the lkml for being told about branches in 
> the syntax used for anonymous pulls: URL branchname.
>
> That is, you say:
>
>   Please pull from:
>     git://server/path branch
>
> And he cuts and pastes into the command line:
>
>   git pull git://server/path branch
>
> Now, this syntax isn't available for git-clone, because git-clone puts the 
> optional directory to create after the URL. But, in an ideal world, this 
> is how it would work; you could see a pull request, and just type "git 
> some-command <paste>".

I think I already suggested this to Carl once, but if you 
forget about 'git clone' in this case (or any other cases), your
example would just work.

	$ git init
        $ git pull git://server/path branch
