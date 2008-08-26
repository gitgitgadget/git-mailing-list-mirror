From: Nicolas Pitre <nico@cam.org>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Tue, 26 Aug 2008 19:45:41 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0808261717480.1624@xanadu.home>
References: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org>
 <1219664940.9583.42.camel@pmac.infradead.org>
 <alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de>
 <7vy72kek6y.fsf@gitster.siamese.dyndns.org>
 <20080826145719.GB5046@coredump.intra.peff.net>
 <7vr68b8q9p.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org,
	users@kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 01:47:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY8Fb-0004b7-Pr
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 01:47:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751598AbYHZXps (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 19:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751618AbYHZXps
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 19:45:48 -0400
Received: from relais.videotron.ca ([24.201.245.36]:61977 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068AbYHZXps (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 19:45:48 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K6800M04FC5W6F0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 26 Aug 2008 19:45:42 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vr68b8q9p.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93835>

On Tue, 26 Aug 2008, Junio C Hamano wrote:

> Read the subject line again, and notice that we are not talking about
> /usr/bin vs /usr/libexec/git-core; the request-for-discussion was about
> removing "git-add" and friends from /usr/libexec/git-core/, so that we do
> not have to even have these many hardlinks there.  Except for Linus (and
> obviously myself who started the thread), I saw nobody expressed any
> opinion on it.

Don't deprecate git-foo and leave them in $gitexecdir as things are now.
That's the best compromise IMHO.

Those who want git-foo can have it via several and easy means.  Those 
who want 'git foo' have it by default which IMHO is pretty sane (the 
other way around is less easy so 'git foo' being the default is the most 
sensible alternative).

Platforms where filesystem links are not available simply don't have to 
support the git-foo form, period.  I doubt users of such platforms will 
care much.

All the rest is only bikeshedding.


Nicolas
