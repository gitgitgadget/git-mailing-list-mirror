From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Re: Two ideas for improving git's user interface
Date: Sat, 4 Feb 2006 09:30:35 +0000
Message-ID: <200602040930.35727.alan@chandlerfamily.org.uk>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com> <200602040803.45617.alan@chandlerfamily.org.uk> <7virrv4jk1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Feb 04 10:30:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5Jki-0004z2-Cg
	for gcvg-git@gmane.org; Sat, 04 Feb 2006 10:30:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945947AbWBDJae (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Feb 2006 04:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945967AbWBDJae
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Feb 2006 04:30:34 -0500
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk ([82.44.22.127]:3006
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S1945947AbWBDJae (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2006 04:30:34 -0500
Received: from kanger.home ([192.168.0.21])
	by home.chandlerfamily.org.uk with esmtp (Exim 4.50)
	id 1F5JkW-0006Oi-TW; Sat, 04 Feb 2006 09:30:33 +0000
To: git@vger.kernel.org
User-Agent: KMail/1.9.1
In-Reply-To: <7virrv4jk1.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15581>

On Saturday 04 February 2006 08:25, Junio C Hamano wrote:
> Alan Chandler <alan@chandlerfamily.org.uk> writes:
> > Wow - light comes on.
>
> That's good.
>
> > -this tutorial the first time, I'd suggest to skip to "Publishing
> > -your work" section and come back here later.
> > +this tutorial the first time, I'd suggest to skip to "Resolving Merge
> > +Problems" section and come back here later.
>
> The changes before this look very good to me, but these two
> lines do not make any sense. If you are going to talk about
> "Resolving Merge Problems", you _need_ to know about index, so
> you cannot skip the material.

Maybe - since the light has just come on, I need to understand a lot more 
about this area before I can really comment.  The tutorial invited one to 
skip it before, so I was just doing so again.

Even today when I tried to read this section again my eyes glazed over.  The 
long sha outputs from git-ls-files screams off the page "don't bother this is 
detailed technical stuff" :-(




>
> I think having a section on manual merge resolution between the
> Index File section and Publishing section makes sense.  What
> kind of merges did you have trouble figuring out when you were
> still git novice?  That would be a good starting point.
>

I STILL come out in a cold sweat (actually that is a bit over the top:-) ) as 
soon as a merge fails for whatever reason.  The problem is that I am not 
doing development full time, nor in a team, so I probably hit one about once 
every 2 months.  This means that I don't remember what to do, and need to go 
and look it up.  But where - there is nothing in my main reference places 
(Everyday Git - or before that the tutorial). 

So I normally attempt to do what I think is sensible.  Manually searching for 
files that haven't merged. Edit the lines with the
 >>>>>>
====
<<< 
markers in them until I think the resultant file is what it should be and then 
try commit again (probably cg-commit rather than git commit).  But what 
happens next is then hit or miss - sometimes it just works - sometimes it 
doesn't and I am that place where there was a long thread a couple of months 
ago entitled something like "and what do I do now?"

I must admit it normally works OK - but I have come across situations a couple 
of weeks later where a file is in an unexpected state - seems to have been 
from the wrong branch, or missing a commit I thought I had made.
-- 
Alan Chandler
http://www.chandlerfamily.org.uk
Open Source. It's the difference between trust and antitrust.
