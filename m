From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Move all dashed form git commands to libexecdir
Date: Fri, 30 Nov 2007 16:25:01 -0500
Message-ID: <20071130212500.GB25946@coredump.intra.peff.net>
References: <alpine.LFD.0.9999.0711291527090.8458@woody.linux-foundation.org> <7veje8twt2.fsf@gitster.siamese.dyndns.org> <20071130003512.GB11683@coredump.intra.peff.net> <7vzlwwsgkp.fsf@gitster.siamese.dyndns.org> <20071130005852.GA12224@coredump.intra.peff.net> <alpine.LFD.0.99999.0711292004340.9605@xanadu.home> <20071130011748.GC11683@coredump.intra.peff.net> <474FB938.3040209@op5.se> <20071130150948.GA22095@coredump.intra.peff.net> <7vve7jqz92.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, Nicolas Pitre <nico@cam.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 30 22:25:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyDMS-0005lc-Hc
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 22:25:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752829AbXK3VZF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2007 16:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752806AbXK3VZE
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 16:25:04 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2702 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752784AbXK3VZD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2007 16:25:03 -0500
Received: (qmail 5306 invoked by uid 111); 30 Nov 2007 21:25:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 30 Nov 2007 16:25:02 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Nov 2007 16:25:01 -0500
Content-Disposition: inline
In-Reply-To: <7vve7jqz92.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66663>

On Fri, Nov 30, 2007 at 12:01:13PM -0800, Junio C Hamano wrote:

> I already can see exchanges in the user community after such a change
> you propose would happen:
> [...]
>  Jeff: If you really like that, here is a hidden trick.  Add
>        /usr/libexec/git-core/ to your PATH.

What if I promise not to tell anyone? :)

Anyway, I don't think it will be a problem. You think it might. But I
suspect neither of us has anything more than a gut feeling to argue
with. And now I have registered my complaint, so you can do what you
think is best.

I can, of course, always make my own hardlinks (which is really the same
thing, except the "trick" is slightly harder to perform and perhaps less
socially acceptable; OTOH, if such a trick is common, perhaps it means
taking away the dash forms wasn't such a good idea after all).

>  Newbie: Stupid inconsistency.  Who suggested that?

Jeff [runs git-blame]: It must have been Junio! :)

-Peff
