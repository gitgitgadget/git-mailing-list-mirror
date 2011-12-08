From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: git auto-repack is broken...
Date: Wed, 07 Dec 2011 19:18:13 -0500 (EST)
Message-ID: <alpine.LFD.2.02.1112071912570.2907@xanadu.home>
References: <CA+55aFznj49hx6Ce6NhJ1rRd2nvNyOERseyyrC6SNcW-z9dyfg@mail.gmail.com>
 <CACBZZX7Q5qb1r_Oh0QfMiWh9UAM1c6QWBn4abv-xHpFBaKuyKg@mail.gmail.com>
 <CA+55aFyq28vmo9dk-5mVm+nNn86qSjNT6VJGc09iaJo=+OP1Sg@mail.gmail.com>
 <20111202171017.GB23447@sigill.intra.peff.net>
 <7vobvqoozr.fsf@alter.siamese.dyndns.org>
 <20111202174546.GA24093@sigill.intra.peff.net>
 <CA+sFfMdeVoz8XU5j4hNn1qCHHzaiDi0Bw=QbbuU3cwT9mMPZOA@mail.gmail.com>
 <alpine.LFD.2.02.1112071709250.2907@xanadu.home>
 <20111207225318.GA21852@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Brandon Casey <drafnel@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	=?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 08 01:18:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYRgp-0001pw-Bx
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 01:18:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754557Ab1LHASO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 19:18:14 -0500
Received: from relais.videotron.ca ([24.201.245.36]:34550 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754092Ab1LHASO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 19:18:14 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-VM-MR004.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0LVU00G5CZC8MK90@VL-VM-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 07 Dec 2011 19:14:33 -0500 (EST)
In-reply-to: <20111207225318.GA21852@sigill.intra.peff.net>
User-Agent: Alpine 2.02 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186522>

On Wed, 7 Dec 2011, Jeff King wrote:

> On Wed, Dec 07, 2011 at 05:12:14PM -0500, Nicolas Pitre wrote:
> 
> > Maybe  FETCH_HEAD should have a reflog too?
> 
> That might be nice. However, there is a complication, in that FETCH_HEAD
> may contain many sha1s, but each reflog entry only has room for a single
> sha1 transition. You could obviously encode it as a series of reflog
> entries, but then "git show FETCH_HEAD@{1}" is not very meaningful.

What does "git show FETCH_HEAD" do now?  If it shows only one 
(presumably the first) SHA1 then its reflog doesn't have to be smarter, 
which would properly cover most cases already.  I certainly never did a 
multi-ref fetch myself.


Nicolas
