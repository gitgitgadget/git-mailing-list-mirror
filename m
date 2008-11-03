From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Pull request for sub-tree merge into /contrib/gitstats
Date: Mon, 3 Nov 2008 07:33:47 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811030729071.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <bd6139dc0810291606o2efe4254me378335b76861340@mail.gmail.com>  <7vljw5evj5.fsf@gitster.siamese.dyndns.org> <bd6139dc0811021124q5ba22d6bm6655f735aaeb379b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: sverre@rabbelier.nl, git@vger.kernel.org, dsymonds@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 03 07:37:16 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kwt3r-0006cq-IH
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 07:37:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751599AbYKCG0Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 01:26:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751497AbYKCG0Y
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 01:26:24 -0500
Received: from mail.gmx.net ([213.165.64.20]:36202 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751340AbYKCG0Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 01:26:24 -0500
Received: (qmail invoked by alias); 03 Nov 2008 06:26:21 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp060) with SMTP; 03 Nov 2008 07:26:21 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/zxOFgkETzgPP5yJYMCDtRripgUAilMTh8cFnuwq
	V7rR3BVeig8iGT
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <bd6139dc0811021124q5ba22d6bm6655f735aaeb379b@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99903>

Hi,

On Sun, 2 Nov 2008, Sverre Rabbelier wrote:

> On Thu, Oct 30, 2008 at 20:24, Junio C Hamano <gitster@pobox.com> wrote:
> > I have a mixed feeling about this.  From a longer-term perspective, do 
> > you really want this to be a part of git.git repository?
> 
> My main reason for wanting to have it in git.git is getting additional 
> exposure, being in /contrib seems like a good way to do that.
> 
> > I do not mind having notes to endorse and advocate "stats" as one of 
> > the "Third party packages that may make your git life more 
> > pleasuable", just like tig, stgit, guilt and topgit, but I cannot 
> > convince myself that merging it as a subtree is the right thing to do 
> > at this point.
> 
> Heh, blame Johannes for that one; the main reason for not doing 
> something like this earlier was my uncertaincy as to -what- to do. Dscho 
> suggested to request-pull a subtree merge, which is what I did.

Actually, I suggested that the end result be submitted as a single patch 
against contrib/, but dsymonds objected that that would lose all history, 
and I concurred that it would be nice to have all changes with the design 
decisions recorded as commit messages, too.

Actually, in the meantime, I am of two minds.  On the one hand, I would 
just like to have the scripts in contrib/ (as a result of one commit), and 
on the other hand, I would not like to lose history of gitstats.

So I roll the ball back into your (Junio's) half, albeit gently.

Ciao,
Dscho
