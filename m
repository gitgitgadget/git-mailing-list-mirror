From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH 0/4] deny push to current branch of non-bare repo
Date: Sat, 8 Nov 2008 16:12:26 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811081609530.30769@pacific.mpi-cbg.de>
References: <20081107220730.GA15942@coredump.intra.peff.net> <7v3ai3f7oa.fsf@gitster.siamese.dyndns.org> <20081108142756.GC17100@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sam Vilain <sam@vilain.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 08 16:06:09 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KypO2-00070B-TK
	for gcvg-git-2@gmane.org; Sat, 08 Nov 2008 16:06:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753320AbYKHPEx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Nov 2008 10:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753026AbYKHPEx
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Nov 2008 10:04:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:33462 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752173AbYKHPEw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2008 10:04:52 -0500
Received: (qmail invoked by alias); 08 Nov 2008 15:04:50 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp040) with SMTP; 08 Nov 2008 16:04:50 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/i+epxGfnihXXtCZhRqTUk82H0DkhyHeWsxJbtU0
	ZvwZKMH7cKSLzz
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20081108142756.GC17100@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100406>

Hi,

On Sat, 8 Nov 2008, Jeff King wrote:

> On Fri, Nov 07, 2008 at 03:16:53PM -0800, Junio C Hamano wrote:
> 
> > > The FAQ even says "don't do this until you know what you are doing." 
> > > So the safety valve is configurable, so that those who know what 
> > > they are doing can switch it off.
> > 
> > "We are breaking your existing working setup but you can add a new 
> > configuration to unbreak it" should not be done lightly.  I think as 
> > the end result it is a reasonable thing to aim for for this particular 
> > feature, but we do need a transition plan patch in between that 
> > introduces a step that warns but not forbids.  We can ship 1.6.1 with 
> > it and then switch the default to forbid in 1.6.3, for example.
> 
> Yeah, I was kind of hoping we could assume that anybody relying on this
> behavior was somewhat insane, and wouldn't be too upset when it broke.

I think I have a repository with "git read-tree -u -m HEAD" as update hook 
for that kind of behavior.

But I will not be the person responsible to keep that behavior, if I am 
the only one relying on it.

I very much like the approach of defaulting to "warn" for quite some time 
(but setting the variable to "refuse" in git-init) and then adapt the 
default after some time.

Ciao,
Dscho
