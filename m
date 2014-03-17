From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] subtree: initialize "prefix" variable
Date: Mon, 17 Mar 2014 16:56:17 -0400
Message-ID: <20140317205616.GA18629@sigill.intra.peff.net>
References: <5326F158.4050402@free.fr>
 <20140317195946.GA29839@sigill.intra.peff.net>
 <CAPig+cSbi7X1z+u8EzXhdMb6_ENbLcTiHyXG0erfpCR=a5BEYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Gilles Filippini <gilles.filippini@free.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Mar 17 21:56:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPea8-0008Tb-GM
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 21:56:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752244AbaCQU4U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 16:56:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:41363 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752153AbaCQU4T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 16:56:19 -0400
Received: (qmail 28818 invoked by uid 102); 17 Mar 2014 20:56:18 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 17 Mar 2014 15:56:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Mar 2014 16:56:17 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cSbi7X1z+u8EzXhdMb6_ENbLcTiHyXG0erfpCR=a5BEYQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244283>

On Mon, Mar 17, 2014 at 04:08:50PM -0400, Eric Sunshine wrote:

> On Mon, Mar 17, 2014 at 3:59 PM, Jeff King <peff@peff.net> wrote:
> > On Mon, Mar 17, 2014 at 01:58:00PM +0100, Gilles Filippini wrote:
> >
> >> Test 21 from contrib/subtree/t/t7900-subtree.sh fails when an
> >> environment variable 'prefix' is set. For instance here is what happens
> >> when prefix=/usr:
> >
> > I think it just needs the patch below.
> 
> Gilles submitted this same patch [1] a couple weeks ago but it appears
> to have been lost in the noise. Your commit message is a bit nicer.
> 
> [1]: http://thread.gmane.org/gmane.comp.version-control.git/243103/

Ah, sorry Gilles, I completely missed that. Junio, if you pick this up,
please feel free to use text from my commit message as you see fit, but
mark Gilles as the author.

Thanks, Eric, for pointing it out.

-Peff
