From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] git-gc: skip stashes when expiring reflogs
Date: Fri, 13 Jun 2008 05:52:53 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806130551200.6439@racer>
References: <OLvkESB0JjBNs9kF8Q2M5UFNBJqq4FjbgGeQVyWstGwcXqCOq16_oomM0y-utOBbV7BnndyrICE@cipher.nrlssc.navy.mil>  <20080611213648.GA13362@glandium.org>  <alpine.DEB.1.00.0806112242370.1783@racer>  <20080611230344.GD19474@sigill.intra.peff.net> 
 <alpine.LFD.1.10.0806111918300.23110@xanadu.home>  <loom.20080612T042942-698@post.gmane.org>  <6413041E-A64A-4BF4-9ECF-F7BFA5C1EAEF@wincent.com>  <7vzlpqza0t.fsf@gitster.siamese.dyndns.org>  <279b37b20806121335p90a6d40qb39b73f71dae990b@mail.gmail.com> 
 <7vlk1az8aa.fsf@gitster.siamese.dyndns.org> <279b37b20806121436w4f09c8f7n1009ef2f77b66f87@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Wincent Colaiuta <win@wincent.com>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>
To: Eric Raible <raible@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 13 06:55:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K71K4-0002X4-Ts
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 06:55:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752748AbYFMEym (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 00:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752691AbYFMEym
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 00:54:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:48183 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750798AbYFMEym (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 00:54:42 -0400
Received: (qmail invoked by alias); 13 Jun 2008 04:54:39 -0000
Received: from unknown (EHLO racer.local) [128.177.17.254]
  by mail.gmx.net (mp010) with SMTP; 13 Jun 2008 06:54:39 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18EDkoc+nEETsT9HBK8Ad2tByaJ9tacyGTuI3p4Li
	yeygNKgMAkmDOc
X-X-Sender: gene099@racer
In-Reply-To: <279b37b20806121436w4f09c8f7n1009ef2f77b66f87@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84830>

Hi,

On Thu, 12 Jun 2008, Eric Raible wrote:

> On Thu, Jun 12, 2008 at 1:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > Perhaps
> >
> >  http://thread.gmane.org/gmane.comp.version-control.git/84665/focus=84670
> >
> > The user explicitly asks to stash it for a while, where the definition of
> > the "while" comes from reflog's retention period.
> 
> But that doesn't answer the basic question as to why it's ok
> to trash data that the user explicitly asked git to save?

If the user really asked git to save the changes, she would have 
_committed_ them.

"git stash" really is only about shelving quickly and dirtily something 
you'll need (or maybe need) in a moment.

If you need something from the stash a day after stashing it, you have a 
serious problem with understanding what branches are for.

Ciao,
Dscho
