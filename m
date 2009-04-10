From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Ability to edit message from git rebase --interactive.
Date: Fri, 10 Apr 2009 20:21:30 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904102019250.10279@pacific.mpi-cbg.de>
References: <200903171953.23650.ogoffart@kde.org>  <alpine.DEB.1.00.0903172329480.10279@pacific.mpi-cbg.de>  <200904101417.56422.ogoffart@kde.org> <b4087cc50904100537j64e8fef1u157c717fe4d8207b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1483909370-1239387690=:10279"
Cc: Olivier Goffart <ogoffart@kde.org>, git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 10 20:20:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsLKz-0007GW-Np
	for gcvg-git-2@gmane.org; Fri, 10 Apr 2009 20:20:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932415AbZDJSSy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Apr 2009 14:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765982AbZDJSSx
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Apr 2009 14:18:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:57880 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1764569AbZDJSSw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Apr 2009 14:18:52 -0400
Received: (qmail invoked by alias); 10 Apr 2009 18:18:50 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp065) with SMTP; 10 Apr 2009 20:18:50 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19mGrRAcZJmKnZfd5Qw93iLdTp/zzRVDiw3wvXeRZ
	gTdARqxxtGcP8R
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <b4087cc50904100537j64e8fef1u157c717fe4d8207b@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116271>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1483909370-1239387690=:10279
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 10 Apr 2009, Michael Witten wrote:

> On Fri, Apr 10, 2009 at 07:17, Olivier Goffart <ogoffart@kde.org> wrote:
> > Hi,
> > Sorry I'm late to reply :-)
> >
> > I still think this feature to edit the message in git rebase -i is really
> > usefull.  So 'm' is really taken, what about 'r' for 'rephrase'?
> >
> > or maybe 'rephrase' is something different?
> 
> How about 'a' for an immediate [a]mend?

git commit --amend lets you amend the modifications in addition to the 
message, so I think it would be too ambiguous.

FWIW I planned to split my rebase-i-p patch series into two parts: the 
first part adding a few commands, and the second part actually making it 
possible to rebase interactively _and_ preserving merges.  (So far, if you 
used -p, you better did not reorder or delete any lines.)

However, this will have to wait until after Easter.

Ciao,
Dscho

--8323328-1483909370-1239387690=:10279--
