From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH] git push: Push nothing if no refspecs are given or
 configured
Date: Sat, 7 Mar 2009 00:00:20 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903062359490.10279@pacific.mpi-cbg.de>
References: <20090305221529.GA25871@pvv.org> <fabb9a1e0903051418k3fb6c8baqd0189c772893844e@mail.gmail.com> <200903052322.02098.markus.heidelberg@web.de> <200903052325.44648.markus.heidelberg@web.de> <fabb9a1e0903051426p1222f151s8f466abf319706da@mail.gmail.com>
 <alpine.DEB.1.00.0903061124000.10279@pacific.mpi-cbg.de> <7v4oy7szze.fsf@gitster.siamese.dyndns.org> <20090306114812.GA19534@pvv.org> <alpine.DEB.1.00.0903061306450.10279@pacific.mpi-cbg.de> <m3r61aisdo.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Finn Arne Gangstad <finnag@pvv.org>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	markus.heidelberg@web.de, git@vger.kernel.org,
	John Tapsell <johnflux@gmail.com>, Andreas Ericsson <ae@op5.se>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 07 00:00:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lfj1f-0004Yz-9y
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 00:00:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755934AbZCFW6v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 17:58:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753070AbZCFW6v
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 17:58:51 -0500
Received: from mail.gmx.net ([213.165.64.20]:50795 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754522AbZCFW6u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 17:58:50 -0500
Received: (qmail invoked by alias); 06 Mar 2009 22:58:47 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp045) with SMTP; 06 Mar 2009 23:58:47 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19/Ruhs8nN/DmdppL/gGZg2x+V0QMwT2Zzhz4QnCM
	pANkTxzASoJtDO
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <m3r61aisdo.fsf@localhost.localdomain>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112491>

Hi,

On Fri, 6 Mar 2009, Jakub Narebski wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > On Fri, 6 Mar 2009, Finn Arne Gangstad wrote:
> >> On Fri, Mar 06, 2009 at 02:32:53AM -0800, Junio C Hamano wrote:
> >>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >>>> On Thu, 5 Mar 2009, Sverre Rabbelier wrote:
> >>>>> 
> >>>>> Right, I'd like to be able to do:
> >>>>> $ git config push.iamnotretarded true
> >>>>> $ git push
> >>>>
> >>>> LOL!  Sverre, you have a way to crack me up...
> >>> 
> >>> I found it amusing, too.
> >>> 
> >>> It may have some correlation with how well organized your work habit is,
> >>> but I do not think it has much correlation with being retarded.  It is
> >>> more about "'matching refs' is the perfect default for _my_ use pattern,
> >>> don't mess with it, please".
> >> 
> >> So here is my current WIP suggestion for a new "push.default"
> >> variable, I am not sure if a single entry can express all useful
> >> choices, or if it is a good idea to introduce more default choices
> >> other than "nothing" (with the goal of making it the default in a
> >> later release).
> > 
> > Speaking of which, Steffen (who cannot reply right now, since he is AFK 
> > for a while) had a patch to install "remote.<branch>.push = HEAD" with 
> > clone and remote.  Would that be better?
> 
> Errr... I thought that "remote.<remotename>.push = HEAD" works?
> 
> But note that "remote.<name>.push = HEAD" (push current branch only)
> and "remote.<name>.push = :" (push matching branches, i.e. curent
> behavior) works only if you have remote configured... "git push <URL>"
> won't be affected, and people (probably) would want to either have
> 'nothing' as default, or/and be able to configure it to nothing,
> current, or matching (at least).

The question was not if remote.<remote>.push = HEAD works, but if it is 
installed by default.

Ciao,
Dscho
