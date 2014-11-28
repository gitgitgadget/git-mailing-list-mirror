From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] commit: inform pre-commit if --amend is used
Date: Fri, 28 Nov 2014 00:18:05 -0500
Message-ID: <20141128051805.GA19258@peff.net>
References: <1416828111-4567-1-git-send-email-oystwa@gmail.com>
 <20141125034424.GA19161@peff.net>
 <xmqqtx1nub9e.fsf@gitster.dls.corp.google.com>
 <20141125050331.GB20805@peff.net>
 <547737C8.7070609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
	git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 28 06:18:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XuDwa-00044k-Pn
	for gcvg-git-2@plane.gmane.org; Fri, 28 Nov 2014 06:18:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbaK1FSH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Nov 2014 00:18:07 -0500
Received: from cloud.peff.net ([50.56.180.127]:45821 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750754AbaK1FSG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Nov 2014 00:18:06 -0500
Received: (qmail 21536 invoked by uid 102); 28 Nov 2014 05:18:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 27 Nov 2014 23:18:05 -0600
Received: (qmail 20563 invoked by uid 107); 28 Nov 2014 05:18:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 28 Nov 2014 00:18:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Nov 2014 00:18:05 -0500
Content-Disposition: inline
In-Reply-To: <547737C8.7070609@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260358>

On Thu, Nov 27, 2014 at 09:40:08AM -0500, Mark Levedahl wrote:

> >Then when you add new arguments, the hook has to search through the
> >parameters looking for one that matches, rather than just checking "$1"
> >for "amend" (and "$2" for the new option, and so on). As long as the set
> >of options remains relatively small, I think that is preferable.
> >
> >We could also just pass them through the environment, which gives nice
> >named parameters.
> >
> 
> See http://comments.gmane.org/gmane.comp.version-control.git/148479 for an
> earlier conversation on this exact topic. Also, see
> http://permalink.gmane.org/gmane.comp.version-control.git/148480 for a
> similar change in git-gui.

Thanks for the links; I had no recollection of that thread.
Unsurprisingly, I like the "HEAD"/"HEAD~1" suggestion. That "peff" guy
seems really clever (and handsome, too, I'll bet).

I'd still be OK with any of the suggestions given in this thread,
though.

-Peff
