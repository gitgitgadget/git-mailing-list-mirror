From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] completion: add branch options --contains --merged
 --no-merged
Date: Tue, 8 Jul 2008 13:36:43 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807081335470.4319@eeepc-johanness>
References: <279b37b20807071341k3551e61cl10c5969600ba8218@mail.gmail.com> <20080708044922.GD2542@spearce.org> <7vprppvt7a.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Eric Raible <raible@gmail.com>,
	Git Mailing List <git@vger.kernel.org>, szeder@ira.uka.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 13:37:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGBVl-000314-UO
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 13:37:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754449AbYGHLgg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 07:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754442AbYGHLgg
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 07:36:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:33541 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754327AbYGHLgf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 07:36:35 -0400
Received: (qmail invoked by alias); 08 Jul 2008 11:36:33 -0000
Received: from 88-107-253-132.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.253.132]
  by mail.gmx.net (mp006) with SMTP; 08 Jul 2008 13:36:33 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/1rBxS1Fb1vGzTyVvmtPc+/nq4JFW3xaY5n9yhZd
	fLwhADIuoI5p4F
X-X-Sender: user@eeepc-johanness
In-Reply-To: <7vprppvt7a.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87752>

Hi,

On Mon, 7 Jul 2008, Junio C Hamano wrote:

> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > Eric Raible <raible@gmail.com> wrote:
> >> Signed-off-by: Eric Raible <raible@gmail.com>
> >
> > Trivially-Acked-by: Shawn O. Pearce <spearce@spearce.org>
> >
> > ;-)
> >
> > More completion support that probably should go to maint, as the
> > functionality in git-branch is in 1.5.6 but we (again) forgot to
> > make sure the completion was up-to-date prior to release.
> 
> I am actually getting more worried about completion code getting larger
> and larger without its performance impact not being looked at nor
> addressed adequately.  In my regular working tree:
> 
> 	$ echo Docu<TAB>
> 
> completes "mentation/" instantly, but:
> 
> 	$ git log -- Docu<TAB>
> 
> takes about 1.5 to 2 seconds to complete the same.

I noticed that myself, but did not have time to look into it.

It shows two bugs, actually: completions do not care about "--", and 
completing refs takes way too long.

Ciao,
Dscho
