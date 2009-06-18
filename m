From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Re: rebase -i: auto-squash commits
Date: Thu, 18 Jun 2009 10:29:58 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0906181028140.4848@intel-tinevez-2-302>
References: <e1868cfe0906170506o37a75c35m47f9456bf8ae47c1@mail.gmail.com> <43d8ce650906170555m644564b3v3722168f7217c326@mail.gmail.com> <7vvdmurfao.fsf@alter.siamese.dyndns.org> <20090618063348.6117@nanako3.lavabit.com> <alpine.DEB.1.00.0906180007370.26154@pacific.mpi-cbg.de>
 <20090618001111.GB12954@vidovic> <7v8wjq2kqc.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0906181003300.4848@intel-tinevez-2-302> <87vdmuhs75.fsf@iki.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	John Tapsell <johnflux@gmail.com>, git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Thu Jun 18 10:30:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHD0g-0005In-3x
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 10:30:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751767AbZFRIaD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2009 04:30:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbZFRIaC
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 04:30:02 -0400
Received: from mail.gmx.net ([213.165.64.20]:56853 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750978AbZFRIaB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2009 04:30:01 -0400
Received: (qmail invoked by alias); 18 Jun 2009 08:29:59 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp009) with SMTP; 18 Jun 2009 10:29:59 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/GUGw50sfGyJik4Fo4D3ryjPR+K0KvuauEOKbQfE
	D+xLyQx/LCsD4R
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <87vdmuhs75.fsf@iki.fi>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121814>

Hi,

On Thu, 18 Jun 2009, Teemu Likonen wrote:

> On 2009-06-18 10:06 (+0200), Johannes Schindelin wrote:
> 
> > I'd really rather stay with "fixup". And as I use single-letter
> > commands quite often, I'd also rather stay away from that magic "!".
> > And by "magic" I really mean that: people will not find that magic
> > intuitive at all.
> 
> I don't know about people but I do find "!" intuitive. It is squash
> after all so I like the idea of using small modifier character.

Mhm.

So let's just interpret the "!" in the most common meaning, namely to add 
an imperative.  Then it means "yes, I do want to squash".  Not 
"squash, but oh, BTW, I want to lose the second commit message 
completely, and I do not want to edit the commit message either".

Really, I do not see how anybody could find this intuitive at all.  Maybe 
after reading the manual, but kinda defeats the meaning of the word 
"intuitive".

Ciao,
Dscho
