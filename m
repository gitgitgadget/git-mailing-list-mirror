From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] add commit count options to git-shortlog
Date: Sat, 07 Oct 2006 02:33:30 -0700
Message-ID: <7vodsotqqd.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0610061520020.2435@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 07 11:33:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GW8Yt-0002dT-3z
	for gcvg-git@gmane.org; Sat, 07 Oct 2006 11:33:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbWJGJdd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Oct 2006 05:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbWJGJdd
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Oct 2006 05:33:33 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:4055 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750719AbWJGJdc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Oct 2006 05:33:32 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061007093331.WGY13992.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>;
          Sat, 7 Oct 2006 05:33:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id XMZa1V0041kojtg0000000
	Sat, 07 Oct 2006 05:33:34 -0400
To: Nicolas Pitre <nico@cam.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28463>

Nicolas Pitre <nico@cam.org> writes:

> This patch does 3 things:
>...
> Signed-off-by: Nicolas Pitre <nico@cam.org>
>
> ---
>
> I'm far from a Perl expert.  I just hope that Perl gurus out there won't 
> throw up too badly.
>
> With this it is possible to have nice statistics quickly, and 
> demonstrate that Junio is really our King.  ;-)

I only talk passable Perl but I did not find much objectionable
stuff there.  But I am not sure how this is useful aside from
stroking your own ego.

Also I get the following.

$ git log --pretty=short v1.4.2..abd6970 |
  perl ./git-shortlog.perl -n -s >/dev/null
parse error: input records != output records
