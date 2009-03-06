From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH] git push: Push nothing if no refspecs are given or
 configured
Date: Fri, 6 Mar 2009 13:07:56 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903061306450.10279@pacific.mpi-cbg.de>
References: <20090305221529.GA25871@pvv.org> <fabb9a1e0903051418k3fb6c8baqd0189c772893844e@mail.gmail.com> <200903052322.02098.markus.heidelberg@web.de> <200903052325.44648.markus.heidelberg@web.de> <fabb9a1e0903051426p1222f151s8f466abf319706da@mail.gmail.com>
 <alpine.DEB.1.00.0903061124000.10279@pacific.mpi-cbg.de> <7v4oy7szze.fsf@gitster.siamese.dyndns.org> <20090306114812.GA19534@pvv.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	markus.heidelberg@web.de, git@vger.kernel.org,
	John Tapsell <johnflux@gmail.com>, Andreas Ericsson <ae@op5.se>
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Fri Mar 06 13:07:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfYqK-0007cl-Ri
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 13:07:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752624AbZCFMG3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 07:06:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751871AbZCFMG3
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 07:06:29 -0500
Received: from mail.gmx.net ([213.165.64.20]:50877 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751756AbZCFMG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 07:06:28 -0500
Received: (qmail invoked by alias); 06 Mar 2009 12:06:25 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp050) with SMTP; 06 Mar 2009 13:06:25 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX198MTEBVHF89bUetoLdUPOH61vN42su4eK8UCQYB4
	cLYku/XjNJa/ri
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090306114812.GA19534@pvv.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112429>

Hi,

On Fri, 6 Mar 2009, Finn Arne Gangstad wrote:

> On Fri, Mar 06, 2009 at 02:32:53AM -0800, Junio C Hamano wrote:
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > 
> > > On Thu, 5 Mar 2009, Sverre Rabbelier wrote:
> > >
> > >> On Thu, Mar 5, 2009 at 23:25, Markus Heidelberg
> > >> <markus.heidelberg@web.de> wrote:
> > >> > Oh, I confused "config option" with "command line argument"...
> > >> 
> > >> Right, I'd like to be able to do:
> > >> $ git config push.iamnotretarded true
> > >> $ git push
> > >
> > > LOL!  Sverre, you have a way to crack me up...
> > 
> > I found it amusing, too.
> > 
> > It may have some correlation with how well organized your work habit is,
> > but I do not think it has much correlation with being retarded.  It is
> > more about "'matching refs' is the perfect default for _my_ use pattern,
> > don't mess with it, please".
> 
> So here is my current WIP suggestion for a new "push.default"
> variable, I am not sure if a single entry can express all useful
> choices, or if it is a good idea to introduce more default choices
> other than "nothing" (with the goal of making it the default in a
> later release).

Speaking of which, Steffen (who cannot reply right now, since he is AFK 
for a while) had a patch to install "remote.<branch>.push = HEAD" with 
clone and remote.  Would that be better?

Ciao,
Dscho
