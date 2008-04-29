From: Fredrik Skolmli <fredrik@frsk.net>
Subject: Re: About git and the use of SHA-1
Date: Tue, 29 Apr 2008 20:23:25 +0200
Message-ID: <20080429182325.GC1641@frsk.net>
References: <200804281829.11866.henrikau@orakel.ntnu.no> <20080429124152.GB6160@dpotapov.dyndns.org> <481733A3.4010802@op5.se> <alpine.LFD.1.10.0804291132060.23581@xanadu.home> <7f9d599f0804290859y6a579302m5db9f7f827b320a4@mail.gmail.com> <vpqwsmg7cfk.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Geoffrey Irving <irving@naml.us>, Nicolas Pitre <nico@cam.org>,
	Andreas Ericsson <ae@op5.se>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Henrik Austad <henrikau@orakel.ntnu.no>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Apr 29 20:25:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JquVd-0002Ge-0c
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 20:24:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755640AbYD2SYE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 14:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754081AbYD2SYD
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 14:24:03 -0400
Received: from cassarossa.samfundet.no ([129.241.93.19]:37216 "EHLO
	cassarossa.samfundet.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752905AbYD2SYB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 14:24:01 -0400
Received: from asterix.samfundet.no ([2001:700:300:1800::f] ident=postfix)
	by cassarossa.samfundet.no with esmtp (Exim 4.63)
	(envelope-from <fredrik@frsk.net>)
	id 1JquUA-00066Y-1Q; Tue, 29 Apr 2008 20:23:26 +0200
Received: by asterix.samfundet.no (Postfix, from userid 1000)
	id EE688A6035A; Tue, 29 Apr 2008 20:23:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <vpqwsmg7cfk.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80716>

On Tue, Apr 29, 2008 at 08:17:51PM +0200, Matthieu Moy wrote:

> > Here's the standard scenario for a hash collision attack, with
> > parties, A, B, and C:
> >
> > 1. C, the malicious one, computes the standard two pdfs with matching
> > sha1 hashes.
> > 2. C sends the valid pdf to B through a git commit, and B signs it with a tag.
> > 3. C grabs the signature, and then forwards the "signed" commit to A,
> > but substitutes the invalid pdf with the same hash.
> 
> Just to add my 2 cents, examples of this are available on the web,
> like:
> 
> http://th.informatik.uni-mannheim.de/People/Lucks/HashCollisions/
> 
> Same size, same hash. But that's with md5, not sha1.

Well yes, but that's still using the methods already mentioned in this
thread. So you do have to get your "good" code approved before replacing it
with something nasty.

- Fredrik

-- 
Regards,
Fredrik Skolmli
