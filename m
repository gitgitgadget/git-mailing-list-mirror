From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [msysGit Herald] The 11th revision of the msysGit Herald
Date: Tue, 27 Oct 2009 16:06:12 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0910271605270.11562@felix-maschine>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: msysgit@googlegroups.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 27 16:06:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2ncw-0002Ps-DW
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 16:06:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753075AbZJ0PGP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2009 11:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752361AbZJ0PGO
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 11:06:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:34289 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752038AbZJ0PGN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2009 11:06:13 -0400
Received: (qmail invoked by alias); 27 Oct 2009 15:06:17 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO [10.1.35.45]) [141.5.11.5]
  by mail.gmx.net (mp069) with SMTP; 27 Oct 2009 16:06:17 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/CJOpFHArC2C2/HpXRrPoJFZpiUfJWKrQqCcdFSH
	4nWFWIYb7IKm1N
X-X-Sender: johannes@felix-maschine
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131346>

Good morning Git land!

A busy and frantic Tuesday afternoon is as good an occasion as any to 
offer to you the 11th revision of the msysGit Herald, the quite 
irregular news letter to keep you informed about msysGit, the effort 
to bring one of the most powerful Source Code Management systems to 
the Operating System known as Windows. 

These are the covered topics:

	Some trivia

	Git Cheetah goes platform independent!

	Interview with Sebastian Schuberth



This issue is more to distract myself from my ever-growing day-job 
obligations than to inform about breakthrough developments in Git for 
Windows; Actually, it is a good sign that there are no major new 
things, as this means that Git on Windows is finally where we wanted 
it to be: stable. 


Some trivia
===========

Whenever I am too overworked to do something sensible, but too bored 
to go to sleep, too, I do utterly senseless stuff like factoring 1453 
(have fun!), reading xkcd, or looking at Google Analytics. 

This time, it was the latter, and I looked at the top ten countries 
accessing our website: 

 * USA 2904
 * Germany 987
 * China 809
 * UK 580
 * Japan 489
 * Russia 438
 * France 379
 * Canada 341
 * Brazil 248 
 * Poland 229 

(Total: 11.115) 

Compare this with the first week of msysGit: 

 * USA 90
 * UK 57
 * Norway 35
 * Germany 24
 * Sweden 23
 * Italy 8
 * Hungary 8
 * Japan 6
 * Netherlands 5 
 * France 5 

(Total: 298) 

So we have come a long way. It is striking how the top ten are divided 
between the rich countries, with the exception of China. So, Windows 
is a rich man's Operating System. Big news. You got to be rich to go 
for a coffee whenever you load a text document. 

The trend that the website is accessed mostly during the working week 
is even more prominent now than it was in the beginning. Just compare 
the last week: 

 * Monday 1453 (the same prime number as in xkcd 247... coincidence?)
 * Tuesday 1676
 * Wednesday 1667
 * Thursday 1628
 * Friday 1591
 * Saturday 933 
 * Sunday 918 

to the 3rd week after msysGit was born (the first two and a half weeks 
of msysGit were a little chaotic, so they are not representative): 

 * Monday 98
 * Tuesday 54
 * Wednesday 46
 * Thursday 39
 * Friday 39 (wait, the same as Thursday? Again... coincidence?)
 * Saturday 13 
 * Sunday 33 

So the trend is definitely that the weekdays are almost equal, with 
drop offs on Monday (drinking coffee to get out of the weekend?) and 
Friday (leaving maybe an hour early, or at least not doing anything 
during that hour?), but the weekends are barely over the half of the 
weekday baseline, which makes me wonder what the Windows users do on 
weekends. Use Linux, maybe? 

A little under a half accessed more than 1 page, which I found quite 
encouraging, but then, to get at the downloads, you have to click a 
second time. Assuming that some people do not find the direct download 
button, and taking into account that 86% access 3 pages or less, that 
means that only 14% are interested enough in more information to 
actually access other information. 

It is fascinating that only 90.76% actually surf to our website using 
Windows, and a full 5.08% is Linux (MacOSX: 3.72%). Of course, in 
theory you could pretend, but then, I do not expect the average 
Windows user to know that this is even possible. 

Another interesting tidbit is that while Google helped most of the 
visitors find our webpage in the beginning, now it is only 35.81%, and 
a full 21.36% come via git-scm.com instead. 

It struck me as odd that the search terms "tortoisegit" and "tortoise 
git" were responsible for 7.71% of our traffic, when I thought that I 
made quite clear what I think of the TortoiseGit effort. 


Git Cheetah goes platform independent!
======================================

Recently, Heiko Voigt got interested in improving Git Cheetah, and to 
catch my attention worked on making the architecture 
platform-independent. 

He caught my attention, indeed, and Git Cheetah now works not only in 
the Microsoft Explorer, but also in MacOSX' Finder (for the moment, 
only up to Leopard; help for getting it to work on Snow Leopard is 
very much appreciated) and in GNOME's Nautilus (which should cover at 
least the American half of Linux users). 

Great stuff. 


Interview with Sebastian Schuberth
==================================

Recently I attended the GitTogether in Berlin, and for the first time 
had a chance to see the faces behind some email addresses, including 
Sebastian's. He is most known in the msysGit project for his huge 
effort to make a commercial-grade installer for Git for Windows. 

Somehow I managed during those years (msysGit is already 2.5 years old 
-- time flies like an arrow) to miss the fact that I did not honor 
Sebastian by interviewing him for the Herald yet. Let's undo that 
mistake. 

> 1) How did you get involved with Git? 

It all started when the management of the company I used to work for 
finally saw reason to move away from CVS. I was annoyed by CVS long 
before that, but my tries to get people to use SVN instead failed 
miserably, although I already had all the conversion done, mostly due 
to the management failing to see CVS' issues and being unwilling to 
spend resources on the migration, and some stubborn CVS command line 
junkies that did not want to learn new commands ;-) That was in 
October 2006. 

But as our SCM requirements got more demanding due to an increasing 
number of offices and cooperation partners at different sites, it 
became clear a DVCS would be beneficial. Steffen, who's involved in 
the msysGit project, too, was the contact person at one of our 
cooperation partners at that time. In the second half of 2007, IIRC, 
he evaluated Mercurial and Git, Git coming out as the winner. Not 
questioning his preference too much (as we were happy some one took 
the time to do a thorough test of both systems) and trusting Steffen's 
expertise, we agreed on giving Git a try. 

> 2) What were the reasons that you started working on Git? 

Being mainly a Windows developer, it quickly turned out that there was 
no nice Windows support in Git back then. There was Cygwin's Git, but 
it had several issues, and conflicted with our company policy to 
install Cygwin with text mode mounts. Digging a little further, I came 
across msysGit which was more what I wanted. At that time, msysGit was 
packaged a 7-Zip SFX, lacking the usual settings like creating 
shortcuts and uninstall capabilities which a Windows user would 
probably expect. This is when I started to work on an Inno Setup based 
installer that also creates hard-links on NTFS drives instead of 
making copies for the various Git commands etc. I just wanted to 
polish things a little bit in order to avoid colleagues who were not 
so fond of switching away from CVS from finding a reason to complain 
already when launching the Git installer ;-) Meanwhile, the installer 
has gained a lot of features and I think it does a good job at 
configuring the most basic Git settings in a nice and easy way, and it 
has paid off to replace the 7-Zip SFX installer. 

> 3) What do you like most in Git? 

As Git also was my first DVCS, I like several things about Git that 
are common across many DVCS. I find stashing changes, squashing 
commits and rebasing branches to be particularly useful features. 
Moreover, I like the simple fact that there's only one .git directory 
at the top of your working tree, and not in every sub-directory. Also, 
the reflog can be very handy if you messed something up :-) Using 
hashes instead of version / revision numbers also is a very practical 
thing. And I really adore Git for its speed on Linux (not on Windows, 
though, but I believe that's not Git's fault; it rather rather seems 
to be a general issue of how NTFS performs for a large number of small 
files). 

> 4) What do you hate most in Git? 

Hmm, hard to say. Instead of a single big issue that I would hate, 
there are some smaller issues that annoy me. For example, I still 
think the documentation is too technical and uses too much 
Git-specific vocabulary instead of using more common expressions. When 
working on Windows, I dislike that msysGit, as the name suggests, 
depends on MSYS and on tools from the Unix world. I believe all 
programs in the Git distribution should become binaries compiled for a 
specific platform, and not rely on shell interpreters or third-party 
languages like Tcl/Tk. 

> 5) What was the most surprising moment when working with Git? 

That big merges basically just work! It's so much less work doing 
merges with Git than with CVS, as Git just does the right thing, 
usually :-) 

> 6) What was the most frustrating moment when working with Git? 

Well, this is not so much about working *with* Git, but rather working 
*on* Git: I really cannot understand how submitting patches for 
upstream Git is still done via e-mail. We all know the benefits of 
Git, so we should make use of them! For example in the form of a mob 
branch like msysGit does. I've heard arguments before, like that it's 
easier to comment on patches inline if they're contained in an e-mail, 
but all that does not outweigh the advantages like getting rid of the 
various formatting / white-space issues that occur regularly and the 
time overhead for applying the patch to the correct branch. 

> 7) In what environment do you work? 

I work in a dual-boot environment with Windows Vista and Ubuntu 9.04. 
I recently upgraded my PC to an Intel Core i7 920 with 6 GB of RAM and 
a decent NVIDIA graphics board, as I do a lot of (GP)GPU stuff, mostly 
using OpenGL and CUDA / OpenCL. 

> 8) What other hobbies do you have? 

Besides involvement in other OSS projects and working on my own 
private programming projects, I also did and do several martial arts 
and ride the motorcycle. 

> 9) What is your favourite movie? 

That depends on the genre, but currently one of my all-time favorites 
is "Kung Fu Hustle" :-) 

> 10) What are your visions for Git? (I.e. where do you want it to 
go?) 

I'd really like to see Git becoming a first-choice for pure Windows 
developers, too, not only e.g. for people that need to make a project 
that already uses Git and works on Unix compile on Windows. And as 
much as I like the diversity of e.g. Git GUI tools, which is in the 
nature of every OSS project, I think for the sake of clarity for the 
users and to combine features and developing efforts, several projects 
should merge. For example, I doubt that we need something in the order 
of five different Git Windows Explorer shell extensions. 
