From: Jeff King <peff@peff.net>
Subject: Re: Broken umlaut in my name, again
Date: Mon, 6 Apr 2009 12:47:33 -0400
Message-ID: <20090406164732.GA11724@sigill.intra.peff.net>
References: <20090331153039.GA1520@atjola.homenet> <20090406114618.GF20356@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marius Storm-Olsen <marius@trolltech.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 06 18:49:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqs0T-0003aa-Ut
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 18:49:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752029AbZDFQri convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Apr 2009 12:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751885AbZDFQrh
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 12:47:37 -0400
Received: from peff.net ([208.65.91.99]:54117 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751879AbZDFQrh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 12:47:37 -0400
Received: (qmail 25089 invoked by uid 107); 6 Apr 2009 16:47:55 -0000
Received: from 97-81-69-92.dhcp.athn.ga.charter.com (HELO sigill.intra.peff.net) (97.81.69.92)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 06 Apr 2009 12:47:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Apr 2009 12:47:33 -0400
Content-Disposition: inline
In-Reply-To: <20090406114618.GF20356@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115853>

On Mon, Apr 06, 2009 at 01:46:18PM +0200, Bj=C3=B6rn Steinbrink wrote:

> On 2009.03.31 17:30:39 +0200, Bj=C3=B6rn Steinbrink wrote:
> > While it makes no sense to map some email address to an empty one, =
doing
> > things the other way around can be useful. For example when using
> > filter-branch with an env-filter that employs a mailmap to fix up a=
n
> > import that created such broken commits with empty email addresses.
> >=20
> > Signed-off-by: Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de>
>=20
> The umlaut (=C3=B6) in my name is broken in the commit that made it i=
nto
> git.git --> 5288dd58356e53d61e2b3804fc7d8d23c3a46ab3

The mail you sent that presumably became 5288dd58 looks fine (both the
=46rom and body are properly marked as iso8859-1), and "git am" applies=
 it
correctly here. I wonder if Junio did something unusual while applying.

-Peff
