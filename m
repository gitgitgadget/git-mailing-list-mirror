From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Re: Newbie falls at first hurdle
Date: Sun, 18 Sep 2005 20:11:10 +0100
Message-ID: <200509182011.10689.alan@chandlerfamily.org.uk>
References: <alan@chandlerfamily.org.uk> <200509181347.11403.alan@chandlerfamily.org.uk> <7vek7m5m0z.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Sep 18 21:12:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EH4ZF-00077I-6Z
	for gcvg-git@gmane.org; Sun, 18 Sep 2005 21:11:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbVIRTLL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Sep 2005 15:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbVIRTLK
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Sep 2005 15:11:10 -0400
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk ([82.44.22.127]:43936
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S932172AbVIRTLJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Sep 2005 15:11:09 -0400
Received: from kanger.home ([192.168.0.21])
	by home.chandlerfamily.org.uk with esmtp (Exim 4.50)
	id 1EH4ZB-0003fe-1n
	for git@vger.kernel.org; Sun, 18 Sep 2005 20:11:09 +0100
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
In-Reply-To: <7vek7m5m0z.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8807>

On Sunday 18 Sep 2005 18:22, Junio C Hamano wrote:
> Alan Chandler <alan@chandlerfamily.org.uk> writes:

> > Still struggling with how to cherry pick parts a previous
> > update (between possibly two other branches) and apply them to
> > a current branch - all the tutorials assume you want it all,
> > and I can't really understand what the cherry pick commands do
> > from their manuals.
>
> An example to pick a couple of commits from one branch to another.

I understood your example (on the assumption I don't really care what pu^2~2 
actually means as its copied from a list) and that is a new piece of useful 
information that I didn't have before, (and which I would have used several 
times this afternoon had I known) but its not exactly what I meant.

Before using git I had made a lot of unrelated changes to my working 
directory, some of which were bad.  The only way to get a snapshot before I 
made it bad (trying to hack a combination CSS and dynamically created html to 
get it to do what I want - mind breaking:-( ) was to go back to the previous 
days backup of the whole working directory. 

It was this mess I had got myself into that kicked me into getting into git, 
rather than waiting for the 1.0 release, which had been my previous plan.

I effectively loaded both my current code and the day before's backup into git 
as two separate branches.

What I was then trying to do, via various attempts with git diff -p was to 
extract small chunks of updates (ie limit scope over a few files).  Edit the 
result to limit the diff to cover a small update and then apply it to a my 
current stuff to slowly undo some of the mess that I had made. 

Being new to git, meant reading man pages all the time - which was making it 
slow progress (and which wasn't helped by realising I had an old version of 
the man pages installed part way through :-( ).  In the end it was easier to 
manually retrace my steps by typing in the changes I needed.

-- 
Alan Chandler
http://www.chandlerfamily.org.uk
