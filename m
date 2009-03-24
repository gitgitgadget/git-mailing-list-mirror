From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 2/8] docbook: improve css style
Date: Tue, 24 Mar 2009 05:16:00 -0400
Message-ID: <20090324091600.GA2484@coredump.intra.peff.net>
References: <1237745121-6325-1-git-send-email-felipe.contreras@gmail.com> <1237745121-6325-2-git-send-email-felipe.contreras@gmail.com> <1237745121-6325-3-git-send-email-felipe.contreras@gmail.com> <20090323064242.GB1119@coredump.intra.peff.net> <94a0d4530903230331g3b620f80h77e317a09dc5273f@mail.gmail.com> <49C7A8AF.9080500@drmicha.warpmail.net> <94a0d4530903231721i2a2a6fc1yf54d4303283ec415@mail.gmail.com> <49C899E1.6060809@drmicha.warpmail.net> <94a0d4530903240206k6eecdabg2cbb2c5595cd4bc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 10:18:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lm2m9-0002X0-Sy
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 10:18:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758075AbZCXJQM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 05:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757593AbZCXJQL
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 05:16:11 -0400
Received: from peff.net ([208.65.91.99]:50205 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756500AbZCXJQJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 05:16:09 -0400
Received: (qmail 28426 invoked by uid 107); 24 Mar 2009 09:16:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 24 Mar 2009 05:16:20 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Mar 2009 05:16:00 -0400
Content-Disposition: inline
In-Reply-To: <94a0d4530903240206k6eecdabg2cbb2c5595cd4bc@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114439>

On Tue, Mar 24, 2009 at 11:06:50AM +0200, Felipe Contreras wrote:

> Take a look at:
> http://people.freedesktop.org/~felipec/git/user-manual.html#bisect-merges
> 
> Do you think slanting Z (and the other characters) is enough to emphasize it?

I think it looks better with color to emphasize that it is different,
just as the <code> blocks get monospaced _and_ colored.

However, I think this is a matter of poor semantic markup in the first
place. Italics on a word for emphasis in text is very different from
what is happening here, which is essentially typesetting math variables.
I would say that `Z` is probably a better match, though I prefer the
LaTeX-style "math mode" italics for this sort of thing. I think asciidoc
supports some math markup, but I haven't lookd at it.

So basically, I think these variables look fine slanted and green. But I
think an emphasized word in the text should not be green.

-Peff
