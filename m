From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/4] help.c::uniq: plug a leak
Date: Mon, 7 May 2012 03:30:59 -0400
Message-ID: <20120507073059.GD19874@sigill.intra.peff.net>
References: <1336287330-7215-1-git-send-email-rctay89@gmail.com>
 <1336287330-7215-2-git-send-email-rctay89@gmail.com>
 <20120506081213.GA27878@sigill.intra.peff.net>
 <CALUzUxqtKGd9REqwyZLVnr4zcd20GmSREeNL7tDpA8kYaTtWBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 07 09:31:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRIPU-0004fr-Fz
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 09:31:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753955Ab2EGHbD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 May 2012 03:31:03 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60439
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752796Ab2EGHbC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2012 03:31:02 -0400
Received: (qmail 17717 invoked by uid 107); 7 May 2012 07:31:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 07 May 2012 03:31:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 May 2012 03:30:59 -0400
Content-Disposition: inline
In-Reply-To: <CALUzUxqtKGd9REqwyZLVnr4zcd20GmSREeNL7tDpA8kYaTtWBg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197239>

On Sun, May 06, 2012 at 11:54:20PM +0800, Tay Ray Chuan wrote:

> On Sun, May 6, 2012 at 4:12 PM, Jeff King <peff@peff.net> wrote:
> > So this shorter patch should be sufficient (though I didn't actually
> > test it):
> 
> Tested and works fine.

Thanks. Do you want to just include it in your re-roll, or should I pick
it up and re-post it with a commit message?

-Peff
