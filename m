From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: thread-safe libgit.a as a GSoC project, was Re: [SoC RFC] libsvn-fs-git:
 A git backend for the subversion filesystem
Date: Sat, 22 Mar 2008 12:35:26 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803221229410.4124@racer.site>
References: <3e8340490803182108y40a9aec2q8e5bcb78b907bbb5@mail.gmail.com> <3e8340490803212202r6dbaa9eel544ba2b4b8e8d0c7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Harvey Harrison <harvey.harrison@gmail.com>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Jakub Narebski <jnareb@gmail.com>
To: Bryan Donlan <bdonlan@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 22 12:36:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jd21C-0005NM-8c
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 12:36:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754495AbYCVLf3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2008 07:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754388AbYCVLf3
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Mar 2008 07:35:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:45893 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754341AbYCVLf2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2008 07:35:28 -0400
Received: (qmail invoked by alias); 22 Mar 2008 11:35:26 -0000
Received: from host86-148-26-43.range86-148.btcentralplus.com (EHLO racer.home) [86.148.26.43]
  by mail.gmx.net (mp022) with SMTP; 22 Mar 2008 12:35:26 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19pCfU7dalpTWqLEeqrXU0xdhRSj+J/T2p/SCodim
	Oqp7Imh/UAa9c+
X-X-Sender: gene099@racer.site
In-Reply-To: <3e8340490803212202r6dbaa9eel544ba2b4b8e8d0c7@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77798>

Hi,

On Sat, 22 Mar 2008, Bryan Donlan wrote:

> On Wed, Mar 19, 2008 at 12:08 AM, Bryan Donlan <bdonlan@gmail.com> wrote:
>
> >  I'm planning to apply for the git summer of code project. My proposal 
> >  is based on the project idea of a subversion gateway for git, 
> >  implemented with a new subversion filesystem layer. A draft of my 
> >  proposal follows; I'd appreciate any comments/questions on it before 
> >  the application period proper begins.
> 
> Thanks for all the comments. To try to avoid spamming the list, I've
> replied in a single message, if it'd be better to reply individually
> in the future please let me know.

My preference is to have single replies, possibly changing the subject 
("xyz, was Re: blabla"), but it is maybe just me.

> Also, after looking at libgit in a bit more detail, I think it might be 
> necessary to not use it after all, as subversion requires support for 
> multiple open repositories, as well as thread safety (at least when 
> accessing different open repo from different threads). Perhaps a 
> thread-safe git library would be a nice SoC project as well?

As I said on IRC yesterday, I think that such a libgit.a would be nice, 
_but_

- a lot of git programs expect to be one-shot, and libgit.a shows that,

- not many people will help you with your effort, but just ignore it and 
  actively introduce things that do not help libification (at least that's 
  my experience),

- unless you have a proper need for such a library, I do not think there 
  is enough motivation to actually get it to completion.

I once thought that libification would be nice, and important, but as I do 
not need it myself, I reversed my opinion.

Ciao,
Dscho
