From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] init: support --import to add all files and commit
  right after init
Date: Fri, 27 Mar 2009 03:03:07 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903270259470.10279@pacific.mpi-cbg.de>
References: <1237978720-2500-1-git-send-email-pclouds@gmail.com> <20090325124219.GA5307@coredump.intra.peff.net> <adf1fd3d0903250549l60e4a2d1j8bd57ba66d24a678@mail.gmail.com> <200903262223.28546.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1220136861-1238119388=:10279"
Cc: =?ISO-8859-15?Q?Santi_B=E9jar?= <santi@agolina.net>,
	Jeff King <peff@peff.net>,
	=?VISCII?Q?Nguy=ADn_Th=E1i_Ng=F7c?= <pclouds@gmail.com>,
	git@vger.kernel.org
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Fri Mar 27 03:02:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ln1Oz-000276-1h
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 03:02:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758565AbZC0CBA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 22:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757188AbZC0CBA
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 22:01:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:50039 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756871AbZC0CA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 22:00:59 -0400
Received: (qmail invoked by alias); 27 Mar 2009 02:00:56 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp045) with SMTP; 27 Mar 2009 03:00:56 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18RwGQaFxUR3BJdATEeSxNnaiL5jVQr2xBI8X0JqO
	rx2A+5CF2NUGvR
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <200903262223.28546.markus.heidelberg@web.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114839>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1220136861-1238119388=:10279
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Thu, 26 Mar 2009, Markus Heidelberg wrote:

> Santi Béjar, 25.03.2009:
> > 2009/3/25 Jeff King <peff@peff.net>:
> > > On Wed, Mar 25, 2009 at 01:38:30PM +0100, Johannes Schindelin wrote:
> > >
> > >> > > +If no message is given, "Initial commit" will be used.
> > >> >
> > >> > Why a default message and not running the editor?
> > >>
> > >> Because I would say "Initial commit" anyway.
> > 
> > And I would say "Commit inicial".
> 
> And I would describe the current state in a few words.
> 
> Invoking an editor is more universal and I don't think the majority
> would be contented with "Initial commit".

_Again_, as Peff pointed out, you are welcome to use the current method of 
git init && git add . && git commit, which _does_ launch an editor.

The fact that you want to spend much time (anyway) doing your initial 
commit does not allow you to inconvenience others.

Others who want to have a quick way to work safely with something they 
might need to change, and might then want to use the full power of Git to 
see what they changed.  Without any need for a "nice" first commit.

Ciao,
Dscho

--8323328-1220136861-1238119388=:10279--
