From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] builtin-remote: make rm operation safer in mirrored 
 repository
Date: Tue, 3 Feb 2009 15:53:54 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902031553310.6573@intel-tinevez-2-302>
References: <76718490902020536g6f4bcee2i76ee046a8dc7d46@mail.gmail.com>  <1233600014-82346-1-git-send-email-jaysoffian@gmail.com>  <20090203072418.GD21367@sigill.intra.peff.net>  <7vy6woc5vv.fsf@gitster.siamese.dyndns.org>
 <76718490902030638y36299191i1fcc2ab8646b9593@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 03 15:55:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUMgO-0000GT-Bo
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 15:55:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752583AbZBCOx7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 09:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752496AbZBCOx6
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 09:53:58 -0500
Received: from mail.gmx.net ([213.165.64.20]:51194 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751134AbZBCOx6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 09:53:58 -0500
Received: (qmail invoked by alias); 03 Feb 2009 14:53:55 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp068) with SMTP; 03 Feb 2009 15:53:55 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/biEBvflrbeA23KQ1XgatGebQzYiwdwqnsln0gHX
	tL88ZtKlSDKUGC
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <76718490902030638y36299191i1fcc2ab8646b9593@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108194>

Hi,

On Tue, 3 Feb 2009, Jay Soffian wrote:

> On Tue, Feb 3, 2009 at 2:54 AM, Junio C Hamano <gitster@pobox.com> wrote:
> > Jeff King <peff@peff.net> writes:
> >> However, I have one small nit. The output produces long lines with a lot
> >> of repeated text (assuming you have multiple matched branches, which is
> >> likely if you have a mirrored setup). So maybe it would be nicer to have
> >> something like:
> >>
> >>   warning: non-remote branches were not removed; you can delete them with:
> >>           git branch -d master
> >>           git branch -d next
> >>           git branch -d topic
> >>
> >> which is a little more obvious (to me, anyway), and allows you to cut
> >> and paste if you really did want to delete them.
> >
> > Thanks for a review, and I actually shared that exact nit when I first
> > read the patch.  It would be a very good change to collect them in a list
> > and show a single warning at the end (I do not have particular preference
> > about the cut & paste-ability either way myself).
> 
> This is a tough crowd. I'll see what I can do.

We polish it until it shines! :-)

Thank you for you efforts,
Dscho
