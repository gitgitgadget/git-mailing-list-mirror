From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] status: refactor output format to represent "default"
 and add --long
Date: Thu, 18 Oct 2012 16:26:47 -0400
Message-ID: <20121018202647.GA31093@sigill.intra.peff.net>
References: <20121018020308.GA24484@sigill.intra.peff.net>
 <1350569750-26304-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 18 22:27:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOwgH-0002UF-OS
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 22:27:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753226Ab2JRU0u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2012 16:26:50 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:38008 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752842Ab2JRU0t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2012 16:26:49 -0400
Received: (qmail 9063 invoked by uid 107); 18 Oct 2012 20:27:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 18 Oct 2012 16:27:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Oct 2012 16:26:47 -0400
Content-Disposition: inline
In-Reply-To: <1350569750-26304-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208017>

On Thu, Oct 18, 2012 at 09:15:50PM +0700, Nguyen Thai Ngoc Duy wrote:

>  On Thu, Oct 18, 2012 at 9:03 AM, Jeff King <peff@peff.net> wrote:
>  > I think that is fine to split it like this, but you would want to update
>  > the commit message above. Probably just remove those two cases and say
>  > something like:
>  >
>  >   Note that you cannot actually trigger STATUS_FORMAT_LONG, as we do
>  >   not yet have "--long"; that will come in a follow-on patch.
>  >
>  > And then move the reasoning for how "--long" works with each case into
>  > the commit message of the next patch.
> 
>  Nope, it's hard to split the explanation in two (at least to me),
>  which may mean that the split does not make sense.

Yeah, that was the same place that I had difficulty when writing the
original. This version looks OK to me.

-Peff
