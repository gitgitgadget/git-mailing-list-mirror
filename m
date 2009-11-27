From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] grep: --full-tree
Date: Fri, 27 Nov 2009 10:31:30 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0911271027510.4521@intel-tinevez-2-302>
References: <7vk4xggv27.fsf@alter.siamese.dyndns.org> <20091125203922.GA18487@coredump.intra.peff.net> <7viqcytjic.fsf@alter.siamese.dyndns.org> <20091125210034.GC18487@coredump.intra.peff.net> <7vmy2as319.fsf@alter.siamese.dyndns.org>
 <20091125214949.GA31473@coredump.intra.peff.net> <885649360911251412n3e566c8fu536b361b993f2ac6@mail.gmail.com> <20091125222037.GA2861@coredump.intra.peff.net> <885649360911260956p58c54a54rd887102c9adedcc9@mail.gmail.com>
 <20091127062013.GA20844@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: James Pickens <jepicken@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 27 10:31:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDxAy-0002b2-2Q
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 10:31:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754173AbZK0Jb1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2009 04:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754167AbZK0Jb1
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 04:31:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:59698 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753075AbZK0Jb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2009 04:31:26 -0500
Received: (qmail invoked by alias); 27 Nov 2009 09:31:31 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp039) with SMTP; 27 Nov 2009 10:31:31 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18ZmCA0LjkZFAFUhE3oQ7IWJGFcC4jjj8lyi3+s0H
	dnBOXDiTPS0RAp
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20091127062013.GA20844@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133883>

Hi,

On Fri, 27 Nov 2009, Jeff King wrote:

> On Thu, Nov 26, 2009 at 10:56:55AM -0700, James Pickens wrote:
> 
> > On Wed, Nov 25, 2009 at 3:20 PM, Jeff King <peff@peff.net> wrote:
> > > Sure, there are all those downsides. But what is the other option? 
> > > Making me use the command line option (or pathspec magic) every 
> > > single time I invoke git grep?
> > 
> > Yes, but only when you want non-default behavior, not every single 
> > time.
> 
> Did you miss the part of the thread where I explained that in certain 
> repos, I want it one way every single time, and in others, I want it the 
> other way?

Guess what.  I have a similar problem, only it is that my "git status" 
output is _always_ too long, so I always have to page it.

Once upon a time, Junio applied a patch that implied -p with status.  I 
was overjoyed.  He reverted that patch later.  Yes, exactly.

So I end up doing "git config --global ps '-p status'" on every new 
account (I usually even forget to curse!), and I really cannot see why you 
do not do the equivalent "git config fullgrep grep --full-tree" in your 
repositories (or even the global thing).

The further benefit is that we stop talking about breaking backwards 
compatibility, and we stop talking about making it hard for Git experts to 
help newbies.

Ciao,
Dscho
