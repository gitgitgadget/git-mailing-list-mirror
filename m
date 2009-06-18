From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Re: rebase -i: auto-squash commits
Date: Thu, 18 Jun 2009 10:33:43 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0906181030260.4848@intel-tinevez-2-302>
References: <e1868cfe0906170506o37a75c35m47f9456bf8ae47c1@mail.gmail.com> <43d8ce650906170555m644564b3v3722168f7217c326@mail.gmail.com> <7vvdmurfao.fsf@alter.siamese.dyndns.org> <20090618063348.6117@nanako3.lavabit.com> <alpine.DEB.1.00.0906180007370.26154@pacific.mpi-cbg.de>
 <20090618001111.GB12954@vidovic> <7v8wjq2kqc.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0906181003300.4848@intel-tinevez-2-302> <7vk53aymuz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	John Tapsell <johnflux@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 18 10:33:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHD4E-0006cQ-6C
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 10:33:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752401AbZFRIdo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2009 04:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752309AbZFRIdo
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 04:33:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:59337 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750978AbZFRIdn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2009 04:33:43 -0400
Received: (qmail invoked by alias); 18 Jun 2009 08:33:44 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp046) with SMTP; 18 Jun 2009 10:33:44 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19J9x8u56JJt7U9rSwfpZvf41JoHEYl3YvtYQMRcK
	KOJcsU7MWlMoFc
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <7vk53aymuz.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121815>

Hi,

On Thu, 18 Jun 2009, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Wed, 17 Jun 2009, Junio C Hamano wrote:
> > ...
> >> The commit not only must begin with "squash to " but also there has to 
> >> be a matching commit whose message begins with the remainder of the 
> >> title of the "squash to" commit _in the range you are rebasing 
> >> INTERACTIVELY_.
> >> 
> >> In addition, the resulting rebase insn is presented in the editor, and 
> >> in a rare case where you do have such a commit, you can rearrange it 
> >> back.
> >
> > Well, that really sounds pretty awkward to me.  I regularly call such 
> > commits "amend".  If there is a risk I confuse myself as to which commit 
> > needs to be amended, I use "amend.<short-hint>".
> >
> > I'd really rather stay with "fixup".  And as I use single-letter commands 
> > quite often, I'd also rather stay away from that magic "!".  And by 
> > "magic" I really mean that: people will not find that magic intuitive at 
> > all.
> >
> > My vote is for "fixup".
> 
> I am too tired to either make the final judgement nor proposal on this 
> topic now,

Okay, I'll add another point that should convince you that the commit 
message is not the good place to trigger that behavior:

Interactive rebasing is about having made a quite messy patch series, 
maybe having a few fixup commits, and then deciding how to clean it up.

The decision how to clean it up is very much a rebase-time decision, not a 
commit-time decision.

For example, it is very easy to decide that you want to squash one fixup 
after all instead of leaving it stand-alone.

> Of course we _could_ use notes for that, but that won't play well with
> rebasing I suppose ...

Reminds me.  Nothing has happened on that front, right?

Ciao,
Dscho
