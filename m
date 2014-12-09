From: Jeff King <peff@peff.net>
Subject: Re: diff: use built-in patterns by default via git attributes
Date: Tue, 9 Dec 2014 15:42:47 -0500
Message-ID: <20141209204247.GD12001@peff.net>
References: <54875916.7020107@thequod.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Daniel Hahler <genml+git-2014@thequod.de>
X-From: git-owner@vger.kernel.org Tue Dec 09 21:42:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyRcU-0005gH-W5
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 21:42:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752058AbaLIUmu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2014 15:42:50 -0500
Received: from cloud.peff.net ([50.56.180.127]:50726 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751777AbaLIUmu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2014 15:42:50 -0500
Received: (qmail 21039 invoked by uid 102); 9 Dec 2014 20:42:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Dec 2014 14:42:49 -0600
Received: (qmail 4091 invoked by uid 107); 9 Dec 2014 20:42:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Dec 2014 15:42:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Dec 2014 15:42:47 -0500
Content-Disposition: inline
In-Reply-To: <54875916.7020107@thequod.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261164>

On Tue, Dec 09, 2014 at 09:18:30PM +0100, Daniel Hahler wrote:

> I'm wondering why the built-in patterns (defined in userdiff.c) are not
> being applied by default, e.g. what you would normally do in
> core.attributesfile via:
> 
>     *.py diff=python
> 
> Wouldn't it make sense to provide certain defaults for attributes, where
> Git provides enhanced patterns?

It's been discussed:

  http://thread.gmane.org/gmane.comp.version-control.git/187269

It ended up with a lot of back-and-forth over which extensions belonged
to which type, and whether the C funcname pattern was terrible or not. I
got sick of it and dropped the patch.

You are welcome to try resurrecting it. :) It might help to read the
discussion and drop any contentious names. Since that thread, the C/C++
pattern has improved greatly, so it might not meet so much resistance.

-Peff
