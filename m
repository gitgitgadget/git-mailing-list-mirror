From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/3] Add a "fix" command to "rebase --interactive"
Date: Fri, 4 Dec 2009 19:47:17 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0912041945161.21557@intel-tinevez-2-302>
References: <cover.1259934977.git.mhagger@alum.mit.edu> <4B192701.4000308@drmicha.warpmail.net> <vpqfx7qocwl.fsf@bauges.imag.fr> <7vws12r5v2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 04 19:47:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGdBg-0003Z4-Ih
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 19:47:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755306AbZLDSrR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 13:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755013AbZLDSrQ
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 13:47:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:51339 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754712AbZLDSrQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 13:47:16 -0500
Received: (qmail invoked by alias); 04 Dec 2009 18:47:21 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp021) with SMTP; 04 Dec 2009 19:47:21 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19L/gNhLBlLbigAjQruiKP1ZBf6Y0i7tyQluauh57
	5T6MuDl0jHfZkH
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <7vws12r5v2.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134566>

Hi,

On Fri, 4 Dec 2009, Junio C Hamano wrote:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
> 
> > Michael J Gruber <git@drmicha.warpmail.net> writes:
> >
> >>> If the idea of a "fix" command is acceptable, then I would like to
> >>> implement a further convenience: if a group of commits to be folded
> >>> together includes *only* "fix" commits, then the first log message
> >>> should be used without even opening an editor.  But I would like to
> >>> get a reaction to the "fix" command in general before doing so.
> >>
> >> I'd say that would make a useful command ("fix") even more useful, being
> >> just the right counterpart to "reword" for trivial commit message fixes.
> >
> > +1 for fix, and +1 for the "don't even launch the editor" too.
> 
> I like it, too.  Also I vaguely recall that there was a series that died
> that would have allowed you to give hints to help this behaviour at the
> time you make "fix-up" commits; we may want to resurrect it on top of this
> feature.

I'll just repeat this exactly one more time: it is not always possible to 
know whether you make a fix-up commit, and it is not always possible to be 
sure that you want to amend the next time you do a rebase.

So: Commit time is definitely a bad time to decide on the action in some 
future rebase event.

Ciao,
Dscho
