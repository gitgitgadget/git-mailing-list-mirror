From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Git config file reader in Perl (WIP)
Date: Thu, 18 Jan 2007 01:50:45 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701180146060.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200701150144.56793.jnareb@gmail.com>  <7vwt3nxnak.fsf@assigned-by-dhcp.cox.net>
  <Pine.LNX.4.63.0701161206050.22628@wbgn013.biozentrum.uni-wuerzburg.de> 
 <200701161514.47908.jnareb@gmail.com>  <dbfc82860701161417r650bc47fva92fa940b4e2cfc0@mail.gmail.com>
  <Pine.LNX.4.63.0701162337330.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <dbfc82860701171008r65006b60vf81df9f82ab25712@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, Junio C Hamano <junkio@cox.net>,
	Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 18 01:50:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7LUR-0000lN-RQ
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 01:50:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751762AbXARAus (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Jan 2007 19:50:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751864AbXARAus
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jan 2007 19:50:48 -0500
Received: from mail.gmx.net ([213.165.64.20]:43602 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751762AbXARAur (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jan 2007 19:50:47 -0500
Received: (qmail invoked by alias); 18 Jan 2007 00:50:46 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp044) with SMTP; 18 Jan 2007 01:50:46 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Nikolai Weibull <now@bitwi.se>
In-Reply-To: <dbfc82860701171008r65006b60vf81df9f82ab25712@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37051>

Hi,

On Wed, 17 Jan 2007, Nikolai Weibull wrote:

> On 1/16/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> > On Tue, 16 Jan 2007, Nikolai Weibull wrote:
> > 
> > > And, as Johannes already pointed out, it's very disturbing having to
> > > dump a configuration file so that it is more easily read by other
> > > programs.
> > 
> > I never pointed out such a thing. The configuration file is meant to be
> > user-friendly, as the inventor did not mean to have a program like
> > git-repo-config.
> 
> Then what did you mean in your mail from Jan 16, 2007 12:12 PM:
> 
>  How silly would that be: we parse an easy-to-read format,
>  munge the easy-to-handle internal data format into another "easy-to-read"
>  format which is then parsed by a script language into an easy-to-handle
>  internal data format? No. NO.
> 
> ?

It was about the human-readable -> internal -> human-readable -> internal
chain. Those are way too many transformations for little gain.

IMHO modern programs spend 99% of the time are spent transforming data. 
Most of them is unnecessary. That's bad.

> > > That would suggest that the ini-based format for git's configuration
> > > file is suboptimal.
> 
> > Not at all. Again, git's configuration file is meant for human inspection.
> > Therefore, an ini-style file is optimal.
> 
> It is suboptimal because it's hard for computers to inspect.  An
> optimal format would be accessible by all, whether human, machine,
> robot, android, what have you.

There's a reason we program in C, Java, etc. and not in Assembler. 
Sometimes computers and humans are too different to be able to cater for 
both of them at the same time.

I know, I know. The geek inside me disagrees, too. But my experience 
doesn't.

Ciao,
Dscho
