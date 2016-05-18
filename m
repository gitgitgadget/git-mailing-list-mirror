From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] Formatting variables in the documentation
Date: Wed, 18 May 2016 14:15:00 -0400
Message-ID: <20160518181500.GD5796@sigill.intra.peff.net>
References: <1463587109-22476-1-git-send-email-tom.russello@grenoble-inp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, matthieu.moy@grenoble-inp.fr,
	samuel.groot@ensimag.grenoble-inp.fr,
	erwan.mathoniere@ensimag.grenoble-inp.fr,
	jordan.de-gea@ensimag.grenoble-inp.fr
To: Tom Russello <tom.russello@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Wed May 18 20:15:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b35zx-0005XU-EA
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 20:15:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752533AbcERSPE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 14:15:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:41413 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752272AbcERSPD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 14:15:03 -0400
Received: (qmail 16807 invoked by uid 102); 18 May 2016 18:15:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 May 2016 14:15:03 -0400
Received: (qmail 25150 invoked by uid 107); 18 May 2016 18:15:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 May 2016 14:15:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 May 2016 14:15:00 -0400
Content-Disposition: inline
In-Reply-To: <1463587109-22476-1-git-send-email-tom.russello@grenoble-inp.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294985>

On Wed, May 18, 2016 at 05:58:29PM +0200, Tom Russello wrote:

> There is no agreement on this topic (the CodingGuidelines does not
> mention it), it would be better if everyone follows the same rule: put
> each environment variable in monospace style and write this rule in
> the guide.
> 
> It is a good thing to have a consistent documentation however it
> will be painful to change with a simple regex all occurences
> (especially environment variables without any format) because some of
> them are in paths or code section.
> 
> What do you think ?

Personally, I like the "literal" backticks versus the "emphasis"
single-quotes. But you should keep in mind how they are rendered in the
manpages, which is as "nothing" and "underline", respectively (by
default, anyway). So I think some people are negative on using backticks
for that reason.

I also turn on the MAN_BOLD_LITERAL knob, which turns that "nothing"
into "bold", and the result looks quite nice. But there is some
compatibility question of whether that can be used everywhere.

Here's the most recent discussion I could find:

  http://thread.gmane.org/gmane.comp.version-control.git/281170

which talks about the issue and references an earlier discussion (which
I didn't re-read). But you probably need to address the concerns there
before moving forward with a patch like this.

-Peff
