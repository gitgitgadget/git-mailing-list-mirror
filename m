From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation: quote double-dash in "<commit> --
 <filename>" for AsciiDoc
Date: Tue, 28 Jun 2011 18:47:17 -0400
Message-ID: <20110628224717.GC4192@sigill.intra.peff.net>
References: <20110628171748.GA11485@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 29 00:47:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qbh44-0003X9-A0
	for gcvg-git-2@lo.gmane.org; Wed, 29 Jun 2011 00:47:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752116Ab1F1WrX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jun 2011 18:47:23 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39051
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751777Ab1F1WrT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2011 18:47:19 -0400
Received: (qmail 11209 invoked by uid 107); 28 Jun 2011 22:47:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 28 Jun 2011 18:47:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Jun 2011 18:47:17 -0400
Content-Disposition: inline
In-Reply-To: <20110628171748.GA11485@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176429>

On Tue, Jun 28, 2011 at 12:17:49PM -0500, Jonathan Nieder wrote:

> As explained in v1.7.3-rc0~13^2 (Work around em-dash handling in newer
> AsciiDoc, 2010-08-23), outside of verbatim environments, newish
> versions of AsciiDoc will convert double hyphens to en dashes.  Use
> the litdd syntax introduced by that patch to avoid such misformatting
> in sentences where "--" represents the two-character "end of options"
> argument that separates revision names from filename patterns.

Ugh. I just did a similar thing for "->". I really wish asciidoc would
not expand symbols inside backticks in paragraph mode.

> -to that of the last commit with `git reset HEAD -- <file>`,
> +to that of the last commit with `git reset HEAD {litdd} <file>`,

Does \-- work? That seems way more readable to me for people viewing the
source.

-Peff
