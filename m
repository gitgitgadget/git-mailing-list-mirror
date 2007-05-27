From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: GIT on MinGW problem
Date: Sun, 27 May 2007 11:46:00 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705271143310.4648@racer.site>
References: <1dbc01c79432$b4400a80$0200a8c0@AMD2500> <464534EE.30904@xs4all.nl>
 <4656A304.AF39A0B6@eudaptics.com> <f3a2ke$9s7$1@sea.gmane.org>
 <Pine.LNX.4.64.0705262318190.4648@racer.site> <4658BA64.2050904@xs4all.nl>
 <f3agkk$bhn$1@sea.gmane.org> <4659259D.4000803@xs4all.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
X-From: git-owner@vger.kernel.org Sun May 27 12:46:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsGGS-0004O0-DL
	for gcvg-git@gmane.org; Sun, 27 May 2007 12:46:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbXE0KqM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 06:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbXE0KqL
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 06:46:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:46408 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751270AbXE0KqK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 06:46:10 -0400
Received: (qmail invoked by alias); 27 May 2007 10:46:07 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp003) with SMTP; 27 May 2007 12:46:07 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/2foUpWo/2GmJLaPPP6sNmdm/0Kh5VQl+gU9oBh9
	oqMNP+52laUH8G
X-X-Sender: gene099@racer.site
In-Reply-To: <4659259D.4000803@xs4all.nl>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48528>

Hi,

On Sun, 27 May 2007, Han-Wen Nienhuys wrote:

> Jakub Narebski escreveu:
> 
> >> Instead, we have a Makefile that relies on an esoteric combination of 
> >> perl and shell scripting inside Makefiles.
> > 
> > The idea is to be able to get reasonable defaults (depending on system 
> > of
> 
> This saves the user on Linux or similar platform one ./configure call. 

It works on Linux, Cygwin, MinGW, last time I checked MacOSX, IRIX, and I 
imagine Solaris, AIX and even other platforms, out of the box.

> For the rest it means editing makefiles. I'm not sure if that is an 
> improvement over the standard
> 
>   configure ; make ; make install

ATM you have to do autoconf before that. But that should work, really.

Ciao,
Dscho
