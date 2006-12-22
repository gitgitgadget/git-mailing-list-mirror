From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Re: confusion over the new branch and merge config
Date: Fri, 22 Dec 2006 07:50:49 +0000
Message-ID: <200612220750.49644.alan@chandlerfamily.org.uk>
References: <Pine.LNX.4.64.0612211555210.18171@xanadu.home> <7vd56cam66.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Dec 22 08:51:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxfBO-0001Vo-S3
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 08:51:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945961AbWLVHvG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 02:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945955AbWLVHvG
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 02:51:06 -0500
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk ([82.44.22.127]:58547
	"EHLO home.chandlerfamily.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1945963AbWLVHvF (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Dec 2006 02:51:05 -0500
Received: from kanger.home ([192.168.0.21])
	by home.chandlerfamily.org.uk with esmtp (Exim 4.63)
	(envelope-from <alan@chandlerfamily.org.uk>)
	id 1GxfBG-0007Mu-BL; Fri, 22 Dec 2006 07:51:02 +0000
To: git@vger.kernel.org
User-Agent: KMail/1.9.5
In-Reply-To: <7vd56cam66.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35137>

On Thursday 21 December 2006 23:01, Junio C Hamano wrote:
> Nicolas Pitre <nico@cam.org> writes:
> > [ Hmmm... there used to be many more (remote) branches before. 
> > Where are they? Looking into .git/refs I see a remote/ directory
> > and all remote branches are there.  But I'm cheating now because a
> > newbie might not even think of looking there.
> >
> >    Ah? there is -a and -r options to git-branch.  Fair enough. ]

Added snipped content back in
>>
>> $ git branch -r
>> * master
>>   origin/HEAD
>>   origin/html
>>   origin/maint
>>   origin/man
>>   origin/master
>>   origin/next
>>   origin/pu
>>   origin/todo

And according to the man page git branch -r should print ONLY the remote 
branches

>
> A newbie might not even expect to see "many more branches"
> because there is no "before" for him.

>
> > $ git checkout origin/next
> > git checkout: to checkout the requested commit you need to specify
> >               a name for a new branch which is created and switched

What about the error message saying that origin/next is read only.  
Something like

git-checkout: the requested commit is on a remote read only branch.  You 
need to specify a new local branch with the -b option to proceed.

> > to
> >
> > [ Hmmmmmmmm.... /me stares at the message wondering.
> >   I just want to _see_ and maybe _install_ the code from "next". ]
>
> Rewording to suggest "checkout -b newbranchname origin/next",
> perhaps?
>
> > $ git checkout -b local_next origin/next
>
> "git checkout -b next origin/next" should work just fine, I
> think.
>

-- 
Alan Chandler
http://www.chandlerfamily.org.uk
