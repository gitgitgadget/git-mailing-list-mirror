From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Move all dashed form git commands to libexecdir
Date: Fri, 30 Nov 2007 13:35:00 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711301334500.27959@racer.site>
References: <20071127150229.GA14859@laptop>  <Pine.LNX.4.64.0711271617350.27959@racer.site>
  <20071128000731.GD9174@efreet.light.src>  <7v8x4jb295.fsf@gitster.siamese.dyndns.org>
  <fcaeb9bf0711280036p33583824ge59af93bbe3f0a78@mail.gmail.com> 
 <7vfxyq2c9b.fsf@gitster.siamese.dyndns.org> 
 <fcaeb9bf0711281917p56cc4228m6c401286439e2a34@mail.gmail.com> 
 <alpine.LFD.0.99999.0711290905510.9605@xanadu.home> 
 <7vd4tsvfvk.fsf@gitster.siamese.dyndns.org>  <DB613F3E-85CC-4AF0-928C-4F4E4C8E9FB8@orakel.ntnu.no>
 <fcaeb9bf0711300419i9cf70eo9f96e3a5e3f44585@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Eyvind Bernhardsen <eyvind-git-list@orakel.ntnu.no>,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@cam.org>, Jan Hudec <bulb@ucw.cz>,
	git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 30 14:35:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iy61v-0002oS-OH
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 14:35:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756234AbXK3NfW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2007 08:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755238AbXK3NfU
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 08:35:20 -0500
Received: from mail.gmx.net ([213.165.64.20]:35329 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752242AbXK3NfS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2007 08:35:18 -0500
Received: (qmail invoked by alias); 30 Nov 2007 13:35:15 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp030) with SMTP; 30 Nov 2007 14:35:15 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19PLE1SzohP9Hx2CgOK2WvtUDRfXp5tiKVz3ugQwm
	0vFuL+cwbWyHag
X-X-Sender: gene099@racer.site
In-Reply-To: <fcaeb9bf0711300419i9cf70eo9f96e3a5e3f44585@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66642>

Hi,

On Fri, 30 Nov 2007, Nguyen Thai Ngoc Duy wrote:

> On Nov 30, 2007 6:28 PM, Eyvind Bernhardsen
> <eyvind-git-list@orakel.ntnu.no> wrote:
> > On 29. nov. 2007, at 23.36, Junio C Hamano wrote:
> >
> > [...]
> >
> > > If people are really serious about reducing the number of commands in
> > > the path, I would expect fixes and bugreports saying "I am setting
> > > gitexecdir different from bindir in _my_ installation when I build
> > > git,
> > > and here are the things that does not work if I do so".  Within the
> > > span
> > > of more than 20 months (77cb17e9 introduced gitexecdir in Jan 2006), I
> > > do not think there was a single such report or patch, other than the
> > > message from Nguyen that started this thread.
> >
> > I'm setting gitexecdir different from bindir in my installation, and
> > here are the things that don't work:
> >
> > - When pushing to my system over ssh, git-receive-pack and git-upload-
> > pack are expected to be in $PATH.  I resolved the problem by putting
> > symlinks in /usr/local/bin.
> >
> > I haven't seen any other problems, but then again, I only use git
> > plumbing commands and my own scripts.
> 
> You remind me my experience of making every external C-based command
> builtin. There is another case: git-merge. It calls  something like
> git-merge-$strategy.

Good catch!

Ciao,
Dscho
