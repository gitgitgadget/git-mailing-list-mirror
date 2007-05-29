From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: GIT on MinGW problem
Date: Tue, 29 May 2007 13:11:27 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705291305540.4648@racer.site>
References: <1dbc01c79432$b4400a80$0200a8c0@AMD2500> <464534EE.30904@xs4all.nl>
 <4656A304.AF39A0B6@eudaptics.com> <f3a2ke$9s7$1@sea.gmane.org>
 <465C064F.B9CE9379@eudaptics.com> <465C1252.9020801@trolltech.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Tue May 29 14:12:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ht0YZ-0003v5-Ic
	for gcvg-git@gmane.org; Tue, 29 May 2007 14:12:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751534AbXE2MLn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 May 2007 08:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751637AbXE2MLn
	(ORCPT <rfc822;git-outgoing>); Tue, 29 May 2007 08:11:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:34790 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751534AbXE2MLm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2007 08:11:42 -0400
Received: (qmail invoked by alias); 29 May 2007 12:11:40 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp046) with SMTP; 29 May 2007 14:11:40 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+oUEMJi4eo/PjHj0leUnvLBjIC3ReOHOdheY74vl
	l2Dsf78i89caer
X-X-Sender: gene099@racer.site
In-Reply-To: <465C1252.9020801@trolltech.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48687>

Hi,

On Tue, 29 May 2007, Marius Storm-Olsen wrote:

> Johannes Sixt said the following on 29.05.2007 12:54:
> > Han-Wen Nienhuys wrote:
> > > Johannes Sixt escreveu:
> > > > * git without an correct git subcommand should list 20 or so
> > > > commands, but it doesn't. The list is just empty.
> > > there was a problem in generate cmd list,  (I have sort in /bin/
> > > ). I recommend to add
> > 
> > Strange. Here, MSYS aliases /usr to /, hence /usr/bin/sort is the
> > same as /bin/sort.
> > 
> > (For the curious ones: The MinGW port has to replace occurrences of
> > 'sort' by '/usr/bin/sort', otherwise Windows's 'sort' would be
> > picked up in shell scripts, because the latter usually comes first
> > in %PATH%^W$PATH. Same for 'find'.)
> 
> I get that here too, no matter what I set the mount point to be, and without
> the fstab file at all.
> 
> Also, the /bin/gitk.bat file should rather be
>     @"%~d0%~p0wish84.exe" "%~d0%~p0gitk" %*
> than the current hardcoded path. (Probably won't work with command.com, but
> who uses that for development nowadays anyways, right ;-)

We're open source, so we _can_ do better than leaving people stuck on 
older hardware behind.

And I don't know what this garbage means. (I checked with GMane, and it 
looks the same there.) I'd rather have something readable, even if it is 
slightly slower or has to be adjusted when installing.

Ciao,
Dscho
