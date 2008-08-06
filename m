From: Jeff King <peff@peff.net>
Subject: Re: git show doesn't respect config: diff.renames=copies
Date: Wed, 6 Aug 2008 11:25:37 -0400
Message-ID: <20080806152537.GB21233@sigill.intra.peff.net>
References: <20080806114340.GA24552@cuci.nl> <20080806140602.GA20423@sigill.intra.peff.net> <20080806141559.GA25791@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Stephen R. van den Berg" <srb@cuci.nl>, git@vger.kernel.org
To: =?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 06 17:26:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQkuZ-0005ax-Up
	for gcvg-git-2@gmane.org; Wed, 06 Aug 2008 17:26:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755366AbYHFPZl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Aug 2008 11:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755397AbYHFPZk
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Aug 2008 11:25:40 -0400
Received: from peff.net ([208.65.91.99]:1353 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755161AbYHFPZj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2008 11:25:39 -0400
Received: (qmail 32149 invoked by uid 111); 6 Aug 2008 15:25:39 -0000
Received: from lawn-128-61-21-105.lawn.gatech.edu (HELO sigill.intra.peff.net) (128.61.21.105)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 06 Aug 2008 11:25:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Aug 2008 11:25:37 -0400
Content-Disposition: inline
In-Reply-To: <20080806141559.GA25791@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91519>

On Wed, Aug 06, 2008 at 04:15:59PM +0200, Bj=C3=B6rn Steinbrink wrote:

> > $ git grep -A3 diff.renames
> > config.txt:diff.renames::
> > config.txt-     Tells git to detect renames.  If set to any boolean=
 value, it
> > config.txt-     will enable basic rename detection.  If set to "cop=
ies" or
> > config.txt-     "copy", it will detect copies, as well.
>=20
> See subject line ;-)

Heh. Yes, oops. His question makes a lot more sense now. ;)

> Works for me though. Stephen, probably the source file didn't change =
in
> the same commit. In such a case you need --find-copies-harder, and th=
at
> seems not to be configurable as the default.

I don't think it is configurable. Probably a "copiesharder" option for
diff.renames would be a sane addition.

-Peff
