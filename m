From: Jeff King <peff@peff.net>
Subject: Re: combined diff does not detect binary files and ignores -diff
 attribute
Date: Mon, 23 May 2011 19:41:31 -0400
Message-ID: <20110523234131.GB10488@sigill.intra.peff.net>
References: <BANLkTi=FtkiUjwAa7e3KAC5FF3GNxWzd3Q@mail.gmail.com>
 <4DDA618E.4030604@drmicha.warpmail.net>
 <BANLkTinu3AbTmtswn6DLQKAWdLL=gBvAqA@mail.gmail.com>
 <20110523181147.GA26035@sigill.intra.peff.net>
 <20110523201529.GA6281@sigill.intra.peff.net>
 <BANLkTikvPjO=bbhAoPCftdXzGSYtryNvzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 24 01:41:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOekk-0003aL-78
	for gcvg-git-2@lo.gmane.org; Tue, 24 May 2011 01:41:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756236Ab1EWXle convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 May 2011 19:41:34 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54915
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755659Ab1EWXld (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2011 19:41:33 -0400
Received: (qmail 25002 invoked by uid 107); 23 May 2011 23:43:37 -0000
Received: from sigill-wired.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.8)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 23 May 2011 19:43:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 May 2011 19:41:31 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTikvPjO=bbhAoPCftdXzGSYtryNvzw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174294>

On Mon, May 23, 2011 at 06:55:07PM -0400, Jay Soffian wrote:

> On Mon, May 23, 2011 at 4:15 PM, Jeff King <peff@peff.net> wrote:
> > It turned out not too bad:
> >
> > =C2=A0[1/5]: combine-diff: split header printing into its own funct=
ion
> > =C2=A0[2/5]: combine-diff: calculate mode_differs earlier
> > =C2=A0[3/5]: combine-diff: handle binary files as binary
>=20
> Tested-by: Jay Soffian <jaysoffian@gmail.com>
>=20
> In a real-world merge, png's were correctly shown as "Binary files
> differ". I also tested with "*.xib -diff" and that worked as expected=
=2E
>=20
> However, custom diff drivers (still) don't work. :-)

Yeah, I didn't add any support for that. I'm not sure what it should do=
;
custom diff drivers don't know how to handle combined diff, do they?

If you write me a test case that explains what _should_ happen, I'll se=
e
what I can do. :)

-Peff
