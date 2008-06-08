From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] git-commit.txt: Correct option alternatives
Date: Sun, 8 Jun 2008 00:23:56 -0400
Message-ID: <20080608042356.GA11194@sigill.intra.peff.net>
References: <200806070534.45761.chriscool@tuxfamily.org> <1212836805-20684-1-git-send-email-s-beyer@gmx.net> <484B37B6.1040408@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stephan Beyer <s-beyer@gmx.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Jon Loeliger <jdl@freescale.com>
X-From: git-owner@vger.kernel.org Sun Jun 08 06:25:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5CT5-0000lB-4n
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 06:25:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbYFHEYA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 00:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbYFHEYA
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 00:24:00 -0400
Received: from peff.net ([208.65.91.99]:4873 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750771AbYFHEX7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 00:23:59 -0400
Received: (qmail 13657 invoked by uid 111); 8 Jun 2008 04:23:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 08 Jun 2008 00:23:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 08 Jun 2008 00:23:56 -0400
Content-Disposition: inline
In-Reply-To: <484B37B6.1040408@freescale.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84252>

On Sat, Jun 07, 2008 at 08:36:54PM -0500, Jon Loeliger wrote:

>> Furthermore, for long-option consistency --author <author>
>> is changed to --author=<author>.
> Say, if we were to document and espouse one form over the other,
> which would you recommend or prefer?

$ sed -ne '/sticked/,/^$/p' Documentation/gitcli.txt
 * when a command line option takes an argument, use the 'sticked' form.  In
   other words, write `"git foo -oArg"` instead of `"git foo -o Arg"` for short
   options, and `"git foo --long-opt=Arg"` instead of `"git foo --long-opt Arg"`
   for long options.  An option that takes optional option-argument must be
   written in the 'sticked' form.

'sticked' form must be used:
----------------------------
$ git describe --abbrev HEAD     # correct
$ git describe --abbrev=10 HEAD  # correct
$ git describe --abbrev 10 HEAD  # NOT WHAT YOU MEANT
----------------------------

-Peff
