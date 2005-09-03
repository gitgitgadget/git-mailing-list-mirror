From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: Moved files and merges
Date: Sat, 3 Sep 2005 21:05:00 +0200
Message-ID: <20050903190500.GB8379@mars.ravnborg.org>
References: <4318E754.9000703@zytor.com> <7vek87djat.fsf@assigned-by-dhcp.cox.net> <7vek867e29.fsf@assigned-by-dhcp.cox.net> <7vy86erntu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Fredrik Kuivinen <freku045@student.liu.se>,
	"H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 03 21:04:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EBdHo-0007cI-ET
	for gcvg-git@gmane.org; Sat, 03 Sep 2005 21:02:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbVICTCm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Sep 2005 15:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbVICTCm
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Sep 2005 15:02:42 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:20318 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S1751189AbVICTCl
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 3 Sep 2005 15:02:41 -0400
Received: from mars.ravnborg.org (0x50a0757d.hrnxx9.adsl-dhcp.tele.dk [80.160.117.125])
	by pfepc.post.tele.dk (Postfix) with ESMTP id 8C69026283F;
	Sat,  3 Sep 2005 21:02:39 +0200 (CEST)
Received: by mars.ravnborg.org (Postfix, from userid 1000)
	id 436EA6AC01D; Sat,  3 Sep 2005 21:05:00 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vy86erntu.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8045>

On Sat, Sep 03, 2005 at 11:46:53AM -0700, Junio C Hamano wrote:
> This is a simplified scenario of klibc vs klibc-kbuild HPA had
> trouble with, to help us think of a way to solve this
> interesting merge problem.
> 
> 	 #1 - #3 - #5 - #7
>        /    /         /
>     #0 - #2 - #4 - #6
> 
> There are two lines of developments.  #0->#2 renames F to G and
> introduces K.  #0->#1 keeps F as F and does not introduce K.

As explained in another mail what we want to do is actually to
transpose the changes made to F to the now renamed file G.
So we end up with G containing the modifications made to F.

Also we want to include the new file K.

So we end up with a new commit containing the renamed file with
modifications and the new files too.

I hope this simplfies the usecase from a git perspective.

	Sam
