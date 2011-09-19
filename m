From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCHv2] git-web--browse: avoid the use of eval
Date: Mon, 19 Sep 2011 14:34:08 -0400
Message-ID: <20110919183408.GB26115@sigill.intra.peff.net>
References: <20110918183846.GA31176@sigill.intra.peff.net>
 <1316424415-11156-1-git-send-email-judge.packham@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	chriscool@tuxfamily.org, jepler@unpythonic.net
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 19 20:34:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5ifY-0004mQ-HX
	for gcvg-git-2@lo.gmane.org; Mon, 19 Sep 2011 20:34:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338Ab1ISSeL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Sep 2011 14:34:11 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37504
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932085Ab1ISSeK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2011 14:34:10 -0400
Received: (qmail 7827 invoked by uid 107); 19 Sep 2011 18:39:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 19 Sep 2011 14:39:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Sep 2011 14:34:08 -0400
Content-Disposition: inline
In-Reply-To: <1316424415-11156-1-git-send-email-judge.packham@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181689>

On Mon, Sep 19, 2011 at 09:26:55PM +1200, Chris Packham wrote:

> Using eval causes problems when the URL contains an appropriately
> escaped ampersand (\&). Dropping eval from the built-in browser
> invocation avoids the problem.
> 
> Cc: peff@peff.net
> Cc: chriscool@tuxfamily.org
> Cc: jepler@unpythonic.net

Although other projects do use "cc" in the commit message, I think we
don't usually bother adding this noise in the git project. The cc
headers in your email are enough.

> I've replaced my tests With the test suggested by Peff (should I be
> giving him credit in the copyright line or something?).

For a minor bit of help, usually mentioning the person in the commit
message (with a "Helped-by", or indicating which parts they contributed
to) is plenty. Personally, I don't even care much about that. My
contributions to git are thoroughly documented in the commit history and
the mailing list at this point. :)

I also find the "Copyright ..." lines in the files to be overkill, too.
They end up becoming out-of-date as other people work on the file. The
commit history is the best way to get the right answer, and a comment in
the file is at best redundant with what's there. But that is just my
opinion; I don't know that we have a particular policy for such
things[1].

-Peff

[1] Once upon a time, I think I saw the advice that every file should
have a copyright notice and mention the license at the top of the file,
but I don't know that it has ever been tested in court. I suppose the
distributed tarballs of a particular version would lack the copyright
attribution, but in that case, my solution would be to generate it from
the commit history at packaging time.
