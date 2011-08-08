From: Jeff King <peff@peff.net>
Subject: Re: Suppressing auto-cc for specific addresses
Date: Mon, 8 Aug 2011 14:44:48 -0600
Message-ID: <20110808204448.GF18294@sigill.intra.peff.net>
References: <4E3EF38A.9010307@gmail.com>
 <20110807234634.GA3236@kroah.com>
 <CACTFLAOhApGVNZ7JsWhoHBEaQ_87stXjxkXvadmauNfhSuPD1g@mail.gmail.com>
 <D95ADFD4-2504-4BE6-BCD4-7B916F6F2FEB@gmail.com>
 <CACTFLAN0gM-xvEU32KHEsaApH4apvGUwGkiDHx06PngHUvH0Ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Aguilar <davvid@gmail.com>, Greg KH <greg@kroah.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Daniel Mack <zonque@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 08 22:45:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqWh3-0007YG-Ji
	for gcvg-git-2@lo.gmane.org; Mon, 08 Aug 2011 22:45:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753878Ab1HHUo4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Aug 2011 16:44:56 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34275
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753418Ab1HHUo4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2011 16:44:56 -0400
Received: (qmail 30013 invoked by uid 107); 8 Aug 2011 20:45:31 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 08 Aug 2011 16:45:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Aug 2011 14:44:48 -0600
Content-Disposition: inline
In-Reply-To: <CACTFLAN0gM-xvEU32KHEsaApH4apvGUwGkiDHx06PngHUvH0Ew@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178980>

On Mon, Aug 08, 2011 at 12:58:55PM +0200, Daniel Mack wrote:

> On Mon, Aug 8, 2011 at 12:56 PM, David Aguilar <davvid@gmail.com> wro=
te:
> > git send-email has a=C2=A0--[no-]signed-off-by-cc option and config=
uration
> > variable.=C2=A0--
>=20
> I know, but that's not the point. It about having a certain address
> metioned in a ^Cc: line inside the patch and suppress sending off
> emails to that specific address. And --suppress-cc currently only
> allows categories to be set, not addresses.

I'm kind of confused why you would mark an address as "cc", but not cc
it. Wouldn't it make sense to call the header something else?

-Peff
