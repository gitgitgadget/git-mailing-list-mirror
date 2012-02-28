From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation: use {asterisk} in rev-list-options.txt
 when needed
Date: Tue, 28 Feb 2012 14:45:51 -0500
Message-ID: <20120228194551.GC11725@sigill.intra.peff.net>
References: <1330443348-5742-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Tue Feb 28 20:46:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2Szs-0002Un-4m
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 20:46:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030303Ab2B1Tpz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Feb 2012 14:45:55 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60442
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030299Ab2B1Tpy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 14:45:54 -0500
Received: (qmail 13994 invoked by uid 107); 28 Feb 2012 19:45:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 28 Feb 2012 14:45:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Feb 2012 14:45:51 -0500
Content-Disposition: inline
In-Reply-To: <1330443348-5742-1-git-send-email-cmn@elego.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191777>

On Tue, Feb 28, 2012 at 04:35:48PM +0100, Carlos Mart=C3=ADn Nieto wrot=
e:

> Text between to '*' is emphasized in AsciiDoc which made the

s/to/two/

> glob-related explanations in rev-list-options.txt very confusing, as
> the rendered text would be missing two asterisks and the text between
> them would be emphasized instead.
>=20
> Use '{asterisk}' where needed to make them show up as asterisks in th=
e
> rendered text.
> [...]
> -	'*', or '[', '/*' at the end is implied.
> +	'{asterisk}', or '[', '/{asterisk}' at the end is implied.

Ugh. I hate asciidoc more with each passing year. Readable source
documents are such a wonderful idea, but the markup makes it less and
less readable as we accumulate fixes like this.  I wonder if this has
always been a bug, or something that appeared in more recent versions o=
f
the toolchain.

Anyway, that is not a problem with your patch. :) I confirmed that the
bug happens in my version of the toolchain, and your fix works (I also
tried using `*`, but backtick does not suppress markup. It would be nic=
e
if there was an easy marker for "this is a literal name: no markup, tt
font, etc", but I don't think that exists).

Acked-by: Jeff King <peff@peff.net>

-Peff
