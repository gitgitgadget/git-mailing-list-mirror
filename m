From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Re: GIT 0.99.7d, and end of week status.
Date: Sun, 25 Sep 2005 21:43:23 +0100
Message-ID: <200509252143.23905.alan@chandlerfamily.org.uk>
References: <7vll1lr1bq.fsf@assigned-by-dhcp.cox.net> <7vaci1nfwa.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Sep 25 22:44:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJdLo-0000zb-7i
	for gcvg-git@gmane.org; Sun, 25 Sep 2005 22:43:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbVIYUnS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Sep 2005 16:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932286AbVIYUnR
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Sep 2005 16:43:17 -0400
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk ([82.44.22.127]:26320
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S932285AbVIYUnR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Sep 2005 16:43:17 -0400
Received: from kanger.home ([192.168.0.21])
	by home.chandlerfamily.org.uk with esmtp (Exim 4.50)
	id 1EJdLA-0001s5-Gz
	for git@vger.kernel.org; Sun, 25 Sep 2005 21:43:16 +0100
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
In-Reply-To: <7vaci1nfwa.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9285>

On Sunday 25 Sep 2005 19:47, Junio C Hamano wrote:
...
>
> One straightforward way which would work for everybody would be
> (provided you do not have git-src in the current directory):
>
>    $ git clone http://kernel.org/pub/scm/git/git.git git-src
>    $ cd git-src

I did the above just after your announcement but before the tags etc had got 
there (see my earlier question in this thread).


>    $ git reset --hard v0.99.7d

Didn't do this
...
> Then you can say:
>
>     $ git fetch origin tag v0.99.7d
 Did this
...
> Now, how would you check out the v0.99.7d tag?  There are two
> ways to think about it.
>
> If the reason you want v0.99.7d, not "master" nor "pu", is you
> would want to stay with the 0.99.7 but get all the latest safer
> fixes, then you can just checkout "maint" branch instead, like
> this:
>
>     $ git checkout -f maint
>

I am rather new to all this, but this last step puzzles me.

Before this step, and using gitk --all, I can see the maintenance branch, but 
its currently connected to the point where the v0.99.7c tag is and not where 
your latest tag is.

So if I followed these instructions, now, wouldn't I just get the v0.997c tag?

Does that mean I have missed some step along the way to get the maint branch 
position moved to the new tag?


-- 
Alan Chandler
http://www.chandlerfamily.org.uk
