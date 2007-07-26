From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Windows support
Date: Thu, 26 Jul 2007 15:37:21 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707261534550.14781@racer.site>
References: <a1bbc6950707250335m3d37d4farceffc50945e31f6c@mail.gmail.com> 
 <7vps2fc196.fsf@assigned-by-dhcp.cox.net>  <20070726031838.GO32566@spearce.org>
  <7v6447bxc1.fsf@assigned-by-dhcp.cox.net>  <Pine.LNX.4.64.0707260614500.14781@racer.site>
  <46A8378A.6050201@xs4all.nl>  <Pine.LNX.4.64.0707260737170.14781@racer.site>
  <f329bf540707260002p117937tc9bc70050ef87838@mail.gmail.com> 
 <fcaeb9bf0707260429l327f446bq73a8a0a13cd77cf1@mail.gmail.com> 
 <46d6db660707260521u15c2bd85j806d48e0f51a3b9@mail.gmail.com>
 <fcaeb9bf0707260537y4233abaamadf4cb6190ea0eeb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 16:37:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IE4T5-0007RR-5C
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 16:37:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753808AbXGZOh1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 10:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755158AbXGZOh1
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 10:37:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:58677 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753702AbXGZOh0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 10:37:26 -0400
Received: (qmail invoked by alias); 26 Jul 2007 14:37:24 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp058) with SMTP; 26 Jul 2007 16:37:24 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Sx75M0zDSO+COWeyDD8JUUXahgwNFdxD0dmBKTI
	jokR0HWG9QZvXa
X-X-Sender: gene099@racer.site
In-Reply-To: <fcaeb9bf0707260537y4233abaamadf4cb6190ea0eeb@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53836>

Hi,

On Thu, 26 Jul 2007, Nguyen Thai Ngoc Duy wrote:

> On 7/26/07, Christian MICHON <christian.michon@gmail.com> wrote:
> > On 7/26/07, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> > > microperl [1] maybe? I haven't tried it yet.
> > >
> > 
> > it won't work. I tried that few months back.
> > 
> > plus the fact you'll still need perl modules.
> > 
> > I just had a look at your gitbox gitweb. Did you really manage
> > to get busybox-1.6.1 to work with mingw ?
> 
> Most of tools (that are included) work fine. Ash almost works. It can 
> run git status, git commit, git clone.. and most of test cases. There 
> are still some missing pieces and bugs to hunt down though.

Thank you for working on this!

However, I am not completely convinced that having a builtin shell is all 
that useful.  I for one would like to have MinGW busybox _separate_ from 
git...

Yes, you could not use the nice "ln -s busybox ash" idiom, since Windows 
lacks symlinks, but you could still say "busybox ash" with a relatively 
small, single executable.

Ciao,
Dscho
