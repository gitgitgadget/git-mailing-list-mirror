From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: how to suppress progress percentage in git-push
Date: Mon, 23 Nov 2009 14:40:31 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0911231437460.2059@xanadu.home>
References: <20091122145352.GA3941@debian.b2j>
 <20091123145959.GA13138@sigill.intra.peff.net>
 <alpine.LFD.2.00.0911231043310.2059@xanadu.home>
 <20091123192518.GA1607@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: bill lam <cbill.lam@gmail.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 23 20:40:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCem6-0007Ml-PS
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 20:40:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755123AbZKWTk0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2009 14:40:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753952AbZKWTk0
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 14:40:26 -0500
Received: from relais.videotron.ca ([24.201.245.36]:60887 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753793AbZKWTkZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2009 14:40:25 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KTK004N3UNJ0B90@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 23 Nov 2009 14:40:31 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20091123192518.GA1607@coredump.intra.peff.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133529>

On Mon, 23 Nov 2009, Jeff King wrote:

> On Mon, Nov 23, 2009 at 11:56:43AM -0500, Nicolas Pitre wrote:
> 
> > > We need to do one of:
> > > 
> > >   1. make --all-progress imply "if we are using progress, then make it
> > >      more verbose. Otherwise, ignore."
> > > 
> > >   2. fix all callers to check isatty(2) before unconditionally passing
> > >      the option
> > 
> > None of the above would fix the issue as this only affects progress 
> > display for phase #3.  You'd still get progress display for the counting 
> > phase and the compressing phase.
> 
> I think it does fix the issue, as it is exactly the side effect that we
> are concerned about (and I tested my patch for 1, which squelched it).

Sorry, you were right.  I somehow understood something else initially.

> But your --all-progress-implied is a better fix, so I think we should go
> with that.

OK.


Nicolas
