From: "Matthias Andree" <matthias.andree@gmx.de>
Subject: Re: Google Code: Support for Mercurial and Analysis of Git and
 Mercurial
Date: Sun, 26 Apr 2009 13:47:03 +0200
Message-ID: <op.uszscpuf1e62zd@merlin.emma.line.org>
References: <200904260703.31243.chriscool@tuxfamily.org>
 <m363grq13i.fsf@localhost.localdomain>
 <op.uszlmeoo1e62zd@merlin.emma.line.org> <200904261209.08108.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "git.vger.kernel.org" <git@vger.kernel.org>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 12:37:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ly2r3-00061p-Qr
	for gcvg-git-2@gmane.org; Sun, 26 Apr 2009 13:49:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752974AbZDZLrK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Apr 2009 07:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752675AbZDZLrJ
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Apr 2009 07:47:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:33140 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750710AbZDZLrH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Apr 2009 07:47:07 -0400
Received: (qmail invoked by alias); 26 Apr 2009 11:47:05 -0000
Received: from g226233177.adsl.alicedsl.de (EHLO mandree.no-ip.org) [92.226.233.177]
  by mail.gmx.net (mp006) with SMTP; 26 Apr 2009 13:47:05 +0200
X-Authenticated: #428038
X-Provags-ID: V01U2FsdGVkX1815vkYrCM11rIvrlGTWywgKkKUZ6CesXfqtKkRos
	IKyy60dEhv4Cb/
Received: from merlin.emma.line.org (localhost [127.0.0.1])
	by merlin.emma.line.org (Postfix) with ESMTP id 1243F940DF;
	Sun, 26 Apr 2009 13:47:03 +0200 (CEST)
In-Reply-To: <200904261209.08108.jnareb@gmail.com>
User-Agent: Opera Mail/9.64 (Linux)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.52
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117647>

Am 26.04.2009, 12:09 Uhr, schrieb Jakub Narebski <jnareb@gmail.com>:

> On Sun, 26 April 2009, Matthias Andree wrote:
>> Am 26.04.2009, 10:16 Uhr, schrieb Jakub Narebski <jnareb@gmail.com>:
>>
>> > I can't comment on MS Windows support, but AFAIK Mercurial has better
>> > support here than Git.
>>
>> I have some experience here, and with exception to the SVN 1.6 breaks
>> git-svn for https:// (probably due to misbehaviour of APR or SVN stuff  
>> on
>> Cygwin), it works flawless on Cygwin 1.5. (SVN 1.5 on Cygwin 1.5 or SVN
>> 1.6 on Cygwin 1.7 seem to work).
>>
>> I wonder why people are always pissed at Cygwin - it's quite easy to  
>> setup and works.
>
> Well, but you have to install Cygwin (or use MsysGit, which isn't there
> yet).  On the other hand you need to install Python for Mercurial...
> but perhaps it is bundled in Windows install package for Mercurial.

AFAIR Mercurial is compiled through py2exe, but I'd have to look again  
what that actually means WRT Python installations.

> Beside it isn't only about being easy to install and use (and have
> decent enough performance) given SCM on MS Windows, but also about
> tools such like TortoiseHg and VisualHg (as Windows users are usually
> not used to using CLI alone).  Although also this improves for Git,
> with TortoiseGit, Git Extensions and git-cheetah.  And I think it was
> much worse (for Git vs Mercurial) at the time the analysis in question
> was conducted.

I wonder why people always talk about "not being used to console" or  
whatever. These captive GUIs serialize work and tend to get in the way. It  
may be different for beasts like Eclipse, but I haven't tried the latter.

I have yet to see any TortoiseCrap that does not smell. Judging from  
Tortoise{CVS,SVN,Hg}, they are feature-limited, cumbersome-to-use  
frontends where a command line client would be much faster. However you  
can't mix Unix versions of SCM exes and Tortoise-compiled exes easily due  
to differing [CR-]LF conventions.

I've done away with all that TortoiseCrap and use SCM from the command  
line.

I acknowledge that code browsing as in gitk or git-gui is more concise  
than a shell at times, but that doesn't warrant Tortoise* Explorer  
extension stuff which only wraps the trivial operations anyhow.

My opinion is that if people can't be bothered to learn the few SCM  
commands, they won't fully understand what Tortoises creep to do, and then  
they shouldn't be let anywhere near any kind of shell - graphical or text  
console - anyways.

> As you can find in mailing list archives the design part of "tunelling"
> pack protocol over HTTP, using git-aware server (for example some CGI
> script, or simple HTTP server like Mercurial's hg-serve), is done.  Even
> taking into account the fact that HTTP protocol by itself is stateless.
> Unfortunately development itself of "smart" HTTP server for Git got
> stalled... if it was present, the conclusion of mentioned analysis might
> have been different.  OTOH perhaps it would be not, as it is my  
> impression that Google Code stuff is either Python or Java...

I don't care much about Google anything, to be frank.

> P.S. I wonder what happened to GMane interface... seems stalled.

What's so difficult about mailing "subscribe git MY@ADDRE.SS.example" to  
majordomo at vger dot kernel dot org?

-- 
Matthias Andree
