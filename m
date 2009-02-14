From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] config: Use parseopt.
Date: Sat, 14 Feb 2009 22:15:59 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902142213090.10279@pacific.mpi-cbg.de>
References: <1234577142-22965-1-git-send-email-felipe.contreras@gmail.com>  <7vab8pweod.fsf@gitster.siamese.dyndns.org>  <94a0d4530902140237o7d26ff4j1c7350d926d12c1a@mail.gmail.com>  <7vhc2wu8a0.fsf@gitster.siamese.dyndns.org>
 <94a0d4530902141209j7a3a9976l80355bee526852ed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 22:17:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYRsU-0003xR-1R
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 22:16:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754125AbZBNVPM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 16:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754121AbZBNVPK
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 16:15:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:44851 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754141AbZBNVPH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 16:15:07 -0500
Received: (qmail invoked by alias); 14 Feb 2009 21:15:05 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp069) with SMTP; 14 Feb 2009 22:15:05 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/SwKpSzIbSyDpKda5Y2fYXrUzNqICTXBjw6fWOtu
	ZOLHr/Rs6NZ01F
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <94a0d4530902141209j7a3a9976l80355bee526852ed@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109930>

Hi,

On Sat, 14 Feb 2009, Felipe Contreras wrote:

> On Sat, Feb 14, 2009 at 9:29 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > Felipe Contreras <felipe.contreras@gmail.com> writes:
> >
> >> This is more a "I would like to increase the chances of my patches 
> >> being accepted so I'd do some chores to gain the trust of some 
> >> developers", and Johannes Schindelin was pushing me to do this.
> >>
> >> Also it's a bit of "I would like to improve git and learn the API 
> >> while doing so".
> >
> > I personally do not think "I rewrote this command's option parser 
> > using parseopt" earns any "trust point".  I think the latter is a 
> > *great* thing to do, though.
> 
> I disagree. Making a patch pass through all the filters must mean 
> something, and the more patches the more trust.

Maybe I should point out something that is obvious to somebody who 
followed the Git list for a long time: there are two areas of the code 
that had such a track record of regressions that Junio grew a distaste for 
them: git-config and parse options.

However, I imagine if you manage to provide a patch that touches both 
areas _and_ that are without flaws, then you get some brownie points :-)

Ciao,
Dscho
