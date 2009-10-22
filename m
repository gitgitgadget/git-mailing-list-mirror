From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: ks/precompute-completion (was Re: What's cooking in git.git (Oct
  2009, #04; Wed, 21))
Date: Fri, 23 Oct 2009 01:07:14 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0910230106070.4985@pacific.mpi-cbg.de>
References: <7veiovly35.fsf@alter.siamese.dyndns.org> <4AE0190E.8020803@gmail.com> <fabb9a1e0910221011r957246dx3162cd675ff16800@mail.gmail.com> <4AE0DAB3.1030103@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Stephen Boyd <bebarino@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Kirill Smelkov <kirr@mns.spb.ru>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: A Large Angry SCM <gitzilla@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 23 01:04:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N16hm-0006xq-OG
	for gcvg-git-2@lo.gmane.org; Fri, 23 Oct 2009 01:04:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755477AbZJVXEQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 19:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755473AbZJVXEP
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 19:04:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:33574 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754354AbZJVXEP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 19:04:15 -0400
Received: (qmail invoked by alias); 22 Oct 2009 23:04:18 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp023) with SMTP; 23 Oct 2009 01:04:18 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19R3vNK+b5RivSvzyDbBrYSnufToR6Sgpk9bzAV1y
	9wanJPC8z5HyCd
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <4AE0DAB3.1030103@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131074>

Hi,

On Thu, 22 Oct 2009, A Large Angry SCM wrote:

> Sverre Rabbelier wrote:
> > Heya,
> > 
> > On Thu, Oct 22, 2009 at 03:34, Stephen Boyd <bebarino@gmail.com> wrote:
> > > Junio C Hamano wrote:
> > > > * ks/precompute-completion (2009-10-05) 1 commit.
> > > >   (merged to 'next' on 2009-10-14 at adf722a)
> > > >  + Speedup bash completion loading
> > > >
> > > > Are people happy with this?
> > > No. I now have rebase.sh, am.sh, etc. in my completion
> > 
> > I would really like it if running 'make && make install' in git.git
> > would also build the completion script, I don't want to have to
> > remember to run 'cd contrib/completion && make' every time we get new
> > completion options :P.
> > 
> 
> Please do not for completion on those that did not ask for it.

It is about installing git-completion.bash, AFAICT, not about forcing your 
shell into loading them by default.  IOW something I wished for already in 
Feb 2008, but was unable to convince anybody of.

Ciao,
Dscho
