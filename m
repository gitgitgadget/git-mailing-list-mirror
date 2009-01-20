From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] commit: more compact summary and without extra quotes
Date: Mon, 19 Jan 2009 23:14:43 -0500
Message-ID: <20090120041443.GC30714@sigill.intra.peff.net>
References: <1232405116-2359-1-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Santi =?utf-8?B?QsOpamFy?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Tue Jan 20 05:16:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LP82B-00073I-TD
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 05:16:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754534AbZATEOt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Jan 2009 23:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754214AbZATEOt
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 23:14:49 -0500
Received: from peff.net ([208.65.91.99]:36342 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754064AbZATEOs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 23:14:48 -0500
Received: (qmail 31349 invoked by uid 107); 20 Jan 2009 04:14:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 19 Jan 2009 23:14:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Jan 2009 23:14:43 -0500
Content-Disposition: inline
In-Reply-To: <1232405116-2359-1-git-send-email-santi@agolina.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106435>

On Mon, Jan 19, 2009 at 11:45:16PM +0100, Santi B=C3=A9jar wrote:

> Original:
> [master]: created d9a5491: "foo:bar"
>=20
> While with the patch it becomes:
> [master d9a5491] foo:bar
>=20
> As discussed in the git mailing list:
>=20
> http://marc.info/?l=3Dgit&m=3D122765031208922&w=3D2

I agree with Junio that the URL is fine, but it should not _replace_ a
summary of the issue. But as for the patch itself, I think it is
sensible (and I remember wondering at some point what had become of you=
r
proposal, since everybody seemed to like it).

-Peff
