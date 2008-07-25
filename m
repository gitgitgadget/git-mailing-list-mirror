From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Avoid warning when From: is encoded
Date: Fri, 25 Jul 2008 14:38:57 -0400
Message-ID: <20080725183857.GE4375@sigill.intra.peff.net>
References: <1216991208-18782-1-git-send-email-4ux6as402@sneakemail.com> <7vhcadudmz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Valdemar =?utf-8?B?TcO4cmNo?= <4ux6as402@sneakemail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 20:40:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMSCv-0004v6-Ew
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 20:40:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751757AbYGYSjA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jul 2008 14:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751817AbYGYSjA
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 14:39:00 -0400
Received: from peff.net ([208.65.91.99]:2484 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751739AbYGYSi7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 14:38:59 -0400
Received: (qmail 3178 invoked by uid 111); 25 Jul 2008 18:38:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 25 Jul 2008 14:38:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Jul 2008 14:38:57 -0400
Content-Disposition: inline
In-Reply-To: <7vhcadudmz.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90086>

On Fri, Jul 25, 2008 at 09:33:56AM -0700, Junio C Hamano wrote:

> > In commit 0706bd19ef9b41e7519df2c73796ef93484272fd $1 is used from =
a regexp
> > without using () to set up $1. Later, when that value was used, it =
caused a
> > warning about a variable being undefined.
> >
> > Signed-off-by: Peter Valdemar M=C3=B8rch <peter@morch.com>
>=20
> Thanks.  The patch is obviously correct; I think you are fixing 8291d=
b6
> (git-send-email: add charset header if we add encoded 'From', 2007-11=
-16),
> not 0706bd1 (send-email: specify content-type of --compose body,
> 2008-03-28).
>=20
> Will apply to maint and merge upwards.

Discussions about who can ACK this code aside, the original bogosity wa=
s
totally mine, so

  Acked-by: Jeff King <peff@peff.net>

-Peff
