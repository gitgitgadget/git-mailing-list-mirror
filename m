From: Junio C Hamano <junkio@cox.net>
Subject: Re: Approxidate licensing
Date: Tue, 10 Oct 2006 12:23:01 -0700
Message-ID: <7v64es0ycq.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0610101246241.9789@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 10 21:23:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXNC0-0000SV-Pk
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 21:23:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256AbWJJTXF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 15:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbWJJTXE
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 15:23:04 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:44476 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932256AbWJJTXC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Oct 2006 15:23:02 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061010192301.ZZGJ21457.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>;
          Tue, 10 Oct 2006 15:23:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id YjP41V00P1kojtg0000000
	Tue, 10 Oct 2006 15:23:04 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0610101246241.9789@iabervon.org> (Daniel
	Barkalow's message of "Tue, 10 Oct 2006 13:39:47 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28658>

Daniel Barkalow <barkalow@iabervon.org> writes:

> Would the three of you agree to license date.c under the LGPL or BSD? It 
> looks like you're the only authors of non-trivial changes [1]. And it seems 
> reasonable to want the date parsing thing under non-GPL terms outside of 
> git.

I do not think I have enough code in there to influence the
license of that file, so what I say below does not matter on
this particular issue.

The project as a whole is GPLv2 and GPLv2 only, but date.c is
isolated enough that I think there are valid form of using it in
your program without making your program a derived work.  In
other words, I do not think I have (even if I had written
significant part of it, which I didn't) right to demand to see
the rest of your program if you used date.c.  I do not think I
even have rights to ask about what kind of program it is.

My wishes about the code I write for this project is very
simple:

     If you improve my code that had helped you to make it help
     you even better, I would like to have that change back, so
     that your change would help me the same way as it helped
     you.

The readers may have noticed that I have slight problem with
GPLv2; in my wish it does not matter if you distribute the
result or not.  And I am selfish.  It is not about helping my
users, but about helping me ;-).
