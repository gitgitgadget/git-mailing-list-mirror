From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's in git.git (stable)
Date: Mon, 18 Feb 2008 02:05:40 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802180204190.30505@racer.site>
References: <7v8x27iui1.fsf@gitster.siamese.dyndns.org> <7vd4r24ox6.fsf@gitster.siamese.dyndns.org> <7vir0o44mt.fsf_-_@gitster.siamese.dyndns.org> <m3d4qvbt40.fsf@localhost.localdomain> <7vtzk7xqg3.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0802172050090.30505@racer.site>
 <7v3arrxd7q.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0802180133150.30505@racer.site> <20080218014301.GA6642@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 18 03:06:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQvOo-00080S-0o
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 03:06:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752409AbYBRCFv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 21:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752483AbYBRCFv
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 21:05:51 -0500
Received: from mail.gmx.net ([213.165.64.20]:41773 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752349AbYBRCFu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 21:05:50 -0500
Received: (qmail invoked by alias); 18 Feb 2008 02:05:48 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp054) with SMTP; 18 Feb 2008 03:05:48 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18p4R4VCz0pbdOMp0WSfSVxRgE9tvdD4Q1eE5FWUl
	KBx9BanhSrz+Ii
X-X-Sender: gene099@racer.site
In-Reply-To: <20080218014301.GA6642@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74216>

Hi,

On Sun, 17 Feb 2008, Jeff King wrote:

> On Mon, Feb 18, 2008 at 01:34:50AM +0000, Johannes Schindelin wrote:
> 
> > Well, my workflow has lots of these moments.  I do not even feel "oops" 
> > about it.  More like "by the way, this needs committing _now_".
> > 
> > So I guess I'll be the guinea pig for this patch, and if it is too 
> > painful, I'll just go and fix it.
> 
> Just to be clear, this patch discards the cache after preparing the
> partial index but before doing the status. This is in contrast to the
> current 'master' and v1.5.4, which discard the cache _three_ times
> during the status process.

... but then goes through big pains to reconstruct an index that needs as 
little updating as possible.

> So no, the performance will probably not be a big deal. It is better 
> than it has been in any released version of git.

I'll see, and report back.

IOW I think that your patch is necessary.  There might be some followup 
work to do for me, but at the moment, your patch fixes an existing bug.

Ciao,
Dscho
