From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Documentation/git svn log: add a note about timezones.
Date: Wed, 27 Feb 2008 12:33:22 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802271231080.22527@racer.site>
References: <20080226124748.GH31792@mail.stoakes.net> <20080227073244.GB24316@soma> <20080227102631.GJ30300@mail.stoakes.net> <alpine.LSU.1.00.0802271039220.22527@racer.site> <20080227122929.GS31441@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Tim Stoakes <tim@stoakes.net>,
	Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Feb 27 13:34:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JULUm-0003iT-9r
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 13:34:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754840AbYB0Mdz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 07:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754855AbYB0Mdz
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 07:33:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:54484 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754836AbYB0Mdy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 07:33:54 -0500
Received: (qmail invoked by alias); 27 Feb 2008 12:33:52 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp021) with SMTP; 27 Feb 2008 13:33:52 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+dHMoCTxydoGalOY2YxPFb0g7r4ABQRW30q87EF4
	jo2d1qRJk2yD0h
X-X-Sender: gene099@racer.site
In-Reply-To: <20080227122929.GS31441@genesis.frugalware.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75225>

Hi,

On Wed, 27 Feb 2008, Miklos Vajna wrote:

> git svn log mimics the timezone converting behaviour of svn log, but this was

This line is definitely too long.  Please make commit messages readable on 
an 80-character display with a 4-character indent, i.e. 76 
characters/line.

> On Wed, Feb 27, 2008 at 10:40:37AM +0000, Johannes Schindelin 
> <Johannes.Schindelin@gmx.de> wrote:
> > Note: if all you want is such a strange behaviour as svn's (I mean, 
> > why does it insist to show the dates as if they were done in _your_ 
> > timezone?):
> >
> >       git log --date=local
> >
> > > Is it documented anywhere?
> >
> > AFAICT it waits to be written.  By you.
> 
> something like this?

Yes, very nice.  Although I find it sad that an opportunity was lost for a 
complainer to make good.

> diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
> index 340f1be..e1babf3 100644
> --- a/Documentation/git-svn.txt
> +++ b/Documentation/git-svn.txt
> @@ -160,6 +160,10 @@ New features:
>  --
>  +
>  Any other arguments are passed directly to `git log'
> ++
> +NOTE: SVN itself only stores times in UTC and nothing else. The regular svn
> +client converts the UTC time to the local time (or based on the TZ=
> +environment). This command has the same behaviour.
>  
>  'blame'::
>         Show what revision and author last modified each line of a file. This is

I think that this note should come before the "Any other arguments" line.

Ciao,
Dscho
