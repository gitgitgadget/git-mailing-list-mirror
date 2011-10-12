From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation: update [section.subsection] to reflect
 what git does
Date: Wed, 12 Oct 2011 14:34:51 -0400
Message-ID: <20111012183451.GB14543@sigill.intra.peff.net>
References: <1318434726-5556-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Wed Oct 12 20:34:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RE3dp-00055F-QZ
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 20:34:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753450Ab1JLSex convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Oct 2011 14:34:53 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58673
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752002Ab1JLSex (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2011 14:34:53 -0400
Received: (qmail 13762 invoked by uid 107); 12 Oct 2011 18:34:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 12 Oct 2011 14:34:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Oct 2011 14:34:51 -0400
Content-Disposition: inline
In-Reply-To: <1318434726-5556-1-git-send-email-cmn@elego.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183388>

On Wed, Oct 12, 2011 at 05:52:06PM +0200, Carlos Mart=C3=ADn Nieto wrot=
e:

> -There is also a case insensitive alternative `[section.subsection]` =
syntax.
> -In this syntax, subsection names follow the same restrictions as for=
 section
> -names.
> +There is also a deprecated `[section.subsection]` syntax. With this
> +syntax, the subsection name is converted to lower-case and is also
> +compared case sensitively. These subsection names follow the same
> +restrictions as section names.

OK, now having looked thoroughly at the problem again, I agree that you=
r
documentation update is much better than the one I posted earlier
(technically we could still talk about canonicalizing the subsection
earlier in git-config(1), but section.foo names are the deprecated
minority, so it's probably not worth cluttering the page with
explanations).

I do think the "compared case sensitively" bit is a little confusing
here, because it's not clear what is being compared here (as we're quit=
e
deep into a discussion of the file format, and away from the git-config
usage). It might be more clear to say:

  With this syntax, the subsection name is converted to lower-case, and
  the result is compared case sensitively against the subsection name
  provided to git-config.

or something like that.

-Peff
