From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: git auto-repack is broken...
Date: Wed, 07 Dec 2011 17:12:14 -0500 (EST)
Message-ID: <alpine.LFD.2.02.1112071709250.2907@xanadu.home>
References: <CA+55aFznj49hx6Ce6NhJ1rRd2nvNyOERseyyrC6SNcW-z9dyfg@mail.gmail.com>
 <CACBZZX7Q5qb1r_Oh0QfMiWh9UAM1c6QWBn4abv-xHpFBaKuyKg@mail.gmail.com>
 <CA+55aFyq28vmo9dk-5mVm+nNn86qSjNT6VJGc09iaJo=+OP1Sg@mail.gmail.com>
 <20111202171017.GB23447@sigill.intra.peff.net>
 <7vobvqoozr.fsf@alter.siamese.dyndns.org>
 <20111202174546.GA24093@sigill.intra.peff.net>
 <CA+sFfMdeVoz8XU5j4hNn1qCHHzaiDi0Bw=QbbuU3cwT9mMPZOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	=?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 23:12:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYPiu-0004Vh-Eg
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 23:12:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758496Ab1LGWMQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 17:12:16 -0500
Received: from relais.videotron.ca ([24.201.245.36]:19836 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758486Ab1LGWMP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 17:12:15 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-VM-MR004.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0LVU00G7PTIBRN40@VL-VM-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 07 Dec 2011 17:08:35 -0500 (EST)
In-reply-to: <CA+sFfMdeVoz8XU5j4hNn1qCHHzaiDi0Bw=QbbuU3cwT9mMPZOA@mail.gmail.com>
User-Agent: Alpine 2.02 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186510>

On Sat, 3 Dec 2011, Brandon Casey wrote:

> Linus's scenario of fetching a lot of stuff that never actually makes
> it into the reflogs is still a valid problem.  I'm not sure that
> people who don't know what they are doing are going to run into this
> problem though.  Since he fetches a lot of stuff without ever checking
> it out or creating a branch from it, potentially many objects become
> unreferenced every time FETCH_HEAD changes.

Maybe  FETCH_HEAD should have a reflog too?


Nicolas
