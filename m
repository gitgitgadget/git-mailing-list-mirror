From: Jeff King <peff@peff.net>
Subject: Re: git status -u is mildly astonishing
Date: Thu, 17 Sep 2015 13:43:07 -0400
Message-ID: <20150917174306.GA29171@sigill.intra.peff.net>
References: <20150917104430.5dd73ae1@dev-05>
 <vpqd1xhqfxg.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alastair McGowan-Douglas <altreus@altre.us>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Sep 17 19:43:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcdDH-0007QI-G4
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 19:43:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752054AbbIQRnK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2015 13:43:10 -0400
Received: from cloud.peff.net ([50.56.180.127]:32768 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751849AbbIQRnJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2015 13:43:09 -0400
Received: (qmail 14193 invoked by uid 102); 17 Sep 2015 17:43:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 17 Sep 2015 12:43:09 -0500
Received: (qmail 464 invoked by uid 107); 17 Sep 2015 17:43:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 17 Sep 2015 13:43:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Sep 2015 13:43:07 -0400
Content-Disposition: inline
In-Reply-To: <vpqd1xhqfxg.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278150>

On Thu, Sep 17, 2015 at 04:27:39PM +0200, Matthieu Moy wrote:

> > Therefore I would argue that -u is behaving differently from other
> > arguments (especially when considered across all git subcommands)
> 
> This is because you have options with non-optional argument in mind, or
> options that have no short version.
> 
> If I grep the source correctly, the only options accepting a short
> version and an optional string argument are "{merge,am,commit,revert}
> -S", "grep -O" and "status -u", which behave consistantly.

Exactly. This is covered in gitcli(7)*, but I wonder if it is worth
calling attention to this behavior specifically in the documentation of
those options.

-Peff

[*] Try "git help cli", the bit starting with 'Here are the rules
    regarding the "flags"...'.
