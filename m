From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: git show doesn't respect config: diff.renames=copies
Date: Wed, 6 Aug 2008 16:15:59 +0200
Message-ID: <20080806141559.GA25791@atjola.homenet>
References: <20080806114340.GA24552@cuci.nl> <20080806140602.GA20423@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Stephen R. van den Berg" <srb@cuci.nl>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 06 16:17:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQjpA-00015R-CA
	for gcvg-git-2@gmane.org; Wed, 06 Aug 2008 16:17:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754877AbYHFOQI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Aug 2008 10:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754858AbYHFOQG
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Aug 2008 10:16:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:43995 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754733AbYHFOQD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2008 10:16:03 -0400
Received: (qmail invoked by alias); 06 Aug 2008 14:16:02 -0000
Received: from i577BB2E2.versanet.de (EHLO atjola.local) [87.123.178.226]
  by mail.gmx.net (mp013) with SMTP; 06 Aug 2008 16:16:02 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18aSTZg6REa1XCHCwEV8stcT36tQsKW7A3SXE7ZXS
	UWlNNbB5VrDwRY
Content-Disposition: inline
In-Reply-To: <20080806140602.GA20423@sigill.intra.peff.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91513>

On 2008.08.06 10:06:03 -0400, Jeff King wrote:
> On Wed, Aug 06, 2008 at 01:43:40PM +0200, Stephen R. van den Berg wro=
te:
>=20
> > What do I need to enter in /etc/gitconfig to get all commands that
> > deal with diffs of some kind to honour renames=3Dcopies ?
>=20
> $ git grep -A3 diff.renames
> config.txt:diff.renames::
> config.txt-     Tells git to detect renames.  If set to any boolean v=
alue, it
> config.txt-     will enable basic rename detection.  If set to "copie=
s" or
> config.txt-     "copy", it will detect copies, as well.

See subject line ;-)

Works for me though. Stephen, probably the source file didn't change in
the same commit. In such a case you need --find-copies-harder, and that
seems not to be configurable as the default.

Bj=F6rn
