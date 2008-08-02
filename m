From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] diff: add ruby funcname pattern
Date: Sat, 2 Aug 2008 13:39:29 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808021336050.9611@pacific.mpi-cbg.de.mpi-cbg.de>
References: <1217488908-19692-1-git-send-email-giuseppe.bilotta@gmail.com>  <7vmyjxtco3.fsf@gitster.siamese.dyndns.org>  <cb7bb73a0808010111j29e2085etd58150037b55063c@mail.gmail.com>  <7v4p65tadh.fsf@gitster.siamese.dyndns.org>  <0C57339C-50EF-4199-A14B-AFF04C92EF87@sb.org>
  <cb7bb73a0808012241s80a06fq1ac54a3350169f6c@mail.gmail.com>  <C871A30D-F2AF-4385-ABD4-C57F474D7F01@sb.org> <cb7bb73a0808012306y5672dad9nd0a21f861f181e5b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Kevin Ballard <kevin@sb.org>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 02 13:36:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPFP9-0006p2-0o
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 13:36:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752611AbYHBLfJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2008 07:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752552AbYHBLfJ
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Aug 2008 07:35:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:32968 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752601AbYHBLfI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2008 07:35:08 -0400
Received: (qmail invoked by alias); 02 Aug 2008 11:35:06 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp049) with SMTP; 02 Aug 2008 13:35:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19RcShJ0chRPdUCt1Si+7iTtBbPO/Bvr/zvOifqt7
	+w1ZMFdg8IFRwe
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <cb7bb73a0808012306y5672dad9nd0a21f861f181e5b@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91142>

Hi,

On Sat, 2 Aug 2008, Giuseppe Bilotta wrote:

> On Sat, Aug 2, 2008 at 7:47 AM, Kevin Ballard <kevin@sb.org> wrote:
> >
> > If you're going to get into anonymous code blocks, you're going to have a
> > really tough time deciding which blocks are interesting and which aren't.
> > And as you stated before, without a stack-based approach, this could really
> > fall apart, as anonymous blocks are (almost) always going to be inside a
> > method.
> 
> I was just looking for a libxdiff issue tracker but I couldn't find one, 
> so I guess I'll ask the author directly about the possibility to 
> implement such a thing.

The funcname thing was introduced by us, in Git.  I do not know if Davide 
picked the changes up; at least for the merge stuff he seemed to be pretty 
reluctant.

> The matchit plugin for vim seems to manage (even user-defined) code 
> blocks very well, even for multi-state blocks (if ... else ... end), 
> using regexps; so maybe a reimplementation in C for libxdiff could be a 
> solution.

Bzzt.  You say vi manages it with regexps, and then you go on and say that 
you therefore do _not_ want to use a regexp?

BTW having funcname calculation in C was shot down by Junio as being too 
inflexible, as the user cannot add new languages without recompiling.  
That's why we have regexps now.

Ciao,
Dscho
