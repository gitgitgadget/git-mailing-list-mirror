From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Re: Importing from tarballs; add, rm, update-index?
Date: Sat, 13 Jan 2007 18:15:27 +0000
Message-ID: <200701131815.27481.alan@chandlerfamily.org.uk>
References: <6efbd9b70701120541n5dc4d0e1va50ae96543d8c80@mail.gmail.com> <slrneqha0g.5sa.Peter.B.Baumann@xp.machine.xx> <E5A7E6A8-45FF-4A7A-A31E-DFEBAD48DF1C@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Jan 13 19:15:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5nPs-00074W-Ef
	for gcvg-git@gmane.org; Sat, 13 Jan 2007 19:15:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422737AbXAMSPe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Jan 2007 13:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422744AbXAMSPe
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jan 2007 13:15:34 -0500
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk ([82.44.22.127]:60521
	"EHLO home.chandlerfamily.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1422737AbXAMSPd (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Jan 2007 13:15:33 -0500
Received: from kanger.home ([192.168.0.21])
	by home.chandlerfamily.org.uk with esmtp (Exim 4.63)
	(envelope-from <alan@chandlerfamily.org.uk>)
	id 1H5nPg-0005rm-7d
	for git@vger.kernel.org; Sat, 13 Jan 2007 18:15:32 +0000
To: git@vger.kernel.org
User-Agent: KMail/1.9.5
In-Reply-To: <E5A7E6A8-45FF-4A7A-A31E-DFEBAD48DF1C@silverinsanity.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36764>

> I was referring to adding Linus' rant...  And maybe several others.
> I tend to find his rants at least slightly amusing, highly
> informative, and I tend to end up agreeing.  I have very little
> opinion on your complaint so long as the system works consistently.
> "git commit -a" is still my most common workflow.  I've used git-add
> (and prior to that git-update-index) from time to time when I fix
> bugs that need to be separate from my current work, but far far more
> common is "I finished this chunk of functionality, add all the
> changes I did to make it happen".

I think the fact that this thread has come alive again implies we didn't 
bottom it last time through.

One thing, in particular, has been bugging me with the hide the index 
concept - that is, its still necessary to git add files for them to be 
picked up with git commit -a

My (albeit limited) experience with using git is at home coding a java 
application for my web site using eclipse.  During the application 
development when I am initially coding the application, or when I am 
doing a major update that adds new pages to my site then I have to 
remember to git add files.  My immediate instinct is do do commands of 
the form

git add 
Javasource/uk/org/chandlerfamily/appname/tapestry/pages/subdir/xxx.java

and
git add Webcontent/subdir/xxx.html

which even with bash completion is a pain to enter.

(although that is probably harder than it needs to be - can't I just do 
git add . ?)

I don't know whether we have had the debate here - if we have done it 
would have been in the very very early days, but subject to 
the .gitignore rules what would be the implications of a git commit -a 
that automatically adds any files within the directory (and 
subdirectories) in which it is issued.

Then I think you don't even have to get into what is git add all about 
until you get to the "use the index" stage.

I am (at the moment - but I am good at changing my mind) in the side of 
giit add for both adding new paths and updating content.  This is 
purely  pragmatic - don't have to remember which one I am trying to do.

-- 
Alan Chandler
http://www.chandlerfamily.org.uk
